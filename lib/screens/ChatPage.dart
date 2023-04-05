import 'package:diploma_work/widgets/BottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Center(
                    child: Container(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Divider(
                              thickness: 3,
                              color: Colors.black.withOpacity(0.5),
                              indent: 185,
                              endIndent: 185,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CircleAvatar(
                                radius: 40,
                                backgroundImage:
                                    AssetImage('images/chathelp.jpg'),
                                backgroundColor: Colors.amberAccent),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Айгерим, служба поддержки',
                              style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Работаем для вас каждый день \n               с 9:00 до 22:00',
                              style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black.withOpacity(0.5)),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Выберите удобный способ для \n           связи с нами',
                              style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        String username = 'Marlen7'; // Replace with the username of the Telegram user you want to chat with

                                        String url = 'https://t.me/$username';
                                        launchUrl(Uri.parse(url));
                                      },
                                      child: CircleAvatar(
                                          radius: 30,
                                          backgroundImage:
                                              AssetImage('images/telegram.jpg'),
                                          backgroundColor: Colors.amberAccent),
                                    ),
                                    SizedBox(
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
                                SizedBox(
                                  width: 40,
                                ),
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        String phoneNumber =
                                            '87755296850'; // Replace with the phone number you want to chat with
                                        String message =
                                            'Привет, у меня вопрос'; // Replace with the message you want to send

                                        String url =
                                            'https://wa.me/$phoneNumber/?text=${Uri.parse(message)}';
                                        launchUrl(Uri.parse(url));
                                      },
                                      child: CircleAvatar(
                                        radius: 40,
                                        backgroundImage:
                                            AssetImage('images/whatsapp.png'),
                                        backgroundColor:
                                            Colors.white.withOpacity(0.1),
                                      ),
                                    ),
                                    SizedBox(
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
          },
          child: Text("Начать чат с техподдержой"),
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
