
import 'package:diploma_work/screens/services/auth_services/reset_password_service.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  
 late ResetPasswordService resetPasswordService = ResetPasswordService(context);

  @override
  void dispose() {
    resetPasswordService.emailTextInputController;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: resetPasswordService.formKey,
      child: Scaffold(
        body: ListView(children: [
          Column(children: [
            Container(
              alignment: Alignment.centerLeft,
              child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 25,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ),
            Image.asset('images/logo.png'),
            const SizedBox(height: 20),
            Text(
              'Qatys',
              style: GoogleFonts.montserrat(
                  color: const Color(0xFFDEC800),
                  fontSize: 36,
                  fontWeight: FontWeight.normal),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Добро пожаловать!',
              style: GoogleFonts.montserrat(
                  color: const Color(0xFF000000),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              'Держите ваши данные в безопасности!',
              style: GoogleFonts.montserrat(
                  color: const Color(0xFF9F9F9F), fontSize: 14),
            ),
            const SizedBox(height: 10),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 20),
              child: Text(
                'Восстановить пароль',
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
                        ? "Enter a valid email"
                        : null,
                controller: resetPasswordService.emailTextInputController,
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
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: const Color(0xFF7D82FF),
              ),
              width: 370,
              child: TextButton(
                onPressed: () {
                  resetPasswordService.resetPassword();
                },
                child: Text(
                  'Отправить пароль',
                  style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 20),
                ),
              ),
            ),
          ]),
        ]),
      ),
    );
  }
}
