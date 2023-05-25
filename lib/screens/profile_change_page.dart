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
                icon: Icon(Icons.arrow_back, color: Colors.black,),
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
            ]),
            SizedBox(
              height: 10,
             
            ),
            Row(
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
            SizedBox(
              height: 10,
              child: Divider(thickness: 1, color: Colors.black.withOpacity(0.5)),
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
