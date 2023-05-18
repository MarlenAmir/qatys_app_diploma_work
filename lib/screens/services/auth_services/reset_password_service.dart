import 'package:flutter/material.dart';
import 'package:diploma_work/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResetPasswordService {
  ResetPasswordService(this.context);
  final BuildContext context;
  final formKey = GlobalKey<FormState>();
  TextEditingController emailTextInputController = TextEditingController();

  Future resetPassword() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailTextInputController.text.trim());
      Utils.showSnackBar('Восстановление пароля отправлено на почту');
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
      Navigator.of(context).pop();
    }
  }
}
