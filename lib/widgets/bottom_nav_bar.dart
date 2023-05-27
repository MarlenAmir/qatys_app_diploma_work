import 'package:diploma_work/screens/main_pages/view.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);


  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
   final List <Widget> _pages = [
    HomePage(),
    SearchPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(blurRadius: 20),
          ]),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: GNav(
                gap: 8,
                activeColor: Colors.white,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                duration: Duration(milliseconds: 800),
                tabBackgroundColor: Colors.blue,
                tabs: const [
                  GButton(
                    icon: Icons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.search,
                    text: 'Search',
                  ),
                  GButton(
                    icon: Icons.settings,
                    text: 'Settings',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
          ),
        ),
      );
  }
}

/*
GNav(
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
             _showModalBottomSheet(context);
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


 */

void _showModalBottomSheet(BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Center(
          child: Container(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Divider(
                thickness: 3,
                color: Colors.black.withOpacity(0.5),
                indent: 185,
                endIndent: 185,
              ),
              const SizedBox(
                height: 10,
              ),
              const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('images/chathelp.jpg'),
                  backgroundColor: Colors.amberAccent),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Айгерим, служба поддержки',
                style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Работаем для вас каждый день \n               с 9:00 до 22:00',
                style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Colors.black.withOpacity(0.5)),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Выберите удобный способ для \n           связи с нами',
                style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      InkWell(
                        onTap: () async {
                          
                          String url =
                              "https://t.me/Marlen7";
                          if (await canLaunchUrl(Uri.parse(url))) {
                            await launchUrl(Uri.parse(url),
                                mode: LaunchMode.externalApplication);
                          }
                        },
                        child: const CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage('images/telegram.jpg'),
                            backgroundColor: Colors.amberAccent),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Telegram',
                        style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: Colors.black.withOpacity(0.5)),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: () async {
                          String text = "Привет, мне нужна помощь?!";
                          String url =
                              "https://wa.me/87755296850text=${Uri.encodeFull(text)}";
                          if (await canLaunchUrl(Uri.parse(url))) {
                            await launchUrl(Uri.parse(url),
                                mode: LaunchMode.externalApplication);
                          }
                        },
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('images/whatsapp.png'),
                          backgroundColor: Colors.white.withOpacity(0.1),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Whatsapp',
                        style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: Colors.black.withOpacity(0.5)),
                      ),
                    ],
                  ),
                ],
              )
            ]),
          ),
        );
      });
}
