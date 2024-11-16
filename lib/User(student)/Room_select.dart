import 'dart:async';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_mobileapp/User(student)/Check_status.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class RoomSelect extends StatefulWidget {
  final int roomId;
  final String roomName;
  // final int timeslotId;
  const RoomSelect({
    Key? key,
    required this.roomId,
    required this.roomName,
    // required this.timeslotId
  }) : super(key: key);

  @override
  State<RoomSelect> createState() => _RoomSelectState();
}

class _RoomSelectState extends State<RoomSelect> {
  List<dynamic> timeSlots = [];
  late String currentDate;
  late String currentTime;

  @override
  void initState() {
    super.initState();
    fetchTimeSlots();
    setCurrentDateTime();
  }

  void setCurrentDateTime() {
    DateTime now = DateTime.now();
    currentDate = '${now.day}/${now.month}/${now.year}';
    currentTime = '${now.hour}:${now.minute.toString().padLeft(2, '0')}';
  }

  Future<void> fetchTimeSlots() async {
    final roomId = widget.roomId; // Ensure this is a valid string or number
    final url = Uri.parse('http://192.168.183.1:3000/rooms/$roomId/timeslots');
    print("Fetching time slots for room ID: $roomId");
    print("Request URL: $url");

    try {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('jwtToken');

      if (token == null) {
        print("Token is not available");
        return;
      }

      // Decode token payload for debugging
      try {
        final jwt = JWT.decode(token);
        print("Decoded Token Payload: ${jwt.payload}");
      } catch (e) {
        print("Error decoding token: $e");
      }

      final response = await http
          .get(url, headers: {'Authorization': 'Bearer $token'}).timeout(
        const Duration(seconds: 10),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          timeSlots = (data['timeslots'] as List)
              .map((slot) => TimeSlot.fromJson(slot))
              .toList();
        });
        print("Time slots loaded successfully: $timeSlots");
      } else {
        print('Failed to load time slots, status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load time slots');
      }
    } catch (e) {
      print('An error occurred while fetching time slots: $e');
    }
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwtToken', token);
    print('Token saved: $token');
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    print("SharedPreferences initialized");
    return prefs.getString('jwtToken');
  }

  Future<String?> extractUsernameFromToken() async {
    String? token = await getToken();
    print("Retrieved token: $token");
    if (token == null) {
      print("No token found in SharedPreferences");
      return null;
    }
    print("Retrieved token: $token");
    try {
      final decodedToken = JWT.decode(token);
      print("Decoded Token: $decodedToken");
      return decodedToken.payload['username'];
    } catch (e) {
      print("Error decoding JWT: $e");
      return null;
    }
  }

  Future<int?> extractUserIdFromToken(String token) async {
    try {
      final decodedToken = JWT.decode(token); // Decoding the token
      print("Decoded Token: ${decodedToken.payload}");

      // Retrieve the userId from the token payload
      if (decodedToken.payload.containsKey('userId')) {
        return decodedToken.payload['userId']
            as int?; // Casting to int if expected
      } else {
        print("userId not found in token payload");
        return null;
      }
    } catch (e) {
      print("Error decoding JWT: $e");
      return null;
    }
  }

  // Future<void> makeBooking(int timeslotId) async {
  //   final url = Uri.parse("http://192.168.183.1:3000/booking");
  //   final prefs = await SharedPreferences.getInstance();
  //   final token = prefs.getString("jwtToken");

  //   if (token == null) {
  //     print("Token is not available");
  //     return;
  //   }
  //   // Extract userId from the token
  //   String? userId = (await extractUserIdFromToken(token)) as String?;
  //   if (userId == null) {
  //     print("User ID could not be extracted from token");
  //   }
  //   try {
  //     final decodedToken = JWT.decode(token);
  //     userId = decodedToken.payload[
  //         'userId']; // Replace 'userId' with the actual key in your token payload
  //     print("Extracted userId: $userId");
  //   } catch (e) {
  //     print("Error decoding token: $e");
  //     return;
  //   }

  //   if (userId == null) {
  //     print("userId is missing in the token payload");
  //     return;
  //   }

  //   try {
  //     final decodedToken = JWT.decode(token);

  //     final response = await http.post(
  //       url,
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       },
  //       body: jsonEncode({
  //         "roomId": widget.roomId,
  //         "userId": userId,
  //         "timeslotId": timeslotId,
  //       }),
  //     );

  //     if (response.statusCode == 200) {
  //       print("Booking confirmed!");
  //       setState(() {
  //         timeSlots.firstWhere((slot) => slot.id == timeslotId).status =
  //             'pending';
  //       });
  //     } else {
  //       print("Failed to book time slot: ${response.body}");
  //     }
  //   } catch (e) {
  //     print("Error during booking: $e");
  //   }
  // }

  Future<void> makeBooking(int timeslotId) async {
    final url = Uri.parse("http://192.168.127.1:3000/booking");
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("jwtToken"); // Use "jwtToken" consistently

    if (token == null) {
      print("Token is not available");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Authentication token is missing. Please log in.")),
      );
      return;
    }

    // Extract userId from the token

    int? user_id = prefs.getInt('user_id');
    if (user_id == null) {
      print("User ID could not be extracted from token");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to retrieve user information.")),
      );
      return;
    }

    Map<String, dynamic> requestBody = {
      "roomId": widget.roomId,
      "userId": user_id,
      "timeslotId": timeslotId,
    };

    print("Booking Request Body: ${jsonEncode(requestBody)}"); // Debug log

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 201) {
        // Successfully created booking
        print("Booking confirmed!");

        // setState(() {
        //   timeSlots.firstWhere((slot) => slot.id == timeslotId).status =
        //       'reserved';
        // });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Booking confirmed for $timeslotId.")),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const CheckstatusUser()),
        );
      } else {
        print("Failed to book time slot: ${response.body}");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Failed to book the selected time slot.")),
        );
      }
    } catch (e) {
      print("Error during booking: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text("An error occurred while booking. Please try again.")),
      );
    }
  }

  void _showBookingConfirmation(String time, int timeslotId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Booking"),
          content: Text("Do you want to book the time slot at $time?"),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Confirm"),
              onPressed: () {
                Navigator.of(context).pop();
                makeBooking(timeslotId); // function to call backend API
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.roomName}',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 239, 220, 151),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDateTimeButton(Icons.calendar_today, currentDate),
                _buildDateTimeButton(Icons.access_time, currentTime),
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.asset(
                  'assets/images/meeting.png',
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: timeSlots.isEmpty
                  ? const Center(
                      child:
                          // Text('No available time slots for this room.'),
                          CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: timeSlots.length,
                      itemBuilder: (context, index) {
                        final slot = timeSlots[index];
                        final time = slot.timeslot;
                        final status = slot.status;

                        Color color;
                        String statusText;
                        if (status == 'disabled') {
                          color = Colors.grey;
                          statusText = 'Unavailable';
                        } else if (status == 'reserved') {
                          color = const Color.fromARGB(255, 152, 60, 168);
                          statusText = 'Reserved';
                        } else {
                          color = Colors.green;
                          statusText = 'Free';
                        }
                        return _buildTimeSlot(time, color, statusText, slot.id);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateTimeButton(IconData icon, String label) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 239, 220, 151),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.black),
          SizedBox(width: 8),
          Text(label, style: TextStyle(color: Colors.black)),
        ],
      ),
    );
  }

//   Widget _buildTimeSlot(String time, Color color, String status) {
//     return Card(
//       margin: EdgeInsets.symmetric(vertical: 8),
//       color: color.withOpacity(0.2),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: InkWell(
//         onTap: status == 'free' || status == 'reserved'
//             ? () {
//                 // Show a pop-up dialog on tap
//                 showDialog(
//                   context: context,
//                   builder: (BuildContext context) {
//                     return AlertDialog(
//                       title: Text('Time Slot: $time'),
//                       content: Text('Status: $status'),
//                       actions: [
//                         TextButton(
//                           onPressed: () {
//                             Navigator.of(context).pop(); // Close the dialog
//                           },
//                           child: Text('Close'),
//                         ),
//                       ],
//                     );
//                   },
//                 );
//               }
//             : null, // Disable tap for 'pending' status
//         child: Padding(
//           padding: EdgeInsets.all(16),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Time $time',
//                 style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black),
//               ),
//               Container(
//                 padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
//                 decoration: BoxDecoration(
//                   color: color,
//                   borderRadius: BorderRadius.circular(4),
//                 ),
//                 child: Text(
//                   status,
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

  Widget _buildTimeSlot(
      String time, Color color, final status, int timeslotId) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      color: color.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: status.toString().trim().toLowerCase() == 'free'
            ? () {
                _showBookingConfirmation(time, timeslotId);
              }
            : null,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Time $time',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  status,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TimeSlot {
  final int id;
  final String timeslot;
  final String status;

  TimeSlot({required this.id, required this.timeslot, required this.status});

  factory TimeSlot.fromJson(Map<String, dynamic> json) {
    return TimeSlot(
      id: json['timeslot_id'],
      timeslot: json['time_slot'],
      status: json['status'],
    );
  }
}
