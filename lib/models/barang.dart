import 'package:cloud_firestore/cloud_firestore.dart';

class Barang {
  String? id, nama_barang, kategori;
  double? harga;

  Barang({this.harga, this.id, this.kategori, this.nama_barang});

  List<Barang> dataListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((snapshot) {
      final Map<String, dynamic> dataMap =
          snapshot.data() as Map<String, dynamic>;
      return Barang(
        nama_barang: dataMap['nama_barang'],
        harga: dataMap['harga'],
        kategori: dataMap['kategori'],
      );
    }).toList();
  }
}
