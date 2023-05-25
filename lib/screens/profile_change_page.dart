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
  String initalName = '';
  String initialSurname = '';
  String initialEmail = '';
  String initialPhoneNumber = '';

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      final auth = FirebaseAuth.instance;
      final User? user = auth.currentUser;
      if (user != null) {
        final FirebaseFirestore firestore = FirebaseFirestore.instance;
        final DocumentSnapshot snapshot =
            await firestore.collection('users').doc(user.uid).get();
        setState(() {
          initalName = snapshot.get('name');
          initialSurname = snapshot.get('surname');
          initialEmail = snapshot.get('email');
          initialPhoneNumber = snapshot.get('phone_number');
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Column(
          children: [
            Column(children: [
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
                margin: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Text(
                      'Имя',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    Spacer(),
                    Expanded(
                      child: TextFormField(
                        initialValue: initalName,
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
                  Text(
                    'Фамилия',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  Spacer(),
                  Expanded(
                    child: TextFormField(
                      initialValue: initialSurname,
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
            Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Text(
                    'E-mail',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  Spacer(),
                  Expanded(
                    child: TextFormField(
                      initialValue: initialEmail,
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
                  Text(
                    'Номер',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  Spacer(),
                  Expanded(
                    child: TextFormField(
                      initialValue: initialPhoneNumber,
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
              margin: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Text(
                    'E-mail',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  Spacer(),
                  Expanded(
                    child: TextFormField(
                      initialValue: "АМекеееу",
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
          ],
        ),
      ),
    );
  }
}
