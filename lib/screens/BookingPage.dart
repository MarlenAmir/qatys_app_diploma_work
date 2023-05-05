import 'package:diploma_work/screens/MapPage.dart';
import 'package:flutter/material.dart';
import 'package:diploma_work/screens/BookingDialog.dart';
import 'package:diploma_work/widgets/foregroundWidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:diploma_work/screens/firebaseData.dart';

class BookingPage extends StatelessWidget {
  final FirebaseData firebaseData;
  BookingPage({required this.firebaseData});

  final DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    BookingDataName bookingDataName =
        BookingDataName(foregroundName: firebaseData.name);

    return Scaffold(
      body: ListView(
        children: [
          Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    child: Image.network(
                      firebaseData.image,
                      width: 300,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    firebaseData.name,
                    style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/placeholder.png',
                      height: 20,
                      width: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      firebaseData.location,
                      style: GoogleFonts.montserrat(
                          fontSize: 12, color: Colors.black.withOpacity(0.5)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'images/man.png',
                            height: 20,
                            width: 20,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Количество игроков',
                            style: GoogleFonts.montserrat(
                                fontSize: 14,
                                color: Colors.black.withOpacity(0.5)),
                          ),
                          Spacer(),
                          Text(
                            firebaseData.playersQuantity,
                            style: GoogleFonts.montserrat(
                                fontSize: 14,
                                color: Colors.black.withOpacity(0.5)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            'images/menu.png',
                            height: 20,
                            width: 20,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Покрытие',
                            style: GoogleFonts.montserrat(
                                fontSize: 14,
                                color: Colors.black.withOpacity(0.5)),
                          ),
                          Spacer(),
                          Text(
                            firebaseData.coatingType,
                            style: GoogleFonts.montserrat(
                                fontSize: 14,
                                color: Colors.black.withOpacity(0.5)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'О площадке',
                                style: GoogleFonts.montserrat(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              firebaseData.description,
                              style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xFF646AFF),
                  ),
                  width: 340,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                     Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => BookingDialog(),
                            ),
                          );
                    },
                    child: Center(
                        child: Text(
                      'Выбрать дату',
                      style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class BookingDataName {
  final String foregroundName;
  BookingDataName({required this.foregroundName});
}
