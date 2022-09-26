import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:warung_app/pages/auth/register.dart';
import 'package:warung_app/services/auth.dart';

class LoginPage extends StatefulWidget {
  static String pageName = '/login';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? message = "";
  bool isLogin = true;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
          email: _email.text, password: _password.text);
    } on FirebaseException catch (e) {
      setState(() {
        message = e.message;
      });
    }
  }

  Widget _entryField(
      {required String title,
      required TextEditingController controller,
      bool? secure}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
        labelStyle: TextStyle(color: Colors.black38),
        fillColor: Colors.white10
      ),
      obscureText: secure == null ? false : true,
    );
  }

  Widget _errorMessage() {
    return Text(
      message == "" ? "" : "Hmmm..${message!}",
      style: const TextStyle(color: Colors.red),
    );
  }

  Widget _registerButton(){
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).pushNamed(RegisterPage.routeName);
      },
      child: Text("Tidak Punya akun? Register"));
  }

  Widget _submitButton() {
    return ElevatedButton(
        onPressed: () {
          signInWithEmailAndPassword();
        },
        child: const Text("Login"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 50),
          height: 300,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _entryField(title: "Email", controller: _email),
              _entryField(
                  title: "password", controller: _password, secure: true),
              const SizedBox(
                height: 10,
              ),
              _errorMessage(),
              _submitButton(),
              _registerButton()
            ],
          ),
        ),
      ),
    );
  }
}
