import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:diploma_work/main.dart';
import 'package:diploma_work/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterService {
  RegisterService(this.context);

  final BuildContext context;

  final formKey = GlobalKey<FormState>();

  TextEditingController emailTextInputController = TextEditingController();
  TextEditingController passwordTextInputController = TextEditingController();
  TextEditingController phoneTextController = TextEditingController();
  TextEditingController nameTextController = TextEditingController();
  TextEditingController surnameTextController = TextEditingController();

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
        email: emailTextInputController.text,
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
