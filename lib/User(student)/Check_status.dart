import 'package:flutter/material.dart';
import 'package:project_mobileapp/Login.dart';
import 'package:project_mobileapp/User(student)/History_user.dart';
import 'package:project_mobileapp/User(student)/Profile_user.dart';
import 'home_user.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class CheckstatusUser extends StatefulWidget {
  const CheckstatusUser({super.key});

  @override
  State<CheckstatusUser> createState() => Fetch();
}

class Fetch extends State<CheckstatusUser> {
  final String _url = 'http://192.168.183.1:3000/';
  bool _isloading = false;
  String username = '';
  List? status;
  @override
  void initState() {
    super.initState();
    getStatus();
  }

  //Fetch data from server
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwtToken', token); // Save token with key 'jwtToken'
    print('Saved token: ${prefs.getString('jwtToken')}');
  }

  Future<void> getStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('jwtToken');
      final username = prefs.getString('username');

      if (token == null || username == null) {
        throw Exception('Token or username not found');
      }

      final response = await http.get(
        Uri.parse('http://192.168.183.1:3000/$username/status'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      print('Request URL: $_url/$username/status');
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final List<dynamic> data = jsonResponse['data'];
        setState(() {
          status = data.map((item) {
            return {
              'room_name': item['room_name'],
              'status': item['status'],
              'time_slot': item['time_slot'],
            };
          }).toList();
        });
      } else {
        throw Exception('Failed to load status');
      }
    } catch (e) {
      print('Error fetching status: $e');
    }
  }

  void popDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Navigation
  int selectedIndex = 1;
  void onDestinationSelected(int index) {
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
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => const HistoryUser()),
        // );
        break;
      case 3:
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => const ProfileUser()),
        // );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Check Status',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
                color: Colors.black87),
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0.5,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SafeArea(
            child: _isloading
                ? const Center(child: CircularProgressIndicator())
                : status != null && status!.isNotEmpty
                    ? ListView.builder(
                        itemCount: status!.length,
                        itemBuilder: (context, index) {
                          final booking = status![index];
                          return Card(
                            margin: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 4.0),
                            color: const Color(0xFFF3F3E0),
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.asset(
                                        'assets/images/meeting.png',
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      )),
                                  const SizedBox(width: 15),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        booking['room_name'],
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'Time: ${booking['time_slot']}',
                                        style: const TextStyle(
                                            fontSize: 14, color: Colors.black),
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            'Status: ',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: booking['status'] ==
                                                      'approved'
                                                  ? Colors.green[100]
                                                  : booking['status'] ==
                                                          'pending'
                                                      ? Colors.amber[100]
                                                      : Colors.red[100],
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              booking['status'].toUpperCase(),
                                              style: TextStyle(
                                                color: booking['status'] ==
                                                        'approved'
                                                    ? Colors.green[700]
                                                    : booking['status'] ==
                                                            'pending'
                                                        ? Colors.amber[700]
                                                        : Colors.red[700],
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    : Center(child: Text("No booking status found")),
          ),
        ),
        bottomNavigationBar: NavigationBar(
          height: 60,
          elevation: 0,
          selectedIndex: selectedIndex,
          onDestinationSelected: onDestinationSelected,
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(
                icon: Icon(Icons.notifications), label: 'Status'),
            NavigationDestination(icon: Icon(Icons.schedule), label: 'History'),
            NavigationDestination(
                icon: Icon(Icons.account_circle), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
