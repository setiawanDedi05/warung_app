import 'package:firestore_search/firestore_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warung_app/models/barang.dart';
import 'package:warung_app/providers/barang.dart';

class SearchingPage extends StatefulWidget {
  static const routeName = "/search-barang";

  @override
  State<SearchingPage> createState() => _SearchingPageState();
}

class _SearchingPageState extends State<SearchingPage> {
  @override
  Widget build(BuildContext context) {
    final barangProvider = Provider.of<Barangs>(context);

    return Scaffold(
        appBar: AppBar(
            title: FirestoreSearchBar(
          tag: 'searchBar',
        )),
        body: Container(
          child: FirestoreSearchResults.builder(
            tag: 'searchBar',
            firestoreCollectionName: 'barang',
            searchBy: 'nama_barang',
            initialBody: const Center(
              child: Text("Ketik Aja yang Kamu ingin cari "),
            ),
            dataListFromSnapshot: Barang().dataListFromSnapshot,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List<Barang>? dataList = snapshot.data;
                if (dataList!.isEmpty) {
                  return const Center(
                    child: Text("Data Kosong"),
                  );
                }
                return ListView.builder(
                  itemCount: dataList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Barang data = dataList[index];
                    return ListTile(
                      leading: CircleAvatar(
                        child:
                            Image.asset("assets/images/logo_kecil_putih.png"),
                      ),
                      title: Text(
                        data.nama_barang!,
                      ),
                      trailing: Text(data.harga!.toString()),
                    );
                  },
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: Text("Data Kosong"),
                  );
                }
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ));
  }
}
