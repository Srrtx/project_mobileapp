import 'dart:async';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
    final url = Uri.parse('http://192.168.127.1:3000/rooms/$roomId/timeslots');
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

  // Future<void> bookSlot(BuildContext context) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse('http://169.254.46.6:3000/booking'),
  //       headers: {"Content-Type": "application/json"},
  //       body: json.encode({
  //         "roomId": widget.roomId,
  //         // "userId": widget.userId,
  //         // "timeslotId": widget.timeslotId,
  //       }),
  //     );

  //     if (response.statusCode == 201) {
  //       // Booking successful
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text("Booking successful")),
  //       );
  //     } else {
  //       // Handle error
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text("Booking failed: ${response.body}")),
  //       );
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text("An error occurred")),
  //     );
  //   }
  // }

  Future<void> makeBooking(int timeslotId) async {
    final url = Uri.parse("http://192.168.127.1:3000/booking");
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    if (token == null) {
      print("Token is not available");
      return;
    }

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "roomId": widget.roomId, // Ensure `widget.roomId` is accessible here
          "userId": "<user-id>", // Replace with the actual user ID
          "timeslotId": timeslotId,
        }),
      );

      if (response.statusCode == 201) {
        print("Booking confirmed!");
        // Optionally, refresh the time slot list or show a success message
      } else {
        print("Failed to book time slot: ${response.body}");
      }
    } catch (error) {
      print("Error during booking request: $error");
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
        backgroundColor: Colors.white,
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
                  ? Center(
                      child: Text('No available time slots for this room.'))
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
                        return _buildTimeSlot(time, color, status, 1);
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
        color: Colors.grey[200],
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

  Widget _buildTimeSlot(
      String time, Color color, String status, int timeslotId) {
    return GestureDetector(
      onTap: () {
        print("Time slot tapped: $time");
        if (status == 'Free' || status == 'Reserved') {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Booking Details'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Time: $time'),
                    Text('Status: $status'),
                    if (status == 'Free')
                      const Text('You can book this time slot.'),
                    if (status == 'Reserved')
                      const Text('This time slot is already booked.'),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Close'),
                  ),
                  if (status == 'Free')
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        makeBooking(timeslotId);
                      },
                      child: const Text('Book'),
                    ),
                ],
              );
            },
          );
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Time $time',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
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
