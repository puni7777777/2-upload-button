import 'package:flutter/material.dart';
import 'attendance_results_screen.dart';

class AttendanceScreen extends StatefulWidget {
  final String className;
  final String subjectName;
  final String date;
  final int regularStudentsCount;
  final int lateralStudentsCount;

  AttendanceScreen({
    required this.className,
    required this.subjectName,
    required this.date,
    required this.regularStudentsCount,
    required this.lateralStudentsCount,
  });

  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  Set<String> selectedRollNumbers = Set();

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
            Text('Class: ${widget.className}'),
            Text('Subject: ${widget.subjectName}'),
            Text('Date: ${widget.date}'),
            SizedBox(height: 20),
            Text('Attendance:'),
            buildAttendanceGrid(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AttendanceResultsScreen(
                      className: widget.className,
                      subjectName: widget.subjectName,
                      date: widget.date,
                      selectedRollNumbers: selectedRollNumbers.toList(),
                      totalRegularStudents: widget.regularStudentsCount,
                      totalLateralStudents: widget.lateralStudentsCount,
                    ),
                  ),
                );
              },
              child: Text('Save Attendance'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAttendanceGrid() {
    int totalRegularStudents = widget.regularStudentsCount;
    int totalLateralStudents = widget.lateralStudentsCount;

    // Create a list of all roll numbers
    List<String> allRollNumbers = [];
    for (int i = 1; i <= totalRegularStudents; i++) {
      allRollNumbers.add(i.toString());
    }
    for (int i = 1; i <= totalLateralStudents; i++) {
      allRollNumbers.add("L$i");
    }

    // Calculate the number of rows needed
    int numberOfRows = (allRollNumbers.length / 5).ceil();

    // Wrap the list of roll numbers in a vertical scrolling ListView
    return Expanded(
      child: ListView.builder(
        itemCount: numberOfRows,
        itemBuilder: (context, rowIndex) {
          return Row(
            children: List.generate(
              5,
                  (columnIndex) {
                int rollIndex = rowIndex * 5 + columnIndex;
                if (rollIndex < allRollNumbers.length) {
                  return buildAttendanceButton(allRollNumbers[rollIndex]);
                } else {
                  return SizedBox(width: 16); // Empty space for padding
                }
              },
            ),
          );
        },
      ),
    );
  }

  Widget buildAttendanceButton(String rollNumber) {
    bool isSelected = selectedRollNumbers.contains(rollNumber);

    return ElevatedButton(
      onPressed: () {
        setState(() {
          // Toggle the selection state of the roll number
          if (isSelected) {
            selectedRollNumbers.remove(rollNumber);
          } else {
            selectedRollNumbers.add(rollNumber);
          }
        });
      },
      style: ElevatedButton.styleFrom(
        primary: isSelected ? Colors.green : null, // Change color when selected
      ),
      child: Text(rollNumber),
    );
  }
}
