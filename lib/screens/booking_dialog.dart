import 'package:diploma_work/screens/services/payment_services/payment_service.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/firebase_data.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BookingDialog extends StatefulWidget {
  BookingDialog(this.firebaseData);
  final FirebaseData firebaseData;

  @override
  _BookingDialogState createState() => _BookingDialogState();
}

class _BookingDialogState extends State<BookingDialog> {
  PaymentService paymentService = PaymentService();

  late DateTime _selectedDate;
  late TimeOfDay _startTime;
  late TimeOfDay _endTime;
  String name = "";
  String? surname;
  String? email;
  String phoneNumber = "";
  
  
 

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _startTime = TimeOfDay.now();
    _endTime = TimeOfDay.now();
    loadData();
  }

  void _selectDate(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  void _selectStartTime(TimeOfDay time) {
    setState(() {
      _startTime = time;
    });
  }

  void _selectEndTime(TimeOfDay time) {
    setState(() {
      _endTime = time;
    });
  }

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
      body: ListView(children: [
        Column(
          children: [
            const SizedBox(height: 20),
            TableCalendar(
              calendarFormat: CalendarFormat.month,
              onDaySelected: (date, _) => _selectDate(date),
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: _selectedDate,
              selectedDayPredicate: (day) {
                return isSameDay(day, _selectedDate);
              },
            ),
            ListTile(
              title: Text('Время начала'),
              trailing: Text(_startTime.format(context)),
              onTap: () {
                DatePicker.showTimePicker(
                  locale: LocaleType.ru, // Установите локаль на русский

                  context,
                  currentTime: DateTime.now(),
                  onConfirm: (time) =>
                      _selectStartTime(TimeOfDay.fromDateTime(time)),
                );
              },
            ),
            ListTile(
              title: Text('Время конца'),
              trailing: Text(_endTime.format(context)),
              onTap: () {
                DatePicker.showTimePicker(
                  context,
                  currentTime: DateTime.now(),
                  onConfirm: (time) =>
                      _selectEndTime(TimeOfDay.fromDateTime(time)),
                );
              },
            ),
            ListTile(
              title: Text('Поле :'),
              trailing: Text(widget.firebaseData.name),
            ),
            ListTile(
              title: Text('Имя :'),
              trailing: Text(name),
            ),
            ListTile(
              title: Text('Номер :'),
              trailing: Text(phoneNumber),
            ),
            ElevatedButton(
              onPressed: () {
                if (_selectedDate != null &&
                    _startTime != null &&
                    _endTime != null) {
                 
                  // Perform booking or other actions with the selected date, start time, and end time
                  print('Selected Date: $_selectedDate');
                  print('Start Time: $_startTime');
                  print('End Time: $_endTime');
                  print('Name : $name');
                  print('Поле : ${widget.firebaseData.name}');
                  print('Name : $phoneNumber');
                } else {
                  // Handle case where any of the values is not selected
                  print('Please select all values');
                }
                paymentService.makePayment();
              },
              child: Text("Оплатить"),
            ),
          ],
        ),
      ]),
    );
  }
}
