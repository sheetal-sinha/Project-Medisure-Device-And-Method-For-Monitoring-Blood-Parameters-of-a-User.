import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:medisure/login_page.dart';
import 'package:medisure/uihelper.dart';
import 'package:medisure/firestore.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});
  State<Signup> createState() => _SignupState();
}

final FirestoreService firestoreService = FirestoreService();

class _SignupState extends State<Signup> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  signUp(String email, String password) async {
    if (email == "" && password == "") {
      UiHelper.CustomAlertBox(context, "Enter Required Fields");
    } else {
      UserCredential? usercredential;
      try {
        usercredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) {
          firestoreService.addUser(email, "", "", "", "","");
          UiHelper.CustomAlertBox(context, 'Sign-up success');
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
          UiHelper.CustomAlertBox(context, 'User Created');
        });
      } on FirebaseAuthException catch (ex) {
        return UiHelper.CustomAlertBox(context, 'User already exists');
      }
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up Page'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UiHelper.CustomTextField(emailController, 'Email', Icons.mail, false),
          UiHelper.CustomTextField(
              passwordController, 'Password', Icons.password, true),
          SizedBox(height: 30),
          UiHelper.CustomButton(() {
            signUp(emailController.text.toString(),
                passwordController.text.toString());
          }, "Sign Up")
        ],
      ),
    );
  }
}
