import 'package:diploma_work/screens/ForgotPassword.dart';
import 'package:diploma_work/screens/RegisterPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:diploma_work/main.dart';
import 'package:email_validator/email_validator.dart';
import 'package:diploma_work/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

TextEditingController emailTextInputController = TextEditingController();
TextEditingController passwordTextInputController = TextEditingController();

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscure = true;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    emailTextInputController.clear();
    passwordTextInputController.clear();
    super.initState();
  }

  signWithGoogle() async{
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);

  }

  

  Future signIn() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailTextInputController.text.trim(),
          password: passwordTextInputController.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        backgroundColor: Color(0xFFF5F5F5),
        body: ListView(
          children: [
            Column(
              children: [
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
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Добро пожаловать!',
                  style: GoogleFonts.montserrat(
                      color: Color(0xFF000000),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  'Держите ваши данные в безопасности!',
                  style: GoogleFonts.montserrat(
                      color: Color(0xFF9F9F9F), fontSize: 14),
                ),
                SizedBox(height: 10),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 20),
                  child: Text(
                    'Вход',
                    style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF000000)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 370,
                  child: TextFormField(
                    validator: (email) =>
                        email != null && !EmailValidator.validate(email)
                            ? "Введите правильный E-mail"
                            : null,
                    controller: emailTextInputController,
                    keyboardType: TextInputType.emailAddress,
                    maxLines: 1,
                    minLines: 1,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "E-mail",
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 370,
                  child: TextFormField(
                    validator: (value) => value != null && value.length < 8
                        ? "Минимум 8 символов"
                        : null,
                    controller: passwordTextInputController,
                    obscureText: _isObscure,
                    maxLines: 1,
                    minLines: 1,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          icon: Icon(_isObscure
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          }),
                      border: OutlineInputBorder(),
                      labelText: "Password",
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xFF7D82FF),
                  ),
                  width: 370,
                  child: TextButton(
                      onPressed: () {
                        signIn();
                      },
                      child: Text(
                        'Вход',
                        style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 20),
                      )),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ForgotPasswordPage()));
                  },
                  child: Text(
                    'Forgot Password?',
                    style: GoogleFonts.montserrat(
                        color: Color(0xFF7D82FF),
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
                Text(
                  'OR',
                  style: GoogleFonts.montserrat(
                      fontSize: 10,
                      color: Color(0xFF9F9F9F),
                      fontWeight: FontWeight.normal),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color.fromARGB(255, 201, 201, 201),
                  ),
                  width: 370,
                  child: TextButton(
                    onPressed: () async {
                      try {
                        await signWithGoogle();
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('images/google_logo.png'),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Login with Google',
                          style: GoogleFonts.montserrat(
                              color: Color(0xFF9F9F9F),
                              fontSize: 20,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account?',
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Color(0xFF9F9F9F),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => RegisterPage(),
                            ),
                          );
                        },
                        child: Text(
                          'Register',
                          style: GoogleFonts.montserrat(
                              color: Color(0xFF646AFF),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
