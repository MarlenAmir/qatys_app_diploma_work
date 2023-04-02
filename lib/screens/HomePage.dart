import 'package:diploma_work/widgets/eventsWidget.dart';
import 'package:diploma_work/widgets/foregroundWidget.dart';
import 'package:flutter/material.dart';
import 'package:diploma_work/widgets/searchPanel.dart';
import 'package:diploma_work/widgets/BottomNavBar.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  final TextEditingController searchController = TextEditingController();
  

  @override
  void initState() {
    searchController.addListener(() { 
      setState(() {
        
      });
    });
    super.initState();
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
                searchPanel(searchController: searchController),
                eventWidget(),
                SizedBox(
                  height: 20,
                ),
                Container(
                    margin: EdgeInsets.only(left: 20),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Популярные',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.normal),
                    )),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    foregroundWidget(searchController: searchController,),
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
