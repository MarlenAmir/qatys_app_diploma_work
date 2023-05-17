import 'package:diploma_work/screens/HomePage.dart';
import 'package:diploma_work/screens/LoginPage.dart';
import 'package:diploma_work/screens/RegisterPage.dart';
import 'package:diploma_work/screens/verify_email_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override


  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError){
            return Center(child: Text('Something went wrong!'),);
          }
          else if(snapshot.hasData){
            return verifyEmail();
          }
          else{
            return LoginPage();
          }
        },
      ),
    );
  }
}
