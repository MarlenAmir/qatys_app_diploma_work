import 'package:diploma_work/screens/services/payment_services/payment_service.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/firebase_data.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';



class BookingDialog extends StatefulWidget {
  BookingDialog(this.firebaseData);
  final FirebaseData firebaseData;

  @override
  _BookingDialogState createState() => _BookingDialogState();
}

class _BookingDialogState extends State<BookingDialog> {
  PaymentService paymentService = PaymentService();

  String formatDate(DateTime date) {
  final formatter = DateFormat('d MMMM y', 'ru');
  return formatter.format(date);
}

  
  late DateTime _selectedDate;
  late TimeOfDay _startTime;
  late TimeOfDay _endTime;
  String name = "";
  String phoneNumber = "";
  late String _userId;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _startTime = TimeOfDay.now();
    _endTime = TimeOfDay.now();
    User? user = FirebaseAuth.instance.currentUser;
    _userId = user!.uid;
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
    builder:
    (BuildContext context, Widget child) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
        child: child,
      );
    };
  }

  void _selectEndTime(TimeOfDay time) {
    setState(() {
      _endTime = time;
    });
    builder:
    (BuildContext context, Widget child) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
        child: child,
      );
    };
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
          phoneNumber = snapshot.get('phone_number');
          _selectedDate = snapshot.get('selectedDay').toDate();
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Row(
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
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Выберите время",
                    style: GoogleFonts.montserrat(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
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
            SizedBox(height:5),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFF7C821),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      'Выберите время начала',
                      style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    trailing: Text(_startTime.format(context)),
                    onTap: () {
                      DatePicker.showTimePicker(
                        locale: LocaleType.ru,
                        context,
                        currentTime: DateTime.now(),
                        showSecondsColumn: false,
                        onConfirm: (time) =>
                            _selectStartTime(TimeOfDay.fromDateTime(time)),
                      );
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Выберите время конца',
                      style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    trailing: Text(_endTime.format(context)),
                    onTap: () {
                      DatePicker.showTimePicker(
                        context,
                        currentTime: DateTime.now(),
                        showSecondsColumn: false,
                        onConfirm: (time) => _selectEndTime(
                          TimeOfDay.fromDateTime(time),
                        ),
            
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF3892C5),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      'Поле :',
                      style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    trailing: Text(
                      widget.firebaseData.name,
                      style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Имя :',
                      style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    trailing: Text(
                      name,
                      style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Номер :',
                      style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    trailing: Text(
                      phoneNumber,
                      style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color(0xFF646AFF),
              ),
              width: 340,
              height: 40,
              child: TextButton(
                onPressed: () async {
                  if (_selectedDate != null &&
                      _startTime != null &&
                      _endTime != null) {
                    paymentService.makePayment();
                    final FirebaseFirestore firestore =
                        FirebaseFirestore.instance;
                    await firestore.collection('bookings').doc(_userId).collection('user_bookings').add({
                      'SelectedDay': formatDate(_selectedDate),
                      'startDate':
                          '${_startTime.hour.toString().padLeft(2, '0')}:${_startTime.minute.toString().padLeft(2, '0')}',
                      'endDate':
                          '${_endTime.hour.toString().padLeft(2, '0')}:${_endTime.minute.toString().padLeft(2, '0')}',
                      'foregroundName': widget.firebaseData.name,
                      'name': name,
                      'phoneNumber': phoneNumber,
                      'location': widget.firebaseData.location,
                    });
                  } else {
                    print('Please select all values');
                  }
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      Future.delayed(Duration(seconds: 3), () {
                        Navigator.of(context).pop();
                      });

                      return AlertDialog(
                        title: Text(
                          'Успешно!',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                        content: Text(
                          'Данные успешно сохранены.',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Center(
                    child: Text(
                  'Оплатить',
                  style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
