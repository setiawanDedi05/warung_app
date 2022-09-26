import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:warung_app/pages/auth/login.dart';
import 'package:warung_app/services/auth.dart';

class AccountPages extends StatefulWidget {
  const AccountPages({super.key});

  @override
  State<AccountPages> createState() => _AccountPagesState();
}

class _AccountPagesState extends State<AccountPages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account"),
        centerTitle: false,
      ),
      body: Center(
        child: Container(
          child: ElevatedButton(
            onPressed: () {
              Auth().signOut();
              Navigator.of(context).pushNamed(LoginPage.pageName);
            },
            child: Text("Sign Out"),
          ),
        ),
      ),
    );
  }
}
