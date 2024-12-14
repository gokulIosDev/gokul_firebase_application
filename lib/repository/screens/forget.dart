import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gokul_firebase_application/repository/widgets/uihelper/uihelper.dart';

class ForgetPassWord extends StatefulWidget {
  const ForgetPassWord({super.key});

  @override
  State<ForgetPassWord> createState() => _ForgetPassWordState();
}

class _ForgetPassWordState extends State<ForgetPassWord> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forget Password"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UiHelper.CustomTextFiels(
              controller: emailController,
              text: "Enter Email",
              icon: Icons.email),
          ElevatedButton(
              onPressed: () {
                forget(email: emailController.text.toString());
              },
              child: Text("Send Mail"))
        ],
      ),
    );
  }

  Future forget({required String email}) async {
    if (email == "") {
      return UiHelper.CustomSnackBar(
          text: "Enter Required Field", context: context);
    } else {
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: email)
            .then((value) {
          return UiHelper.CustomSnackBar(
              text: "Otp send to $email", context: context);
        });
      } on FirebaseAuthException catch (ex) {
        return UiHelper.CustomSnackBar(
            text: ex.code.toString(), context: context);
      }
    }
  }
}
