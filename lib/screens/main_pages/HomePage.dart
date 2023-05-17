import 'package:diploma_work/widgets/eventsWidget.dart';
import 'package:diploma_work/widgets/foregroundWidget.dart';
import 'package:diploma_work/widgets/tournamentWidget.dart';
import 'package:flutter/material.dart';
import 'package:diploma_work/widgets/searchPanel.dart';
import 'package:diploma_work/widgets/BottomNavBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();
  String name = '';
  late String _currentDate;

  @override
  void initState() {
    searchController.addListener(() {
      setState(() {});
    });
    super.initState();
    initializeDateFormatting(
        'ru'); // инициализация локализации на русском языке
    loadData();
    _getCurrentDate();
  }

  void _getCurrentDate() {
    setState(() {
      final now = DateTime.now();
      final formatter = DateFormat('EEEE, dd MMMM', 'ru'); // указываем локаль
      _currentDate = formatter.format(now);
    });
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
          name = snapshot.get('name');
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFFFFFFF),
        child: ListView(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(20),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage('images/emoji.png'),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Привет, ${name}",
                          style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.normal),
                        ),
                        Text(
                          _currentDate,
                          style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 120,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Image.asset('images/bell.png'),
                      ),
                    )
                  ],
                ),
                searchPanel(searchController: searchController),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xFF3EE07F),
                  ),
                  width: 370,
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => TournamentWidget()));
                      },
                      child: Text(
                        'Открытые турниры',
                        style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 20),
                      )),
                ),
                eventWidget(),
                SizedBox(
                  height: 20,
                ),
                Container(
                    margin: EdgeInsets.only(left: 20),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Популярные',
                      style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.normal),
                    )),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    foregroundWidget(
                      searchController: searchController,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
