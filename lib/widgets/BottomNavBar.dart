import 'package:diploma_work/screens/ChatPage.dart';
import 'package:diploma_work/screens/HomePage.dart';
import 'package:diploma_work/screens/ProfilePage.dart';
import 'package:diploma_work/screens/SearchPage.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return GNav(
      gap: 20,
      tabs: [
        GButton(
          icon: Icons.home,
          text: 'Home',
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          },
        ),
        GButton(
          icon: Icons.search,
          text: 'Search',
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SearchPage(),
              ),
            );
          },
        ),
        GButton(
          icon: Icons.chat_bubble_outline_rounded,
          text: 'Chat',
          onPressed: (){
             Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ChatPage(),
              ),
            );
          },
        ),
        GButton(
          icon: Icons.settings,
          text: 'Settings',
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProfilePage(),
              ),
            );
          },
        ),
      ],
    );
  }
}
