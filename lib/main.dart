import 'package:flutter/material.dart';
import 'screens/take_attendance_screen.dart'; // Import the new screen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tharagathi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tharagathi'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TakeAttendanceScreen()),
                );
              },
              child: Text('Take Attendance'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle 'Student Details' button click
                // Navigate to the 'Student Details' screen or perform related actions
              },
              child: Text('Student Details'),
            ),
          ],
        ),
      ),
    );
  }
}
