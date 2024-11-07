import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:project_mobileapp/zOther/Homepage_staff.dart'; // Import intl package for date formatting

class HistoryStaff extends StatefulWidget {
  final int userId;

  const HistoryStaff({super.key, required this.userId});

  @override
  _HistoryStaffState createState() => _HistoryStaffState();
}

class _HistoryStaffState extends State<HistoryStaff> {
  late Future<List<HistoryRecord>> _historyRecords;

  @override
  void initState() {
    super.initState();
    _historyRecords = fetchHistory(widget.userId); // Fetch history on init
  }

  Future<List<HistoryRecord>> fetchHistory(int userId) async {
    final response =
        await http.get(Uri.parse('http://172.25.201.47:3000/history/$userId'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((record) => HistoryRecord.fromJson(record)).toList();
    } else {
      throw Exception('Failed to load history');
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
          MaterialPageRoute(builder: (context) => const HomepageStaff()),
        );
        break;
        //case 1:
        //  Navigator.pushReplacement(
        //  context,
        //  MaterialPageRoute(builder: (context) => const CheckstatusUser()),
        //  );
        break;
      case 2:
        //  Navigator.pushReplacement(
        //context,
        //  MaterialPageRoute(builder: (context) => const HistoryUser(userId: widget.userId)),
        //  );
        break;
      case 3:
        // Navigator.pushReplacement(
        //  context,
        //  MaterialPageRoute(builder: (context) => const ProfilePage()),
        // );
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
                future: _historyRecords,
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
                            '$date',
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black),
                          ),
                          Text(
                            'Time: $time',
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black),
                          ),
                          Text(
                            'Booked by: $user',
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
      historyId: json['history_id'],
      roomName: json['room_name'],
      timeSlot: json['time_slot'],
      approverName: json['approver_name'],
      studentName: json['student_name'],
      status: json['status'],
      logDate: json['log_date'],
    );
  }
}
