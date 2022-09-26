import 'package:flutter/material.dart';
import 'package:warung_app/pages/auth/login.dart';
import 'package:warung_app/pages/home_page.dart';
import 'package:warung_app/services/auth.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return const HomePage();
        }else{
          return const LoginPage();
        }
      },
    );
  }
}