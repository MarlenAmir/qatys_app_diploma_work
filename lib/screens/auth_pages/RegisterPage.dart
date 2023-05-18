import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:diploma_work/main.dart';
import 'package:email_validator/email_validator.dart';
import 'package:diploma_work/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isObscure = true;

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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        body: ListView(
          children: [
            Column(
              children: [
                Container(
                  child: Image.asset(
                    'images/logo.png',
                    height: 100,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Qatys',
                  style: GoogleFonts.montserrat(
                      color: Color(0xFFDEC800),
                      fontSize: 36,
                      fontWeight: FontWeight.normal),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Добро пожаловать!',
                  style: GoogleFonts.montserrat(
                      color: Color(0xFF000000),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
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
                    'Регистрация',
                    style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF000000)),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 370,
                  child: TextFormField(
                    validator: (value) => value != null && value.length < 2
                        ? "Минимум 2 символов"
                        : null,
                    controller: nameTextController,
                    maxLines: 1,
                    minLines: 1,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Ваше Имя",
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 370,
                  child: TextFormField(
                    validator: (value) =>
                        value != null && value.length < 2 ? "2 символа" : null,
                    controller: surnameTextController,
                    maxLines: 1,
                    minLines: 1,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Ваша Фамилия",
                    ),
                  ),
                ),
                const SizedBox(height: 10),
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
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "E-mail",
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 370,
                  child: TextFormField(
                    validator: (value) => value != null && value.length < 11
                        ? "Минимум 11 символов"
                        : null,
                    controller: phoneTextController,
                    maxLines: 1,
                    minLines: 1,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Номер телефона",
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 370,
                  child: TextFormField(
                    validator: (value) => value != null && value.length < 6
                        ? "Минимум 6 символов"
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
                      border: const OutlineInputBorder(),
                      labelText: "Пароль",
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color(0xFF7D82FF),
                  ),
                  width: 370,
                  child: TextButton(
                      onPressed: () {
                        signUp();
                      },
                      child: Text(
                        'Регистрация',
                        style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 20),
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Joined us before?',
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Color(0xFF9F9F9F),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Login',
                          style: GoogleFonts.montserrat(
                              color: const Color(0xFF646AFF),
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
