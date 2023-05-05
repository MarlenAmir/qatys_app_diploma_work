import 'package:diploma_work/screens/MapPage.dart';
import 'package:diploma_work/screens/VideoPage.dart';
import 'package:diploma_work/widgets/foregroundWidget.dart';
import 'package:diploma_work/widgets/foregroundWidget.dart';
import 'package:diploma_work/screens/allCategories.dart';
import 'package:diploma_work/widgets/searchPanel.dart';
import 'package:flutter/material.dart';
import 'package:diploma_work/widgets/BottomNavBar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
        color: Colors.white,
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
                searchPanel(
                  searchController: searchController,
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => MapPage()));
                  },
                  child: Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: Image.asset('images/Map.png')),
                      Text(
                        'На карте',
                        style: GoogleFonts.montserrat(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.black,
                  thickness: 1,
                  endIndent: 20,
                  indent: 20,
                ),
                InkWell(
                  onTap: (){
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => allCategories()));
                  },
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Image.asset('images/favorites.png'),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'По категориям',
                        style: GoogleFonts.montserrat(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.black,
                  thickness: 1,
                  endIndent: 20,
                  indent: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => VideoPage()));
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, top: 10, bottom: 5),
                        child: Image.asset('images/videos.png'),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Полезные видео',
                        style: GoogleFonts.montserrat(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.black,
                  thickness: 1,
                  endIndent: 20,
                  indent: 20,
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Партнерские площадки',
                        style: GoogleFonts.montserrat(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Image.asset('images/check.png'),
                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      foregroundWidget(searchController: searchController),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
