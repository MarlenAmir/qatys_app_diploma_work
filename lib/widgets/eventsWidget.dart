import 'package:diploma_work/widgets/foregroundWidget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diploma_work/screens/foregroundsList.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:diploma_work/screens/footballCategory.dart';
import 'package:diploma_work/screens/volleyballCategory.dart';
import 'package:diploma_work/screens/basketballCategory.dart';
import 'package:diploma_work/screens/tennisCategory.dart';
import 'package:diploma_work/screens/tableTennisCategory.dart';
import 'package:diploma_work/screens/hockeyCategory.dart';







class eventWidget extends StatefulWidget {
  const eventWidget({super.key});

  @override
  State<eventWidget> createState() => _eventWidgetState();
}

class _eventWidgetState extends State<eventWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(children: [
          GestureDetector(
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
          GestureDetector(
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
          GestureDetector(
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
          GestureDetector(
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
          GestureDetector(
            onTap: (){
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
          GestureDetector(
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
        ]));
  }
}






/*
 return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('events').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Text('Loading...');
          default:
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
                  return GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => foregroundsList()));
                    },
                    child: Container(
                      width: 200,
                      height: 100,
                      margin: EdgeInsets.only(
                        top: 20,
                        left: 20,
                      ),
                      decoration: BoxDecoration(
                        color: Color(int.parse(data['color'])),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        child: Row(
                          children: [
                            SizedBox(width: 10,),
                            Container(child: Image.network(data['image_url']), width: 50, height: 50,),
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.all(5),
                                    child: Text(
                                      data['name'],
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 10),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  data['title'],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  data['StartDate'],
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white.withOpacity(0.8)),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
        }
      },
    );




 */