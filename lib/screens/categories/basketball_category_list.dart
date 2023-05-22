import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:diploma_work/model/firebase_data.dart';
import 'package:shimmer/shimmer.dart';



class basketballCategory extends StatefulWidget {


  @override
  State<basketballCategory> createState() => _basketballCategoryState();
}

class _basketballCategoryState extends State<basketballCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: 10),
          StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('basketball_foregrounds').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Column(
                      children: List.generate(
                        5, // Adjust the number of shimmering items as needed
                        (index) => Container(
                          width: double.infinity,
                          margin: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color.fromARGB(255, 238, 240, 241),
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 250,
                                color: Colors.grey, // Placeholder color
                              ),
                              const SizedBox(height: 10),
                              Container(
                                width: 200,
                                height: 14,
                                color: Colors.grey, // Placeholder color
                              ),
                              const SizedBox(height: 10),
                              Container(
                                width: 100,
                                height: 14,
                                color: Colors.grey, // Placeholder color
                              ),
                              const SizedBox(height: 10),
                              Container(
                                width: 150,
                                height: 14,
                                color: Colors.grey, // Placeholder color
                              ),
                              const SizedBox(height: 10),
                              Container(
                                width: 120,
                                height: 14,
                                color: Colors.grey, // Placeholder color
                              ),
                              const SizedBox(height: 10),
                              Container(
                                width: 340,
                                height: 40,
                                color: Colors.grey, // Placeholder color
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
                default:
                  return SingleChildScrollView(
                   
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;  
                          FirebaseData firebaseData = FirebaseData(
                            price: data['price'],
                            image: data['image_url'],
                            name: data['name'],
                            playersQuantity: data['playersQuantity'],
                            location: data['location'],
                            coatingType: data['coatingType'],
                            description: data['description']); 
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
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                                  child: Image.network(
                                    data['image_url'],
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
                                    data['name'],
                                    style: GoogleFonts.montserrat(
                                        fontSize: 14,
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
                                    data['location'],
                                    style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        color: Colors.black.withOpacity(0.5)),
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
                                    'Площадок: ${data['quantity_foregrounds']}',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        color: Colors.black.withOpacity(0.5)),
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
                                    'от ${data['price']} т/час',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        color: Colors.black.withOpacity(0.5)),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextButton(
                                onPressed: () {
                                  
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
                                    style: GoogleFonts.montserrat(
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
                      }).toList(),
                    ),
                  );
              }
            },
          ),
        ],
      ),
    );
  }
}