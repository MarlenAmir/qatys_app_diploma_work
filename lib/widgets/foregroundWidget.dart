import 'package:flutter/material.dart';
import 'package:diploma_work/screens/BookingPage.dart';

class foregroundWidget extends StatelessWidget {
  const foregroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(255, 238, 240, 241)),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: Image.asset(
                'images/foreground.jpg',
                width: 300,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 20,
              ),
              Text(
                'Jarys Arena на Шагабутдинова',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(
                width: 10,
              ),
              Image.asset(
                'images/check.png',
                height: 20,
                width: 20,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SizedBox(
                width: 18,
              ),
              Image.asset(
                'images/placeholder.png',
                height: 20,
                width: 20,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'Алмалинский район, улица Шагабудтинова 45',
                style: TextStyle(
                    fontSize: 12, color: Colors.black.withOpacity(0.5)),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SizedBox(
                width: 18,
              ),
              Image.asset(
                'images/football_court.png',
                height: 20,
                width: 20,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'Площадок: 3',
                style: TextStyle(
                    fontSize: 12, color: Colors.black.withOpacity(0.5)),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SizedBox(
                width: 18,
              ),
              Image.asset(
                'images/money.png',
                height: 20,
                width: 20,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'от 11000 т/час',
                style: TextStyle(
                    fontSize: 12, color: Colors.black.withOpacity(0.5)),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BookingPage(),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color(0xFF646AFF),
              ),
              width: 340,
              height: 40,
              child: Center(
                  child: Text(
                'ЗАБРОНИРОВАТЬ',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
