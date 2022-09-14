import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:warung_app/pages/home_page.dart';

import '../providers/barang.dart';

class AddBarang extends StatefulWidget {
  static const routeName = "/add-player";

  @override
  State<AddBarang> createState() => _AddBarangState();
}

class _AddBarangState extends State<AddBarang> {
  final TextEditingController namaBarangController = TextEditingController();

  final TextEditingController kategoriController = TextEditingController();

  final TextEditingController hargaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final barang = Provider.of<Barangs>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Barang"),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              barang.addBarang(namaBarangController.text,
                  kategoriController.text, double.parse(hargaController.text));
              showTopSnackBar(
                context,
                const CustomSnackBar.success(
                  message: "Data Bertambah",
                ),
              );
              Navigator.pop(context);
              Navigator.pushNamed(context, HomePage.routeName);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                autocorrect: false,
                autofocus: true,
                decoration: const InputDecoration(labelText: "Nama Barang"),
                textInputAction: TextInputAction.next,
                controller: namaBarangController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: const InputDecoration(labelText: "Kategori"),
                textInputAction: TextInputAction.next,
                controller: kategoriController,
              ),
              TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Harga"),
                textInputAction: TextInputAction.done,
                controller: hargaController,
                onEditingComplete: () {
                  barang.addBarang(
                      namaBarangController.text,
                      kategoriController.text,
                      double.parse(hargaController.text));
                  showTopSnackBar(
                    context,
                    const CustomSnackBar.success(
                      message: "Data Bertambah",
                    ),
                  );
                  Navigator.pop(context);
                  Navigator.pushNamed(context, HomePage.routeName);
                },
              ),
              const SizedBox(height: 50),
              Container(
                width: double.infinity,
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    barang.addBarang(
                        namaBarangController.text,
                        kategoriController.text,
                        double.parse(hargaController.text));
                    showTopSnackBar(
                      context,
                      const CustomSnackBar.success(
                        message: "Data Bertambah",
                      ),
                    );
                    Navigator.pushNamed(context, HomePage.routeName);
                  },
                  child: const Text(
                    "Submit",
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
