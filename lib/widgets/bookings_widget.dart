import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookingsWidget extends StatefulWidget {
  const BookingsWidget({super.key});

  @override
  State<BookingsWidget> createState() => _BookingsWidgetState();
}

class _BookingsWidgetState extends State<BookingsWidget> {
  late String _userId;
  

  @override
  void initState() {
    User? user = FirebaseAuth.instance.currentUser;
    _userId = user!.uid;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
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
                  "Мои бронирования",
                  style: GoogleFonts.montserrat(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('bookings')
                      .doc(_userId)
                      .collection('user_bookings')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      final documents = snapshot.data!.docs;
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: documents.length,
                        itemBuilder: (context, index) {
                          final data =
                              documents[index].data() as Map<String, dynamic>;
                          final selectedDay = data['SelectedDay'];
                          final startDate = data['startDate'];
                          final endDate = data['endDate'];
                          final name = data['foregroundName'];
                          final location = data['location'];

                          return Container(
                            margin: const EdgeInsets.only(
                                top: 20, left: 20, right: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Colors.black.withOpacity(0.3))),
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Название поля',
                                          style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14,
                                              color: Colors.black),
                                        ),
                                      ),
                                      Spacer(),
                                      Expanded(
                                        child: Text(
                                          name,
                                          style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14,
                                              color: Colors.black.withOpacity(0.5)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                  child: Divider(
                                      thickness: 1,
                                      color: Colors.black.withOpacity(0.5)),
                                ),
                                Container(
                                  margin: EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Дата брони',
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14,
                                            color: Colors.black),
                                      ),
                                      const Spacer(),
                                      Text(
                                        selectedDay.toString(),
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14,
                                            color: Colors.black.withOpacity(0.5)),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                  child: Divider(
                                      thickness: 1,
                                      color: Colors.black.withOpacity(0.5)),
                                ),
                                Container(
                                  margin: EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Начало времени',
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14,
                                            color: Colors.black),
                                      ),
                                      const Spacer(),
                                      Text(
                                        startDate,
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14,
                                            color: Colors.black.withOpacity(0.5)),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                  child: Divider(
                                      thickness: 1,
                                      color: Colors.black.withOpacity(0.5)),
                                ),
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Конец времени',
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14,
                                            color: Colors.black),
                                      ),
                                      const Spacer(),
                                      Text(
                                        endDate,
                                        style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14,
                                          color: Colors.black.withOpacity(0.5),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                  child: Divider(
                                      thickness: 1,
                                      color: Colors.black.withOpacity(0.5)),
                                ),
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Локация',
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14,
                                            color: Colors.black),
                                      ),
                                      const Spacer(),
                                      Text(
                                        location,
                                        style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14,
                                          color: Colors.black.withOpacity(0.5),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
