import 'package:diploma_work/widgets/foregroundWidget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diploma_work/screens/foregroundsList.dart';

class eventWidget extends StatefulWidget {
  const eventWidget({super.key});

  @override
  State<eventWidget> createState() => _eventWidgetState();
}

class _eventWidgetState extends State<eventWidget> {
  @override
  Widget build(BuildContext context) {
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
  }
}


