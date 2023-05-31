import 'package:diploma_work/screens/services/auth_services/register_service.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isObscure = true;

  TextEditingController emailTextInputController = TextEditingController();
  TextEditingController passwordTextInputController = TextEditingController();
  TextEditingController phoneTextController = TextEditingController();
  TextEditingController nameTextController = TextEditingController();
  TextEditingController surnameTextController = TextEditingController();

  late RegisterService registerService = RegisterService(
      context: context,
      emailTextInputController: emailTextInputController,
      passwordTextInputController: passwordTextInputController,
      nameTextController: nameTextController,
      surnameTextController: surnameTextController,
      phoneTextController: phoneTextController);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: registerService.formKey,
      child: Scaffold(
        body: ListView(
          children: [
            Column(
              children: [
                Image.asset(
                  'images/logo.png',
                  height: 100,
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
                    keyboardType: TextInputType.phone,
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
                        registerService.signUp();
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
                      'Вы были зарегестрированы?',
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
                          'Войти',
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
