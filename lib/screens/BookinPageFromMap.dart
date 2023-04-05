import 'package:diploma_work/screens/MapPage.dart';
import 'package:flutter/material.dart';
import 'package:diploma_work/screens/BookingDialog.dart';
import 'package:diploma_work/widgets/foregroundWidget.dart';
import 'package:google_fonts/google_fonts.dart';


class BookingPageFromMap extends StatelessWidget {


  final BookingData bookingData;
  BookingPageFromMap({required this.bookingData});
  


  @override
  Widget build(BuildContext context) {
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
                      bookingData.image,
                      width: 300,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  bookingData.name,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
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
                      bookingData.location,
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
                            bookingData.playersQuantity,
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
                            bookingData.coatingType,
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
                              bookingData.description,
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
                    onPressed: (){
                      showDialog(context: context, builder: (context)=> const BookingDialog());
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