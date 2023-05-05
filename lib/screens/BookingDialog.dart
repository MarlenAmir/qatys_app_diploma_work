import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:email_validator/email_validator.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:booking_calendar/booking_calendar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:diploma_work/screens/BookingPage.dart';


class BookingDialog extends StatefulWidget {
  const BookingDialog({super.key});

  @override
  State<BookingDialog> createState() => _BookingDialogState();
}

class _BookingDialogState extends State<BookingDialog> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void saveData(String name, String email, String phone, String date,
      String startTime, String endTime) {
    firestore.collection('bookings').add({
      'name': name,
      'email': email,
      'phone': phone,
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    dateController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        AlertDialog(
          actions: [
            TextButton(
              child: Text('Отменить'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('Отправить'),
              onPressed: () {
                saveData(
                    nameController.text,
                    emailController.text,
                    phoneController.text,
                    dateController.text,
                    startTimeController.text,
                    endTimeController.text);
                final snackBar = SnackBar(
                  content: const Text('Заявка успешно отправлена!', style: TextStyle(color: Colors.white),),
                  backgroundColor: Colors.green,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                Navigator.pop(context);
              },
            ),
          ],
          content: Container(
            width: double.infinity,
            height: 460,
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: dateController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.calendar_today), //icon of text field
                      labelText: "Выберите дату",
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2022),
                        lastDate: DateTime(2024),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          dateController.text =
                              DateFormat('dd-MM-yyyy').format(pickedDate);
                        });
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: startTimeController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.calendar_today), //icon of text field
                      labelText: "Выберите время начала",
                    ),
                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        initialTime: TimeOfDay.now(),
                        context: context,
                      );

                      if (pickedTime != null) {
                        print(pickedTime.format(context)); //output 10:51 PM
                        DateTime parsedTime = DateFormat.jm()
                            .parse(pickedTime.format(context).toString());
                        //converting to DateTime so that we can further format on different pattern.
                        print(parsedTime); //output 1970-01-01 22:53:00.000
                        String formattedTime =
                        DateFormat('HH:mm').format(parsedTime);
                        print(formattedTime); //output 14:59:00
                        //DateFormat() is from intl package, you can format the time on any pattern you need.

                        setState(() {
                          startTimeController.text =
                              formattedTime; //set the value of text field.
                        });
                      } else {
                        print("Time is not selected");
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: endTimeController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.calendar_today),
                      labelText: "Выберите время конца",
                    ),
                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        initialTime: TimeOfDay.now(),
                        context: context,
                      );

                      if (pickedTime != null) {
                        print(pickedTime.format(context));
                        DateTime parsedTime = DateFormat.jm()
                            .parse(pickedTime.format(context).toString());

                        print(parsedTime);
                        String formattedTime =
                        DateFormat('HH:mm').format(parsedTime);
                        print(formattedTime);

                        setState(() {
                          endTimeController.text = formattedTime;
                        });
                      } else {
                        print("Time is not selected");
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    maxLines: 1,
                    minLines: 1,
                    validator: (String? text) {
                      if (text == null || text.isEmpty) {
                        return "Введите ваше Имя";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Имя",
                    ),
                    controller: nameController,
                    keyboardType: TextInputType.name,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (String? text) {
                      if (text == null || text.isEmpty) {
                        return "Введите ваше Имя";
                      }
                      return null;
                    },
                    maxLines: 1,
                    minLines: 1,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Номер телефона",
                    ),
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    maxLines: 1,
                    minLines: 1,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "E-mail",
                    ),
                    validator: (email) =>
                    email != null && !EmailValidator.validate(email)
                        ? "Enter a valid email"
                        : null,
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}



  









/*
 Future<void> loadData() async {
    try {
      final auth = FirebaseAuth.instance;
      final User? user = auth.currentUser;
      if (user != null) {
        final FirebaseFirestore firestore = FirebaseFirestore.instance;
        final DocumentSnapshot snapshot =
            await firestore.collection('users').doc(user.uid).get();
        setState(() {
          name = snapshot.get('name');
          surname = snapshot.get('surname');
          email = snapshot.get('email');
          phoneNumber = snapshot.get('phone_number');
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }


  String name = '';
  String surname = '';
  String email = '';
  String phoneNumber = '';

  


  @override
  void initState() {
    loadData();
    super.initState();
  }

Column(
        children: [
          Text("${widget.bookingDataName.foregroundName}"),
          Container(
            margin: EdgeInsets.only(top: 20, left: 20, right: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black.withOpacity(0.3))),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Text(
                        'Имя',
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            color: Colors.black),
                      ),
                      Spacer(),
                      Text(
                        name,
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            color: Colors.black.withOpacity(0.5)),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                  child: Divider(
                      thickness: 1, color: Colors.black.withOpacity(0.5)),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Text(
                        'Фамилия',
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            color: Colors.black),
                      ),
                      Spacer(),
                      Text(
                        surname,
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            color: Colors.black.withOpacity(0.5)),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                  child: Divider(
                      thickness: 1, color: Colors.black.withOpacity(0.5)),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Text(
                        'Номер',
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            color: Colors.black),
                      ),
                      Spacer(),
                      Text(
                        phoneNumber,
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            color: Colors.black.withOpacity(0.5)),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                  child: Divider(
                      thickness: 1, color: Colors.black.withOpacity(0.5)),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Text(
                        'E-mail',
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            color: Colors.black),
                      ),
                      Spacer(),
                      Text(
                        email,
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            color: Colors.black.withOpacity(0.5)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ), */








































/*class BookingDialog extends StatefulWidget {
  const BookingDialog({super.key});

  @override
  State<BookingDialog> createState() => _BookingDialogState();
}

class _BookingDialogState extends State<BookingDialog> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void saveData(String name, String surname, String email, String phone,
      String date, String startTime, String endTime) {
    firestore.collection('requests').add({
      'name': name,
      'surname': surname,
      'email': email,
      'phone': phone,
    });
  }

  String name = '';
  String surname = '';
  String email = '';
  String phoneNumber = '';

  Future<void> loadData() async {
    try {
      final auth = FirebaseAuth.instance;
      final User? user = auth.currentUser;
      if (user != null) {
        final FirebaseFirestore firestore = FirebaseFirestore.instance;
        final DocumentSnapshot snapshot =
            await firestore.collection('users').doc(user.uid).get();
        setState(() {
          name = snapshot.get('name');
          surname = snapshot.get('surname');
          email = snapshot.get('email');
          phoneNumber = snapshot.get('phone_number');
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(children: [
        Container(
          width: double.infinity,
          height: 460,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: dateController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.calendar_today), //icon of text field
                    labelText: "Выберите дату",
                  ),
                  onTap: () async {
                    final DateTime? pickedDate =
                        await DatePicker.showDatePicker(
                      context,
                      showTitleActions: true,
                      minTime: DateTime.now(),
                      maxTime: DateTime(2023, 4, 22),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        dateController.text =
                            DateFormat('dd-MM-yyyy').format(pickedDate);
                      });
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: startTimeController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.calendar_today), //icon of text field
                    labelText: "Выберите время начала",
                  ),
                  onTap: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      initialTime: TimeOfDay.now(),
                      context: context,
                    );

                    if (pickedTime != null) {
                      print(pickedTime.format(context)); //output 10:51 PM
                      DateTime parsedTime = DateFormat.jm()
                          .parse(pickedTime.format(context).toString());
                      //converting to DateTime so that we can further format on different pattern.
                      print(parsedTime);
                      String formattedTime =
                          DateFormat('HH:mm', 'ru_RU').format(parsedTime);
                      print(formattedTime); //output 14:59:00
                      //DateFormat() is from intl package, you can format the time on any pattern you need.

                      setState(() {
                        startTimeController.text =
                            formattedTime; //set the value of text field.
                      });
                    } else {
                      print("Time is not selected");
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: endTimeController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.calendar_today),
                    labelText: "Выберите время конца",
                  ),
                  onTap: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      initialTime: TimeOfDay.now(),
                      context: context,
                    );

                    if (pickedTime != null) {
                      print(pickedTime.format(context));
                      DateTime parsedTime = DateFormat.jm()
                          .parse(pickedTime.format(context).toString());

                      print(parsedTime);
                      String formattedTime =
                          DateFormat('HH:mm', 'ru_RU').format(parsedTime);
                      print(formattedTime);

                      setState(() {
                        endTimeController.text = formattedTime;
                      });
                    } else {
                      print("Time is not selected");
                    }
                  },
                ),
                Container(
                  margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black.withOpacity(0.3))),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Text(
                              'Имя',
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                  color: Colors.black),
                            ),
                            Spacer(),
                            Text(
                              name,
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                  color: Colors.black.withOpacity(0.5)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                        child: Divider(
                            thickness: 1, color: Colors.black.withOpacity(0.5)),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Text(
                              'Фамилия',
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                  color: Colors.black),
                            ),
                            Spacer(),
                            Text(
                              surname,
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                  color: Colors.black.withOpacity(0.5)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                        child: Divider(
                            thickness: 1, color: Colors.black.withOpacity(0.5)),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Text(
                              'Номер',
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                  color: Colors.black),
                            ),
                            Spacer(),
                            Text(
                              phoneNumber,
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                  color: Colors.black.withOpacity(0.5)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                        child: Divider(
                            thickness: 1, color: Colors.black.withOpacity(0.5)),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Text(
                              'E-mail',
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                  color: Colors.black),
                            ),
                            Spacer(),
                            Text(
                              email,
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                  color: Colors.black.withOpacity(0.5)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  child: Text('Отправить'),
                  onPressed: () {
                    saveData(
                        name,
                        surname,
                        email,
                        phoneNumber,
                        dateController.text,
                        startTimeController.text,
                        endTimeController.text);
                    final snackBar = SnackBar(
                      content: const Text(
                        'Заявка успешно отправлена!',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.green,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    Navigator.pop(context);
                  },
                ),
                
              ],
            ),
          ),
        ),
      ]),
    );
  }
}*/






  /*DateTime selectedDate = DateTime.now();
  TimeOfDay selectedStartTime = TimeOfDay.now();
  TimeOfDay selectedEndTime = TimeOfDay.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await DatePicker.showDatePicker(
      context, 
      showTitleActions: true,
      minTime: DateTime.now(),
      maxTime: DateTime(2023, 4, 22),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedStartTime,
      
    );
    if (picked != null && picked != selectedStartTime)
      setState(() {
        selectedStartTime = picked;
      });
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedEndTime,
      
    );
    if (picked != null && picked != selectedEndTime)
      setState(() {
        selectedEndTime = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              _selectDate(context);
            },
            child: Text('Select Date'),
          ),
          ElevatedButton(
            onPressed: () {
              _selectStartTime(context);
            },
            child: Text('Select Start Time'),
          ),
          ElevatedButton(
            onPressed: () {
              _selectEndTime(context);
            },
            child: Text('Select End Time'),
          ),
          Text('Selected Date: ${selectedDate.toString()}'),
          Text('Selected Start Time: ${selectedStartTime.toString()}'),
          Text('Selected End Time: ${selectedEndTime.toString()}'),
        ],
      ),
    );
  }

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  TextEditingController _phoneController = TextEditingController();


Future<void> _selectTime(BuildContext context) async {
  DatePicker.showTimePicker(
    context,
    showTitleActions: true,
    onConfirm: (time) {
      setState(() {
        selectedTime = time;
      });
    },
    currentTime: selectedTime,
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:  Column(
        children: [
          TextButton(
                    onPressed: () {
                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          minTime: DateTime.now(),
                          maxTime: DateTime(2023, 4, 22),
                          theme: DatePickerTheme(
                              headerColor: Colors.black,
                              backgroundColor: Colors.black,
                              itemStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                              doneStyle:
                                  TextStyle(color: Colors.white, fontSize: 16)),
                          onChanged: (date) {
                        print('change $date in time zone ' +
                            date.timeZoneOffset.inHours.toString());
                      }, onConfirm: (date) {
                        print('confirm $date');
                      }, currentTime: DateTime.now(), locale: LocaleType.en);
                    },
                    child: Text(
                      'show date picker(custom theme &date time range)',
                      style: TextStyle(color: Colors.blue),
                    )),
        ],
      ),
    );
  }
}
*/