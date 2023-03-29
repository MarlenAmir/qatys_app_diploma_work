import 'package:diploma_work/widgets/foregroundWidget.dart';
import 'package:diploma_work/widgets/searchPanel.dart';
import 'package:flutter/material.dart';
import 'package:diploma_work/widgets/BottomNavBar.dart';
import 'package:firebase_auth/firebase_auth.dart';




class foregroundsList extends StatefulWidget {
  const foregroundsList({super.key});

  @override
  State<foregroundsList> createState() => _foregroundsListState();


}

class _foregroundsListState extends State<foregroundsList> {

  final user = FirebaseAuth.instance.currentUser!;
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
                          user.email!,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.normal),
                        ),
                        Text(
                          'Thursday, 08 January',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 170,
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
                searchPanel(),
                foregroundWidget(),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }

}