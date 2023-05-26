import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileChangePage extends StatefulWidget {
  const ProfileChangePage({super.key});

  @override
  State<ProfileChangePage> createState() => _ProfileChangePageState();
}

class _ProfileChangePageState extends State<ProfileChangePage> {
  late String _userId;

  @override
  void initState() {
    User? user = FirebaseAuth.instance.currentUser;
    _userId = user!.uid;
  }

  TextEditingController nameTextInputController = TextEditingController();
  TextEditingController surnameTextInputController = TextEditingController();
  TextEditingController emailTextInputController = TextEditingController();
  TextEditingController phoneNumberTextInputController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Column(
          children: [
            Column(children: [
              Row(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Изменить данные",
                      style: GoogleFonts.montserrat(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Имя',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: nameTextInputController,
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Фамилия',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: surnameTextInputController,
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'E-mail',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: emailTextInputController,
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Номер',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: phoneNumberTextInputController,
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Spacer(),
            TextButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(_userId)
                    .update({
                  'name': nameTextInputController.text,
                  'surname': surnameTextInputController.text,
                  'email': emailTextInputController.text,
                  'phone_number': phoneNumberTextInputController.text,
                });
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    Future.delayed(Duration(seconds: 3), () {
                      Navigator.of(context).pop();
                    });

                    return AlertDialog(
                      title: Text('Успешно!', style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        color: Colors.black.withOpacity(0.5),
                      ),),
                      content: Text('Данные успешно сохранены.', style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: Colors.black.withOpacity(0.5),
                      ),),
                    );
                  },
                );
                 
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color(0xFF646AFF),
                ),
                width: 340,
                height: 40,
                child: Center(
                    child: Text(
                  'Сохранить данные',
                  style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
