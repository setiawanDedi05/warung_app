import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warung_app/pages/searching_page.dart';
import 'package:warung_app/providers/barang.dart';
import 'add_barang_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final barangProvider = Provider.of<Barangs>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Semua Barang"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, AddBarang.routeName);
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(context, SearchingPage.routeName);
            },
          ),
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('barang').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text("Error"),
              );
            }
            if (!snapshot.hasData) {
              return const Center(
                child: Text("Data Kosong"),
              );
            }
            if (snapshot.connectionState == ConnectionState.active) {
              // ignore: avoid_print
              return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  final docData =
                      snapshot.data!.docs[index].data() as Map<String, dynamic>;
                  return ListTile(
                    leading: CircleAvatar(
                      child: Image.asset("assets/images/logo_kecil_putih.png"),
                    ),
                    title: Text(
                      docData["nama_barang"],
                    ),
                    subtitle: Text(docData["harga"].toString()),
                    trailing: IconButton(
                      onPressed: () {
                        barangProvider.deleteBarang(
                            snapshot.data!.docs[index].reference.id);
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  );
                },
              );
            }
            return const Text("Loading");
          }),
    );
  }
}
