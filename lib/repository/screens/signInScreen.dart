import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gokul_firebase_application/repository/widgets/uihelper/uihelper.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign In Screen"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Sign In", style: TextStyle(color: Colors.black, fontSize: 25),),
          UiHelper.CustomTextFiels(
              controller: emailController,
              text: "Enter Email",
              icon: Icons.email),
          UiHelper.CustomTextFiels(
              controller: passwordController,
              text: "Enter Password",
              icon: Icons.password),
          ElevatedButton(onPressed: () {
            signIn(email: emailController.text.toString(), password: passwordController.text.toString());
          }, child: const Text("Sign In"))
        ],
      ),
    );
  }

  Future signIn({required String email, required String password}) async {
    if (email == "" || password == "") {
      return UiHelper.CustomSnackBar(
          text: "Enter Required Field", context: context);
    } else {
      UserCredential? userCredential;
      try {
        userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password)
            .then((value) {
          return UiHelper.CustomSnackBar(
              text: value.user!.email.toString(), context: context);
        });
      } on FirebaseAuthException catch (ex) {}
    }
  }
}
