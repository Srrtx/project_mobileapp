import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Check_status.dart';
import 'home_user.dart';

class HistoryUser extends StatefulWidget {
  final String username;

  const HistoryUser({super.key, required this.username});

  @override
  _HistoryUserState createState() => _HistoryUserState();
}

class _HistoryUserState extends State<HistoryUser> {
  // late Future<List<HistoryRecord>> _historyRecords;

  // @override
  // void initState() {
  //   super.initState();
  //   _historyRecords = fetchHistory(widget.username); // ใช้ widget.username
  // }

  // Future<List<HistoryRecord>> fetchHistory(String username) async {
  //   try {
  //     final response = await http.get(Uri.parse(
  //         'http://192.168.183.1:3000/$username/history')); // ส่ง username ไปใน URL

  //     if (response.statusCode == 200) {
  //       // แปลง JSON response ที่ได้เป็น Map<String, dynamic>
  //       final Map<String, dynamic> data = json.decode(response.body);

  //       // ตรวจสอบว่า key 'data' มีอยู่หรือไม่ และแปลงข้อมูลใน 'data' เป็น List
  //       if (data.containsKey('data')) {
  //         final List<dynamic> historyData = data['data'];

  //         // แปลง List ของประวัติจาก JSON เป็น List ของ HistoryRecord
  //         return historyData
  //             .map((record) => HistoryRecord.fromJson(record))
  //             .toList();
  //       } else {
  //         throw Exception('No data found in response');
  //       }
  //     } else {
  //       throw Exception('Failed to load history');
  //     }
  //   } catch (e) {
  //     print("Error fetching history: $e");
  //     throw Exception('Failed to connect to the server');
  //   }
  // }

//***Try Config JWT to get data
  final String _url = 'http://192.168.183.1:3000/';
  bool _isloading = false;
  String username = '';
  late Future<List<HistoryRecord>> history; // Change this to a Future
  @override
  void initState() {
    super.initState();
    history = getStatus();
  }

  //Fetch data from server
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwtToken', token); // Save token with key 'jwtToken'
    print('Saved token: ${prefs.getString('jwtToken')}');
  }

  Future<List<HistoryRecord>> getStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('jwtToken');
      final username = prefs.getString('username');

      if (token == null || username == null) {
        throw Exception('Token or username not found');
      }

      final response = await http.get(
        Uri.parse('http://192.168.183.1:3000/$username/history'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      print('Request URL: $_url/$username/history');
      print('Response history code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final List<dynamic> data = jsonResponse['data'];
        // setState(() {
        //   history = data.map((item) {
        //     return {
        //       'roomName': item['room_name'],
        //       'timeSlot': item['time_slot'],
        //       'approverName': item['approved_by'],
        //       'studentName': item['username'],
        //       'status': item['status'],
        //       'logDate': item['log_date'],
        //     };
        //   }).toList();
        return data.map((item) {
          return HistoryRecord.fromJson(item);
        }).toList();
        // });
      } else {
        throw Exception('Failed to load status');
      }
    } catch (e) {
      print('Error fetching status: $e');
    }
  }

  String formatDate(String logDate) {
    final DateTime date = DateTime.parse(logDate);
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
  }

  int _selectedIndex = 2;

  void _onDestinationSelected(int index) {
    if (index == _selectedIndex) return; // Skip if already on the selected page
    _selectedIndex = index;
    // (existing switch code follows)
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
              // Move the date and time below the AppBar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Date container
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
                  // Time container
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
              const SizedBox(
                  height: 16), // Add space between date/time and history list

              // History List
              FutureBuilder<List<HistoryRecord>>(
                future: history,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
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
                            user: record
                                .studentName, // Now directly display studentName
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
              )
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
  final String user; // Student name to show after "Booking by"
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
                          Text(
                            date,
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black),
                          ),
                          Text(
                            'Time: $time',
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black),
                          ),
                          Text(
                            'Booked by: $user', // Display student name here
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black),
                          ),
                          Text(
                            'Approver: $approver',
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isApproved ? Colors.green : Colors.red,
                        borderRadius: BorderRadius.circular(7),
                      ),
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
      historyId: json['history_id'] ?? 0,
      roomName: json['room_name'] ?? 'Unknown Room',
      timeSlot: json['time_slot'] ?? 'Unknown Time Slot',
      approverName: json['approver_name'] ?? 'Unknown Approver',
      studentName: json['student_name'] ?? 'Unknown Student',
      status: json['booking_status'] ?? 'Unknown Status',
      logDate: json['log_date'] ?? DateTime.now().toString(),
    );
  }
}
