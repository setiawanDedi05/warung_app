import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:warung_app/pages/account_page.dart';
import 'package:warung_app/pages/barang_page.dart';
import 'package:warung_app/pages/home_widget_page.dart';
import 'package:warung_app/pages/laporan_page.dart';
import 'package:warung_app/pages/transaction_page.dart';
import 'package:warung_app/pages/searching_page.dart';
import 'package:warung_app/services/auth.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/home";
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final User? user = Auth().currentUser;
  int _selectedIndex = 0;
  final List<Widget> screens = [
    const HomeWidget(),
    const BarangPage(),
    const TransactionPage(),
    SearchingPage(),
    const LaporanPage(),
    const AccountPages()
  ];

  Future<void> signOut() async {
    await Auth().signOut();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: screens[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.data_saver_on), label: "Barang"),
          BottomNavigationBarItem(icon: Icon(Icons.swap_vert), label: "Transaction"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Cari"),
          BottomNavigationBarItem(icon: Icon(Icons.report), label: "Laporan"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
      ),
    );
  }
}
