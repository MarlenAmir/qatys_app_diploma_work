import 'package:diploma_work/screens/auth_pages/view.dart';
import 'package:diploma_work/screens/services/auth_services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscure = true;

  final AuthService authService = AuthService();

  @override
  void initState() {
    authService.emailTextInputController.clear();
    authService.passwordTextInputController.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: authService.formKey,
      child: Scaffold(
        backgroundColor: Color(0xFFF5F5F5),
        body: ListView(
          children: [
            Column(
              children: [
                Image.asset('images/logo.png'),
                const SizedBox(height: 20),
                const Text(
                  'Qatys',
                  style: TextStyle(
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
                const SizedBox(height: 10),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 20),
                  child: Text(
                    'Вход',
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
                    validator: (email) =>
                        email != null && !EmailValidator.validate(email)
                            ? "Введите правильный E-mail"
                            : null,
                    controller: authService.emailTextInputController,
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
                    validator: (value) => value != null && value.length < 8
                        ? "Минимум 8 символов"
                        : null,
                    controller: authService.passwordTextInputController,
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
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xFF7D82FF),
                  ),
                  width: 370,
                  child: TextButton(
                      onPressed: () {
                        authService.signIn(context);
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
                        builder: (context) => const ForgotPasswordPage()));
                  },
                  child: Text(
                    'Забыли пароль?',
                    style: GoogleFonts.montserrat(
                        color: Color(0xFF7D82FF),
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
                Text(
                  'ИЛИ',
                  style: GoogleFonts.montserrat(
                      fontSize: 10,
                      color: Color(0xFF9F9F9F),
                      fontWeight: FontWeight.normal),
                ),
                const SizedBox(
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
                        await authService.signWithGoogle();
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
                          'Войти с помощью Google',
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
                      'Не зарегестрированы?',
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: const Color(0xFF9F9F9F),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const RegisterPage(),
                            ),
                          );
                        },
                        child: Text(
                          'Регистрация',
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
