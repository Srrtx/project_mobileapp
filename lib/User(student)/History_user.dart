import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:project_mobileapp/Approver/history_approver.dart';
import 'package:project_mobileapp/User(student)/Check_status.dart';
import 'package:project_mobileapp/User(student)/Profile_user.dart';
import 'package:project_mobileapp/User(student)/home_user.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryUser extends StatefulWidget {
  // const HistoryUser({
  //   super.key,
  //   required this.username,
  //   required bookingHistory,
  // });

  @override
  _HistoryUserState createState() => _HistoryUserState();
}

class _HistoryUserState extends State<HistoryUser> {
  late Future<List<HistoryRecord>> _historyRecords;

  @override
  void initState() {
    super.initState();
    _historyRecords = _fetchHistory();
  }

  // Future<Map<String, dynamic>> getDataFromSharedPreferences() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   String? jwtToken = prefs.getString('jwt_token');
  //   String? username =
  //       prefs.getString('username'); // Assuming you saved the username

  //   return {
  //     'jwtToken': jwtToken,
  //     'username': username,
  //   };
  // }

  Future<List<HistoryRecord>> _fetchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token'); // Retrieve JWT token
    final username = prefs
        .getString('username'); // Retrieve the username from SharedPreferences

    if (token != null && username != null) {
      final response = await http.get(
        Uri.parse('http://172.25.236.139:3000/$username/history'),
        headers: {
          'Authorization': 'Bearer $token', // Include the JWT in request header
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((record) => HistoryRecord.fromJson(record)).toList();
      } else if (response.statusCode == 404) {
        throw Exception('No history found for user: $username');
      } else {
        throw Exception('Failed to load history');
      }
    } else {
      throw Exception('No JWT token or username found');
    }
  }

  String formatDate(String logDate) {
    final DateTime date = DateTime.parse(logDate);
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
  }

  int _selectedIndex = 2;

  void _onDestinationSelected(int index) {
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
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HistoryUser()),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProfileUser()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get current date and time
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
              // Date and time display
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

              // History List with FutureBuilder
              FutureBuilder<List<HistoryRecord>>(
                future: _historyRecords,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: TextStyle(color: Colors.red),
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
                            imagePath:
                                'assets/images/meeting.png', // Use appropriate image path
                            isApproved: record.status == 'Approved',
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

  Text buildText(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 14, color: Colors.black),
    );
  }

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        imagePath,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            roomName,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          buildText(date),
                          buildText('Time: $time'),
                          buildText('Booked by: $user'),
                          buildText('Approver: $approver'),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isApproved ? Colors.green : Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 8),
                      child: Text(
                        isApproved ? 'Approved' : 'Disapproved',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
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
  final int historyId;
  final String roomName;
  final String timeSlot;
  final String approverName;
  final String studentName;
  final String status;
  final String logDate;

  HistoryRecord({
    required this.historyId,
    required this.roomName,
    required this.timeSlot,
    required this.approverName,
    required this.studentName,
    required this.status,
    required this.logDate,
  });

  factory HistoryRecord.fromJson(Map<String, dynamic> json) {
    return HistoryRecord(
      historyId: json['history_id'] ?? 0, // Handle null with default value
      roomName: json['room_name'] ?? 'Unknown Room',
      timeSlot: json['time_slot'] ?? 'N/A',
      approverName: json['approver_name'] ?? 'Unknown',
      studentName: json['student_name'] ?? 'Unknown Student',
      status: json['status'] ?? 'N/A',
      logDate: json['log_date'] ?? 'N/A',
    );
  }
}
