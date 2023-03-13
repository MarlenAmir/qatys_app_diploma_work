import 'package:diploma_work/screens/HomePage.dart';
import 'package:diploma_work/screens/landing.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:diploma_work/screens/LoginPage.dart';
import 'package:diploma_work/utils/utils.dart';

  void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}


final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: Utils.messengerKey,
      navigatorKey: navigatorKey,
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => Landing(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/second': (context) => HomePage(),
      },
    );
  }
}
