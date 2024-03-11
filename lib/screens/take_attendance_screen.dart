import 'package:flutter/material.dart';
import 'attendance_screen.dart';

class TakeAttendanceScreen extends StatefulWidget {
  @override
  _TakeAttendanceScreenState createState() => _TakeAttendanceScreenState();
}

class _TakeAttendanceScreenState extends State<TakeAttendanceScreen> {
  final TextEditingController _classNameController = TextEditingController();
  final TextEditingController _subjectNameController = TextEditingController();
  final TextEditingController _regularStudentsController = TextEditingController();
  final TextEditingController _lateralStudentsController = TextEditingController();

  DateTime selectedDate = DateTime.now(); // Initialize with the current date

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Take Attendance'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _classNameController,
              decoration: InputDecoration(labelText: 'Name of the Class'),
            ),
            TextField(
              controller: _subjectNameController,
              decoration: InputDecoration(labelText: 'Subject Name'),
            ),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: AbsorbPointer(
                child: TextField(
                  controller: TextEditingController(
                    text: "${selectedDate.toLocal()}".split(' ')[0],
                  ),
                  decoration: InputDecoration(labelText: 'Date'),
                ),
              ),
            ),
            TextField(
              controller: _regularStudentsController,
              decoration:
              InputDecoration(labelText: 'Number of Regular Students'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _lateralStudentsController,
              decoration:
              InputDecoration(labelText: 'Number of Lateral Students'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _selectDate(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AttendanceScreen(
                      className: _classNameController.text,
                      subjectName: _subjectNameController.text,
                      date: "${selectedDate.toLocal()}".split(' ')[0],
                      regularStudentsCount:
                      int.parse(_regularStudentsController.text),
                      lateralStudentsCount:
                      int.parse(_lateralStudentsController.text),
                    ),
                  ),
                );
              },
              child: Text('Start'),
            ),
          ],
        ),
      ),
    );
  }
}
