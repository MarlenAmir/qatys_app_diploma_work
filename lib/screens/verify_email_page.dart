import 'dart:async';

import 'package:diploma_work/screens/HomePage.dart';
import 'package:diploma_work/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class verifyEmail extends StatefulWidget {
  const verifyEmail({super.key});

  @override
  State<verifyEmail> createState() => _verifyEmailState();
}

class _verifyEmailState extends State<verifyEmail> {
  bool isEmailVerified = false;
  Timer? timer;
  bool canResendEmail = false;

  @override
  void initState() {
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    super.initState();

    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(Duration(seconds: 3), (_) {
        checkEmailVerified();
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() {
        canResendEmail = false;
      });
      await Future.delayed(Duration(seconds: 5));
      setState(() {
        canResendEmail = true;
      });
    } catch (e) {
      Utils.showSnackBar(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? HomePage()
      : Scaffold(
          body: Column(children: [
            Container(
              child: Image.asset('images/logo.png'),
            ),
            SizedBox(height: 20),
            Text(
              'Qatys',
              style: TextStyle(
                  color: Color(0xFFDEC800),
                  fontSize: 36,
                  fontWeight: FontWeight.normal),
            ),
           
            SizedBox(height: 10),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 20),
              child: Text(
                'Сообщение для верификации вашей почты были отправлены на ваш E-mail, \nпожалуйста проверьте свою почту!',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF000000)),
              ),
            ),
            SizedBox(height: 20,),
            Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xFF7D82FF),
                  ),
                  width: 370,
                  child: TextButton(
                      onPressed: () {
                        canResendEmail ? sendVerificationEmail() : null;
                      },
                      child: Text(
                        'Отправить снова',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 20),
                      )),
                ),
                SizedBox(height: 20,),
                Container(
                  width: 370,
                  child: TextButton(
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                      },
                      child: Text(
                        'Отменить',
                        style: TextStyle(
                            color: Color(0xFF7D82FF),
                            fontWeight: FontWeight.normal,
                            fontSize: 20),
                      )),
                ),
          ]),
        );
}
