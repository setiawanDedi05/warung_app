import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:warung_app/pages/auth/login.dart';
import 'package:warung_app/pages/home_page.dart';
import 'package:warung_app/services/auth.dart';

class RegisterPage extends StatefulWidget {
  static const routeName = "/register";
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? message = "";
  bool isLogin = true;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  Future<void> signUpWithEmailAndPassword() async {
    try {
      await Auth().signUpWithEmailAndPassword(
          email: _email.text, password: _password.text);
      Navigator.of(context).pushNamed(HomePage.routeName);
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
          fillColor: Colors.white10),
      obscureText: secure == null ? false : true,
    );
  }

  Widget _errorMessage() {
    return Text(
      message == "" ? "" : "Hmmm..${message!}",
      style: const TextStyle(color: Colors.red),
    );
  }

  Widget _loginButton() {
    return ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushNamed(LoginPage.pageName);
        },
        child: Text("Sudah Punya Akun? Ayo Login"));
  }

  Widget _submitButton() {
    return ElevatedButton(
        onPressed: () {
          signUpWithEmailAndPassword();
        },
        child: const Text("Register"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Pendaftaran Akun"),
        ),
        body: Center(
          child: Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 50),
              height: 270,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _entryField(title: 'Email', controller: _email),
                  _entryField(
                      title: "Password", controller: _password, secure: true),
                  _errorMessage(),
                  SizedBox(
                    height: 10,
                  ),
                  _submitButton()
                ],
              ),
            ),
          ),
        ));
  }
}
