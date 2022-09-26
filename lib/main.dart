import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warung_app/pages/add_barang_page.dart';
import 'package:warung_app/pages/auth/register.dart';
import 'package:warung_app/pages/home_page.dart';
import 'package:warung_app/pages/searching_page.dart';
import 'package:warung_app/pages/splash.dart';
import 'package:warung_app/providers/barang.dart';
import 'package:warung_app/widget_tree.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(const Duration(seconds: 3)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SplashScreen();
          } else {
            return ChangeNotifierProvider(
              create: (context) => Barangs(),
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                home: WidgetTree(),
                routes: {
                  HomePage.routeName: (context) => HomePage(),
                  AddBarang.routeName: (context) => AddBarang(),
                  SearchingPage.routeName: (context) => SearchingPage(),
                  RegisterPage.routeName: (context) => RegisterPage()
                },
              ),
            );
          }
        });
  }
}
