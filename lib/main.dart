import 'package:diploma_work/routes/routes.dart';
import 'package:diploma_work/screens/repository/image_provider/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:diploma_work/utils/utils.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ru_RU');
  await Firebase.initializeApp();
  Stripe.publishableKey = "pk_test_51NAFQgCj3VTzPnlvVYaDDRkUHhLcVTB5J7DjsIgWwjs5UNivfxMzV5VZekmgXEbxe1mnSqXULQPvTrxgWW0U1wSC00Xy3VKloO";
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AvatarProvider>(
        create: (_) => AvatarProvider(),
      ),
    ],
    child: const MyApp(),
  ));
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: Utils.messengerKey,
      navigatorKey: navigatorKey,
      initialRoute: '/',
      routes: routes,
    );
  }
}
