import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class eventWidget extends StatefulWidget {
  const eventWidget({super.key});

  @override
  State<eventWidget> createState() => _eventWidgetState();
}

class _eventWidgetState extends State<eventWidget> {
   List <String> eventIDs = [];

  

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int i = 1; i<6;  i++)
          Container(
            width: 200,
            height: 100,
            margin: EdgeInsets.only(top: 20, left: 20,),
            decoration: BoxDecoration(
              color: Color(0xFF9E00FF),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Image.asset('images/image1.png'),
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
                          'FOOTBALL',
                          style: TextStyle(color: Colors.black, fontSize: 10),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Training Football \nDay 102',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Starting date: 12 Apr',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.normal,
                          color: Colors.white.withOpacity(0.8)),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
