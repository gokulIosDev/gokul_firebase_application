import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gokul_firebase_application/repository/screens/signInScreen.dart';
import 'package:gokul_firebase_application/repository/widgets/uihelper/uihelper.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up Screen"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Sign Up",
            style: TextStyle(color: Colors.black, fontSize: 25),
          ),
          UiHelper.CustomTextFiels(
              controller: emailController,
              text: "Enter Email",
              icon: Icons.email),
          UiHelper.CustomTextFiels(
              controller: passwordController,
              text: "Enter Password",
              icon: Icons.password),
          ElevatedButton(
              onPressed: () {
                signUp(
                    email: emailController.text.toString(),
                    password: passwordController.text.toString());
              },
              child: const Text("Sign Up"))
        ],
      ),
    );
  }

  Future signUp({required String email, required String password}) async {
    if (email == "" || password == "") {
      return UiHelper.CustomSnackBar(
          text: "Enter Required Field", context: context);
    } else {
      UserCredential? userCredential;
      try {
        userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) {
          log("User Created ${value.user!.uid.toString()}");
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SignInScreen()));
        });
      } on FirebaseAuthException catch (ex) {
        return UiHelper.CustomSnackBar(
            text: ex.code.toString(), context: context);
      }
    }
  }
}
