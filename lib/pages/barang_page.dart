import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:warung_app/models/barang.dart';
import 'package:warung_app/pages/add_barang_page.dart';
import 'package:warung_app/pages/searching_page.dart';
import 'package:warung_app/providers/barang.dart';

class BarangPage extends StatefulWidget {
  const BarangPage({super.key});

  @override
  State<BarangPage> createState() => _BarangPageState();
}

class _BarangPageState extends State<BarangPage> {
  final TextEditingController _kategoriController = TextEditingController();
  final TextEditingController _namaBarangController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final barangProvider = Provider.of<Barangs>(context, listen: false);
    Future<void> _update([DocumentSnapshot? snapshot]) async {
      if (snapshot != null) {
        _kategoriController.text = snapshot["kategori"];
        _namaBarangController.text = snapshot["nama_barang"];
        _hargaController.text = snapshot["harga"].toString();
      }
      await showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _namaBarangController,
                    decoration: const InputDecoration(labelText: 'Nama Barang'),
                  ),
                  TextField(
                    controller: _kategoriController,
                    decoration: const InputDecoration(labelText: 'Kategori'),
                  ),
                  TextField(
                    controller: _hargaController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(labelText: "Harga"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        barangProvider.updateBarang(
                          snapshot!.id,
                          Barang(
                              harga: double.parse(_hargaController.text),
                              nama_barang: _namaBarangController.text,
                              kategori: _kategoriController.text),
                        );
                        Navigator.pop(context);
                        showTopSnackBar(
                          context,
                          const CustomSnackBar.success(
                            message: "Data Terupdate",
                          ),
                        );
                      },
                      child: const Text("Update")),
                ],
              ),
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Semua Barang"),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, AddBarang.routeName);
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
                  final DocumentSnapshot documentSnapshot =
                      snapshot.data!.docs[index];
                  final docData =
                      snapshot.data!.docs[index].data() as Map<String, dynamic>;
                  return GestureDetector(
                    onTap: () {
                      _update(documentSnapshot);
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        child:
                            Image.asset("assets/images/logo_kecil_putih.png"),
                      ),
                      title: Text(
                        docData["nama_barang"],
                      ),
                      subtitle: Text(docData["harga"].toString()),
                      trailing: IconButton(
                        onPressed: () {
                          barangProvider.deleteBarang(
                              snapshot.data!.docs[index].reference.id, context);
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ),
                  );
                },
              );
            }
            return const CircularProgressIndicator();
          }),
    );
  }
}
