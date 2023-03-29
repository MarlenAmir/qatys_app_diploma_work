import 'package:flutter/material.dart';
import 'package:diploma_work/screens/BookingDialog.dart';
import 'package:diploma_work/widgets/foregroundWidget.dart';


class BookingPage extends StatelessWidget {


  final FirebaseData firebaseData;
  BookingPage({required this.firebaseData});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    child: Image.network(
                      firebaseData.image,
                      width: 300,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  firebaseData.name,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/placeholder.png',
                      height: 20,
                      width: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      firebaseData.location,
                      style: TextStyle(
                          fontSize: 12, color: Colors.black.withOpacity(0.5)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'images/man.png',
                            height: 20,
                            width: 20,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Количество игроков',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black.withOpacity(0.5)),
                          ),
                          Spacer(),
                          Text(
                            firebaseData.playersQuantity,
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black.withOpacity(0.5)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            'images/menu.png',
                            height: 20,
                            width: 20,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Покрытие',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black.withOpacity(0.5)),
                          ),
                          Spacer(),
                          Text(
                            firebaseData.coatingType,
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black.withOpacity(0.5)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'О площадке',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              firebaseData.description,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xFF646AFF),
                  ),
                  width: 340,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: (){
                      showDialog(context: context, builder: (context)=> const BookingDialog());
                    },
                    child: Center(
                        child: Text(
                          'Выбрать дату',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

