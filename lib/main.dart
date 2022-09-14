import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warung_app/pages/add_barang_page.dart';
import 'package:warung_app/pages/searching_page.dart';
import 'package:warung_app/pages/splash.dart';
import 'package:warung_app/providers/barang.dart';
import './pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(Duration(seconds: 3)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SplashScreen();
          } else {
            return ChangeNotifierProvider(
              create: (context) => Barangs(),
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                home: HomePage(),
                routes: {
                  HomePage.routeName: (context) => HomePage(),
                  AddBarang.routeName: (context) => AddBarang(),
                  SearchingPage.routeName: (context) => SearchingPage(),
                },
              ),
            );
          }
        });
  }
}
