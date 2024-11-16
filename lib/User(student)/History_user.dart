import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
//import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // For JWT storage
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart'; // Importing the JWT package
import 'package:project_mobileapp/User(student)/Profile_user.dart';
import 'package:project_mobileapp/User(student)/home_user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Check_status.dart';

class HistoryUser extends StatefulWidget {
  final String username;

  const HistoryUser({super.key, required this.username});

  @override
  _HistoryUserState createState() => _HistoryUserState();
}

class _HistoryUserState extends State<HistoryUser> {
  late Future<List<HistoryRecord>> _historyRecords;

  @override
  void initState() {
    super.initState();
    _historyRecords = fetchHistory(widget.username);
  }

  Future<String?> _getJwtToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? jwtToken = prefs.getString('jwtToken');
      print("Retrieved JWT Token: $jwtToken");

      if (jwtToken == null) {
        print("JWT token is missing.");
        throw Exception('JWT token not found');
      }

      // Decode and check expiration
      final jwt = JWT.decode(jwtToken);
      final payload = jwt.payload;
      final expiryDate = payload['exp'];
      if (expiryDate != null &&
          DateTime.now().isAfter(
              DateTime.fromMillisecondsSinceEpoch(expiryDate * 1000))) {
        print('JWT token has expired.');
        throw Exception('JWT token expired');
      }

      return jwtToken;
    } catch (e) {
      print("Error fetching JWT token: $e");
      return null;
    }
  }

  // Fetch history records from the API
  Future<List<HistoryRecord>> fetchHistory(String username) async {
    try {
      String? jwtToken = await _getJwtToken();
      if (jwtToken == null) {
        print("Error: JWT token is null");
        throw Exception('JWT token not found or expired');
      }

      final response = await http.get(
        Uri.parse('http://192.168.183.1:3000/$username/history'),
        headers: {
          'Authorization': 'Bearer $jwtToken',
          'Content-Type': 'application/json',
        },
      );

      print("HTTP Response status: ${response.statusCode}");
      print("HTTP Response body: ${response.body}");

      if (response.statusCode == 200) {
        // Parse the JSON response
        final Map<String, dynamic> data = json.decode(response.body);
        if (data.containsKey('data')) {
          final List<dynamic> historyData = data['data'];
          return historyData
              .map((record) => HistoryRecord.fromJson(record))
              .toList();
        } else {
          throw Exception('No history data found in the response');
        }
      } else if (response.statusCode == 404) {
        throw Exception('No history found for user: $username');
      } else {
        // General error handling for other status codes
        final errorData = json.decode(response.body);
        throw Exception(errorData['message'] ?? 'Failed to load history');
      }
    } catch (e) {
      print("Error fetching history: $e");
      throw Exception('Failed to connect to the server');
    }
  }

  String formatDate(String logDate) {
    final DateTime date = DateTime.parse(logDate);
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
  }

  // Get the JWT token from SharedPreferences
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    print("SharedPreferences initialized");
    return prefs.getString('jwtToken');
  }

// Extract username from the JWT token
  Future<String?> extractUsernameFromToken() async {
    String? token = await getToken();
    if (token == null) {
      print("No token found in SharedPreferences");
      return null;
    }

    print("Retrieved token: $token");

    try {
      // Decode the JWT token
      final decodedToken = JWT.decode(token);

      print("Decoded Token: $decodedToken");

      String? username = decodedToken.payload['username'];
      return username;
    } catch (e) {
      print("Error decoding JWT: $e");
      return null;
    }
  }

  // Navigation function
  int _selectedIndex = 2;

  Future<void> _onDestinationSelected(int index) async {
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeUser()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const CheckstatusUser()),
        );
        break;
      case 2:
        // String? username = await extractUsernameFromToken();
        // if (username == null) {
        //   // Handle the null case, for example:
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(
        //         content: Text('Username not found. Please log in again.')),
        //   );
        //   // Optionally, redirect to the login screen if needed
        // } else {
        //   Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => HistoryUser(username: username),
        //     ),
        //   );
        // }
        break;
      case 3:
        String? username = await extractUsernameFromToken();
        if (username == null) {
          // Handle the null case, for example:
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Username not found. Please log in again.')),
          );
          // Optionally, redirect to the login screen if needed
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ProfileUser(),
            ),
          );
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String currentDate = '${now.day}/${now.month}/${now.year}';
    String currentTime = '${now.hour}:${now.minute.toString().padLeft(2, '0')}';

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'History',
          style: TextStyle(
            color: Colors.black,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(240, 235, 227, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 18),
                        const SizedBox(width: 8),
                        Text(
                          currentDate,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(240, 235, 227, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.access_time, size: 18),
                        const SizedBox(width: 8),
                        Text(
                          currentTime,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              FutureBuilder<List<HistoryRecord>>(
                future: _historyRecords,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Error: ${snapshot.error}'),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _historyRecords = fetchHistory(widget.username);
                              });
                            },
                            child: Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No history available.'));
                  } else {
                    final historyRecords = snapshot.data!;
                    return Expanded(
                      child: ListView.builder(
                        itemCount: historyRecords.length,
                        itemBuilder: (context, index) {
                          final record = historyRecords[index];
                          return RoomSlot(
                            roomName: record.roomName,
                            date: formatDate(record.logDate),
                            time: record.timeSlot,
                            user: record.studentName,
                            approver: record.approverName,
                            imagePath: 'assets/images/meeting.png',
                            isApproved:
                                record.status.toLowerCase() == 'approved',
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        height: 60,
        elevation: 0,
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onDestinationSelected,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(
              icon: Icon(Icons.notifications), label: 'Request'),
          NavigationDestination(icon: Icon(Icons.schedule), label: 'History'),
          NavigationDestination(
              icon: Icon(Icons.account_circle), label: 'Profile'),
        ],
      ),
    );
  }
}

class RoomSlot extends StatelessWidget {
  final String roomName;
  final String time;
  final String date;
  final String user;
  final String approver;
  final String imagePath;
  final bool isApproved;

  const RoomSlot({
    super.key,
    required this.roomName,
    required this.time,
    required this.date,
    required this.user,
    required this.approver,
    required this.imagePath,
    required this.isApproved,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        child: Card(
          color: const Color.fromRGBO(240, 235, 227, 1),
          margin: const EdgeInsets.symmetric(vertical: 4),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(15), // Adjust the radius as needed
                  child: Image.asset(
                    imagePath,
                    height: 125,
                    width: 125,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      roomName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(date),
                        const SizedBox(width: 8),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Time:  '),
                        Text(time),
                      ],
                    ),
                    Text(
                      'Booking by: $user',
                      style: const TextStyle(fontSize: 14),
                    ),
                    Text(
                      'Approver: $approver',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      isApproved ? 'Approved' : 'Disapproved',
                      style: TextStyle(
                        color: isApproved ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HistoryRecord {
  final String roomName;
  final String timeSlot;
  final String studentName;
  final String approverName;
  final String status;
  final String logDate;

  HistoryRecord({
    required this.roomName,
    required this.timeSlot,
    required this.studentName,
    required this.approverName,
    required this.status,
    required this.logDate,
  });

  factory HistoryRecord.fromJson(Map<String, dynamic> json) {
    return HistoryRecord(
      roomName: json['room_name'] ??
          'Unknown Room', // Add default values for null fields
      timeSlot: json['time_slot'] ?? 'Unknown Time',
      studentName: json['student_name'] ?? 'Unknown Student',
      approverName: json['approver_name'] ?? 'Unknown Approver',
      status: json['booking_status'] ?? 'Unknown Status',
      logDate: json['log_date'] ?? 'Unknown Date',
    );
  }
}
