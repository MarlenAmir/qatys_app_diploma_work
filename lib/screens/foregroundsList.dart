import 'package:diploma_work/widgets/foregroundWidget.dart';
import 'package:diploma_work/widgets/searchPanel.dart';
import 'package:diploma_work/widgets/selectedCategoryForeground.dart';
import 'package:flutter/material.dart';
import 'package:diploma_work/widgets/BottomNavBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';




class foregroundsList extends StatefulWidget {
  const foregroundsList({super.key});

  @override
  State<foregroundsList> createState() => _foregroundsListState();


}

class _foregroundsListState extends State<foregroundsList> {
  
  final TextEditingController searchController = TextEditingController();
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
                          style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 110,
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
                searchPanel(searchController : searchController),
                selectedCategoryForeground(),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }

}