import 'package:flutter/material.dart';
import 'package:project_mobileapp/User(student)/home.dart';
import 'package:project_mobileapp/User(student)/timeslots.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

// void main() {
//   runApp(MaterialApp(
//     home: Timeslots(
//       roomName: 'Meeting Room 1', // Provide a proper room name as a String
//       roomImage:
//           'assets/images/meeting.png', // Ensure this is the path to your image
//     ),
//     debugShowCheckedModeBanner: false,
//   ));
// }
