import 'package:flutter/material.dart';

class AttendanceResultsScreen extends StatelessWidget {
  final String className;
  final String subjectName;
  final String date;
  final List<String> selectedRollNumbers;
  final int totalRegularStudents;
  final int totalLateralStudents;

  AttendanceResultsScreen({
    required this.className,
    required this.subjectName,
    required this.date,
    required this.selectedRollNumbers,
    required this.totalRegularStudents,
    required this.totalLateralStudents,
  });

  @override
  Widget build(BuildContext context) {
    List<String> allRollNumbers = getAllRollNumbers();
    List<String> presentRollNumbers = getPresentRollNumbers();
    List<String> absentRollNumbers = getAbsentRollNumbers();

    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance Results'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Class: $className'),
            Text('Subject: $subjectName'),
            Text('Date: $date'),
            SizedBox(height: 20),
            Text('Number of Students Present: ${presentRollNumbers.length}'),
            Text('Number of Students Absent: ${absentRollNumbers.length}'),
            SizedBox(height: 20),
            Text('Present: ${presentRollNumbers.join(', ')}'),
            Text('Absent: ${absentRollNumbers.join(', ')}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add your logic here to upload data to cloud storage
                // You can use the Google Drive API or any other cloud storage API.
              },
              child: Text('Upload'),
            ),
          ],
        ),
      ),
    );
  }

  List<String> getAllRollNumbers() {
    List<String> allRollNumbers = [];
    for (int i = 1; i <= totalRegularStudents; i++) {
      allRollNumbers.add(i.toString());
    }
    for (int i = 1; i <= totalLateralStudents; i++) {
      allRollNumbers.add("L$i");
    }
    return allRollNumbers;
  }

  List<String> getPresentRollNumbers() {
    return selectedRollNumbers;
  }

  List<String> getAbsentRollNumbers() {
    List<String> allRollNumbers = getAllRollNumbers();
    List<String> absentRollNumbers =
    allRollNumbers.where((roll) => !selectedRollNumbers.contains(roll)).toList();
    return absentRollNumbers;
  }
}
