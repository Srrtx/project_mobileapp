import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:project_mobileapp/User(student)/Check_status.dart';
import 'package:project_mobileapp/User(student)/History_user.dart';
import 'package:project_mobileapp/User(student)/Profile_user.dart';
import 'package:project_mobileapp/Login.dart';

class ProfileUser extends StatefulWidget {
  final String username;
  ProfileUser({required this.username});

  @override
  _ProfileUserState createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser> {
  Map<String, dynamic>? userProfile;
  String? userName;
  String? userEmail;
  int _selectedIndex = 0;

  Future<void> fetchProfile() async {
    final response = await http.get(
      Uri.parse('http://localhost:3000/profile/${widget.username}'),
    );

     if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        userProfile = data;
        userName = data['name'];
        userEmail = data['email'];
      });
    } else if (response.statusCode == 404) {
      print('No booking history found for this user');
    } else {
      print('Error: ${response.statusCode}');
    }
  }


  @override
  void initState() {
    super.initState();
    fetchProfile();
  }


  @override
  Widget build(BuildContext context) {
    //Nav
    int _selectedIndex = 0;
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
            MaterialPageRoute(builder: (context) => const HistoryUser),
          );
          break;
        case 3:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ProfileUser(),
          );
          break;
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Your Profile',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFF0EBE3),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            AssetImage('assets/images/Profile.png'),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.userName,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'About',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16.0),
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Full Name: ${userName}',
                                style: const TextStyle(fontSize: 14),
                              ),
                              Text('Email: ${userEmail}',
                                  style: const TextStyle(fontSize: 14)),
                            ],
                          )),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: Colors.red),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.exit_to_app, color: Colors.red),
                              SizedBox(width: 8),
                              Text(
                                'Logout',
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
              icon: Icon(Icons.pie_chart), label: 'Dashboard'),
          NavigationDestination(icon: Icon(Icons.schedule), label: 'History'),
          NavigationDestination(
              icon: Icon(Icons.account_circle), label: 'Profile'),
        ],
      ),
    );
  }
}
