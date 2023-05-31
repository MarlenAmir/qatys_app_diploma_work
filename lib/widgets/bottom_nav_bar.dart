import 'package:diploma_work/screens/main_pages/view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomNavBar extends StatefulWidget {


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
          icon: CupertinoIcons.home,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          },
        ),
        GButton(
          icon: CupertinoIcons.search,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SearchPage(),
              ),
            );
          },
        ),
        GButton(
          icon: CupertinoIcons.chat_bubble,
          onPressed: (){
             _showModalBottomSheet(context);
          },
        ),
        GButton(
          icon: CupertinoIcons.profile_circled,
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
                          String url = "https://t.me/Marlen7";
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
                              "https://wa.me/77755296850text=${Uri.encodeFull(text)}";
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
