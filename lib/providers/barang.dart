import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../models/barang.dart';

class Barangs with ChangeNotifier {
  final databaseRef =
      FirebaseFirestore.instance.collection('barang').snapshots();
  List<Barang> _allBarang = [];
  List<Barang> _foundBarang = [];

  List<Barang> get allBarang => _allBarang;
  List<Barang> get foundBarang => _foundBarang;

  int get jumlahBarang => _allBarang.length;

  Barang selectById(String id) =>
      _allBarang.firstWhere((element) => element.id == id);

  Future<void> addBarang(String nama_barang, String kategori, double harga) {
    return FirebaseFirestore.instance.collection('barang').add({
      "nama_barang": nama_barang,
      "kategori": kategori,
      "harga": harga,
    }).then((value) {
      _allBarang.add(
        Barang(
          id: jsonDecode(value.id).toString(),
          nama_barang: nama_barang,
          kategori: kategori,
          harga: harga,
        ),
      );
      notifyListeners();
    });
  }

  Future<void> deleteBarang(String id, BuildContext context) {
    return FirebaseFirestore.instance.collection('barang').doc(id).delete().then((value) {
      showTopSnackBar(
        context,
        const CustomSnackBar.success(
          message: "Data Terhapus",
        ),
      );
    });
  }

  Future<void> updateBarang(String id, Barang data) {
    return FirebaseFirestore.instance.collection('barang').doc(id).update({
      "nama_barang": data.nama_barang,
      "kategori": data.kategori,
      "harga": data.harga
    });
  }

  runFilter(String inputKeyword) {
    List<Barang> results = [];
    if (inputKeyword.isEmpty) {
      results = allBarang;
    } else {
      results = allBarang.where((item) {
        return item.nama_barang
            .toString()
            .toLowerCase()
            .contains(inputKeyword.toLowerCase());
      }).toList();
      _foundBarang = results;
      notifyListeners();
    }
  }
}
