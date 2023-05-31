import 'package:flutter/material.dart';
import 'package:diploma_work/widgets/view.dart';
import 'package:google_fonts/google_fonts.dart';

final List<String> videoIds = [
  'yuli9QzU1aI',
  'MLfaH-lDmdY',
  'G0QjxTR_XPc',
  'sNKOh0bRMyk',
  'NWGXKNwy8pg',
  'icEfi4MVLVg',
  '8hjR6jgtqfM',
  'XkKMZXwh9m8',
  'GfSzsJIgr1o',
  'bUCNQqa8p3E',
];

final List<String> videoTitles = [
  '10 ЛЕГКИХ НАВЫКОВ ОБЫГРАТЬ В ФУТБОЛЕ. Обучение финтам CR7',
  '5 ПРОСТЫХ ФИНТОВ, ЧТОБЫ УДИВЛЯТЬ ЗАЩИТНИКОВ! Обучение финтам футболистов',
  'Секрет ИДЕАЛЬНОГО УДАРА с Андреем Тихоновым! ОБУЧЕНИЕ ПЛАССЕРУ',
  'Обучение сильному удару. КАК БИТЬ ПУШКОЙ? // POWER SHOT TUTORIAL',
  'Обучение крученому удару | Curve tutorial. Bend it like Beckham',
  'Обучение эффектным финтам!',
  'Обучение удару Наклбол | Knuckleball tutorial',
  'КАК РЕБЁНКУ НАУЧИТЬСЯ БИТЬ ПУШКОЙ?',
  'НЕ ПОВТОРЯЙ ЭТИ ОШИБКИ В ФУТБОЛЕ.',
  'Как бить по мячу подъёмом сильно и точно?',
];

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 250,
                  child: ClipRRect(
                    child: Image.network(
                      'https://i.ytimg.com/vi/xHejVZ7QUcY/maxresdefault.jpg',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'О Программе',
                          style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Добро пожаловать в нашу футбольную программу! Наша цель - помочь вам развить свои футбольные навыки, улучшить физическую форму и достичь своих спортивных целей. Ваше участие в этой программе открывает двери к волнующему миру футбола, где мы вместе будем расти, учиться и добиваться успеха. Программа состоит из разнообразных тренировок, которые включают в себя технические упражнения, физическую подготовку, тактические аспекты игры и многое другое. Мы стремимся обеспечить вам полноценный и разносторонний подход к тренировкам, чтобы вы могли стать лучшими игроками и наслаждаться игрой на полную мощность.',
                          style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Тренер',
                    style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: const CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage('images/trener.jpg'),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ринат Кайсаров',
                          style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'тренер',
                          style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Видео - занятия',
                    style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                const SizedBox(height: 10),
                VideoList(videoIds: videoIds, videoTitles: videoTitles),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
