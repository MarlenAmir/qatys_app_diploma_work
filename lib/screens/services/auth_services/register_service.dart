import 'package:diploma_work/screens/auth_pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:diploma_work/main.dart';
import 'package:diploma_work/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterService {
  RegisterService({required this.context, required this.emailTextInputController, required this.passwordTextInputController, required this.nameTextController, required this.surnameTextController, required this.phoneTextController});

  final BuildContext context;

  final formKey = GlobalKey<FormState>();

  RegisterPage registerPage = RegisterPage();

  final TextEditingController emailTextInputController;
    final TextEditingController passwordTextInputController;

  final TextEditingController nameTextController;

  final TextEditingController surnameTextController;

  final TextEditingController phoneTextController;


  

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));

    try {
      final auth = FirebaseAuth.instance;
      final UserCredential userCredential =
          await auth.createUserWithEmailAndPassword(
        email:  emailTextInputController.text,
        password: passwordTextInputController.text,
      );

      final String uid = userCredential.user!.uid;
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore.collection('users').doc(uid).set({
        'name': nameTextController.text,
        'surname': surnameTextController.text,
        'email': emailTextInputController.text,
        'phone_number': phoneTextController.text,
      });
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
