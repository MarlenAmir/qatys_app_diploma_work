import 'package:flutter/material.dart';
import 'package:booking_calendar/booking_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:table_calendar/table_calendar.dart';

class BookingDialog extends StatefulWidget {
  @override
  _BookingDialogState createState() => _BookingDialogState();
}

class _BookingDialogState extends State<BookingDialog> {
  late DateTime _selectedDate;
  late TimeOfDay _startTime;
  late TimeOfDay _endTime;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _startTime = TimeOfDay.now();
    _endTime = TimeOfDay.now();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Column(
        children: [
          SizedBox(height:20),
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
            title: Text('Start Time'),
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
            title: Text('End Time'),
            trailing: Text(_endTime!.format(context)),
            onTap: () {
              DatePicker.showTimePicker(
                context,
                currentTime: DateTime.now(),
                onConfirm: (time) =>
                    _selectEndTime(TimeOfDay.fromDateTime(time)),
              );
            },
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
              } else {
                // Handle case where any of the values is not selected
                print('Please select all values');
              }
            },
            child: Text('Book'),
          ),
        ],
      ),
    );
  }
}
