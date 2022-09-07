import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/barang.dart';

class DetailBarang extends StatelessWidget {
  static const routeName = "/detail-player";

  @override
  Widget build(BuildContext context) {
    final barang = Provider.of<Barangs>(context, listen: false);
    // final barangId = ModalRoute.of(context).settings.arguments as String;
    // final selectPLayer = barang.selectById(barangId);
    final TextEditingController kategoriController =
        TextEditingController(text: "");
    final TextEditingController namaBarangController =
        TextEditingController(text: "");
    final TextEditingController hargaController =
        TextEditingController(text: "");
    return Scaffold(
      appBar: AppBar(
        title: Text("DETAIL BARANG"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(kategoriController.text),
                    ),
                  ),
                ),
              ),
              TextFormField(
                autocorrect: false,
                autofocus: true,
                decoration: const InputDecoration(labelText: "Nama Barang"),
                textInputAction: TextInputAction.next,
                controller: namaBarangController,
              ),
              TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Harga Barang"),
                textInputAction: TextInputAction.next,
                controller: hargaController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: const InputDecoration(labelText: "Kategori"),
                textInputAction: TextInputAction.done,
                controller: kategoriController,
                onEditingComplete: () {},
              ),
              const SizedBox(height: 50),
              Container(
                width: double.infinity,
                alignment: Alignment.centerRight,
                child: OutlinedButton(
                  onPressed: () {},
                  child: const Text(
                    "Edit",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
