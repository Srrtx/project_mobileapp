import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project_mobileapp/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileUser extends StatefulWidget {
  // final int userId;
  // final String userName;
  // final String userEmail;

  @override
  _ProfileUserState createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser> {
  Map<String, dynamic>? userProfile;

  bool isLoading = true;

  Future<void> fetchProfile() async {
    final prefs = await SharedPreferences.getInstance();
    int? userID = await prefs.getInt('user_id');
    String? jwtToken = prefs.getString('jwtToken');

    if (jwtToken == null) {
      print('No token found');
      _logout();
      return;
    }
    debugPrint(jwtToken);

    print('Retrieved token: $jwtToken'); // ตรวจสอบว่า token ถูกดึงมาได้หรือไม่
    debugPrint(userID.toString());

    final url = Uri.parse('http://192.168.127.1:3000/profile/${userID}');

    try {
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $jwtToken'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          userProfile = data;
        });
      } else if (response.statusCode == 401) {
        print('Unauthorized: Token expired or invalid');
        _logout();
      } else if (response.statusCode == 404) {
        print('Profile not found');
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching profile: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _logout() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Profile')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: SingleChildScrollView(
        child: Container(
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
                        userProfile?['username'] ?? 'Loading...',
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
                              'Full Name: ${userProfile?['name'] ?? 'Loading...'}',
                              style: const TextStyle(fontSize: 14),
                            ),
                            Text(
                              'Email: ${userProfile?['email'] ?? 'Loading...'}',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: _logout,
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
    );
  }
}
