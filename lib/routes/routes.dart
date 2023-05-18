import 'package:diploma_work/screens/auth_pages/view.dart';
import 'package:diploma_work/screens/main_pages/view.dart';
import 'package:diploma_work/screens/categories/view.dart';

final routes = {
  '/': (context) => const Landing(),
  '/homePage': (context) => const HomePage(),
  '/searchPage': (context) => const SearchPage(),
  '/profilePage': (context) => const SearchPage(),


  '/forgotPassword': (context) => const ForgotPasswordPage(),
  '/loginPage': (context) => const LoginPage(),
  '/registerPage': (context) => const RegisterPage(),
  '/verifyEmailPage': (context) => const VerifyEmail(),


  '/allCategories': (context) => const allCategories(),
  '/basketballCategories': (context) =>  basketballCategory(),
  '/footballCategories': (context) => footballCategory(),
  '/hockeyCategories': (context) => hockeyCategory(),
  '/tableTennisCategories': (context) => tableTennisCategory(),
  '/tennisCategories': (context) => TennisCategory(),
  '/volleyballCategories': (context) => volleyballCategory(),


  
};
