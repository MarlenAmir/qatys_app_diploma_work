import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:diploma_work/screens/footballCategory.dart';
import 'package:diploma_work/screens/volleyballCategory.dart';
import 'package:diploma_work/screens/basketballCategory.dart';
import 'package:diploma_work/screens/tennisCategory.dart';
import 'package:diploma_work/screens/tableTennisCategory.dart';
import 'package:diploma_work/screens/hockeyCategory.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class allCategories extends StatefulWidget {
  const allCategories({super.key});

  @override
  State<allCategories> createState() => _allCategoriesState();
}

class _allCategoriesState extends State<allCategories> {
  String name = '';

  late String _currentDate;

  @override
  void initState() {
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
      body: Column(
        
        children: [
           SizedBox(
            height: 30,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black,),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
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
          Divider(
            thickness: 0.8,
            color: Colors.black,
            endIndent: 0,
            indent: 0,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            alignment: Alignment.centerLeft,
            child: Text(
              'По категориям',
              style: GoogleFonts.montserrat(
                  fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => footballCategory(),
                      ),
                    );
                  },
                  child: Container(
                    width: 120,
                    height: 125,
                    margin: EdgeInsets.only(
                      top: 20,
                      left: 20,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFF9E00FF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      child: Column(
                        children: [
                          SizedBox(height: 5),
                          Container(
                            width: 80,
                            child: Text(
                              'Футбольные площадки',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white),
                            ),
                          ),
                          Divider(
                            color: Colors.white,
                            thickness: 1,
                            endIndent: 0,
                            indent: 0,
                          ),
                          Container(
                            child: Image.asset('images/football.png'),
                            width: 69,
                            height: 69,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => basketballCategory(),
                      ),
                    );
                  },
                  child: Container(
                    width: 120,
                    height: 125,
                    margin: EdgeInsets.only(
                      top: 20,
                      left: 20,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFFF7C821),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      child: Column(
                        children: [
                          SizedBox(height: 5),
                          Container(
                            width: 100,
                            child: Text(
                              'Баскетбольные площадки',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white),
                            ),
                          ),
                          Divider(
                            color: Colors.white,
                            thickness: 1,
                            endIndent: 0,
                            indent: 0,
                          ),
                          SizedBox(height: 5),
                          Container(
                            child: Image.asset('images/basketball.png'),
                            width: 60,
                            height: 60,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => volleyballCategory(),
                      ),
                    );
                  },
                  child: Container(
                    width: 120,
                    height: 125,
                    margin: EdgeInsets.only(
                      top: 20,
                      left: 20,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFF3892C5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      child: Column(
                        children: [
                          SizedBox(height: 5),
                          Container(
                            width: 105,
                            child: Text(
                              'Воллейбольные площадки',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white),
                            ),
                          ),
                          Divider(
                            color: Colors.white,
                            thickness: 1,
                            endIndent: 0,
                            indent: 0,
                          ),
                          Container(
                            child: Image.asset('images/volleyball.png'),
                            width: 60,
                            height: 60,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => tennisCategory(),
                      ),
                    );
                  },
                  child: Container(
                    width: 120,
                    height: 125,
                    margin: EdgeInsets.only(
                      top: 20,
                      left: 20,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFFFF8F8F),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      child: Column(
                        children: [
                          SizedBox(height: 5),
                          Container(
                            width: 100,
                            child: Text(
                              'Теннисные площадки',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white),
                            ),
                          ),
                          Divider(
                            color: Colors.white,
                            thickness: 1,
                            endIndent: 0,
                            indent: 0,
                          ),
                          Container(
                            child: Image.asset('images/tennis.png'),
                            width: 60,
                            height: 60,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => hockeyCategory(),
                      ),
                    );
                  },
                  child: Container(
                    width: 120,
                    height: 125,
                    margin: EdgeInsets.only(
                      top: 20,
                      left: 20,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFF3EE07F),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      child: Column(
                        children: [
                          SizedBox(height: 5),
                          Container(
                            width: 100,
                            child: Text(
                              'Хоккейные площадки',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white),
                            ),
                          ),
                          Divider(
                            color: Colors.white,
                            thickness: 1,
                            endIndent: 0,
                            indent: 0,
                          ),
                          Container(
                            child: Image.asset('images/hockey.png'),
                            width: 69,
                            height: 69,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => tableTennisCategory(),
                      ),
                    );
                  },
                  child: Container(
                    width: 120,
                    height: 125,
                    margin: EdgeInsets.only(
                      top: 20,
                      left: 20,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFF9E00FF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      child: Column(
                        children: [
                          SizedBox(height: 5),
                          Container(
                            width: 100,
                            child: Text(
                              'Настольные площадки',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white),
                            ),
                          ),
                          Divider(
                            color: Colors.white,
                            thickness: 1,
                            endIndent: 0,
                            indent: 0,
                          ),
                          Container(
                            child: Image.asset('images/table-tennis.png'),
                            width: 69,
                            height: 69,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
