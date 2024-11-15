import 'dart:convert';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_mobileapp/User(student)/Check_status.dart';
import 'package:project_mobileapp/User(student)/History_user.dart';
import 'package:project_mobileapp/User(student)/Profile_user.dart';
import 'package:project_mobileapp/User(student)/Room_select.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeUser extends StatefulWidget {
  const HomeUser({super.key});

  @override
  State<HomeUser> createState() => _HomeState();
}

class _HomeState extends State<HomeUser> {
  List<Room> rooms = [];

  @override
  void initState() {
    super.initState();
    fetchRooms();
  }

  //Fetch data from server
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    print("SharedPreferences initialized");
    return prefs.getString('jwtToken');
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwtToken', token);
    print('Token saved: $token');
  }

  Future<void> fetchRooms() async {
    try {
      final token = await getToken(); // Retrieve the stored token
      if (token == null) {
        print("Token is not available");
        return;
      }

      final uri = Uri.parse('http://192.168.127.1:3000/rooms');
      final response = await http.get(
        uri,
        headers: {
          'Authorization':
              'Bearer $token', // Attach token in Authorization header
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData.containsKey('rooms')) {
          final List<dynamic> roomData = responseData['rooms'];
          setState(() {
            rooms = roomData.map((room) => Room.fromJson(room)).toList();
          });
          print("Rooms loaded successfully");
        } else {
          print('Unexpected response format: ${response.body}');
        }
      } else {
        print('Failed to load rooms, status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('An error occurred while fetching rooms: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the current date and time
    DateTime now = DateTime.now();
    String currentDate = '${now.day}/${now.month}/${now.year}';
    String currentTime = '${now.hour}:${now.minute.toString().padLeft(2, '0')}';

    // Get the JWT token from SharedPreferences
    Future<String?> getToken() async {
      final prefs = await SharedPreferences.getInstance();
      print("SharedPreferences initialized");
      return prefs.getString('jwtToken');
    }

    // Save JWT token and username to SharedPreferences
    Future<void> saveToken(String token, String username) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwtToken', token); // Save token
      await prefs.setString('username', username); // Save username
      print('Saved JWT token: $token');
      print('Saved username: $username');

      // Verify that the token is saved
      print("Saved JWT Token: $token");
      String? savedToken = prefs.getString('jwtToken');
      print('Token saved: $savedToken');
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

    Future<void> delayedSaveToken(String token, String username) async {
      await Future.delayed(Duration(seconds: 2)); // Simulate delay
      await saveToken(token, username);
      String? savedToken = await getToken();
      print("Delayed token: $savedToken");
    }

    // Navigation function
    int _selectedIndex = 0;

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
                builder: (context) => HistoryUser(username: username),
              ),
            );
          }
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
                builder: (context) => ProfileUser(username: username),
              ),
            );
          }
          break;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'All Room',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Card(
                  color: const Color(0xFFF0EBE3), // Beige color
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_today),
                        const SizedBox(width: 8),
                        Text(
                          currentDate, // Use dynamic date
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  color: const Color(0xFFF0EBE3), // Beige color
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Icon(Icons.access_time),
                        const SizedBox(width: 8),
                        Text(
                          currentTime, // Use dynamic time
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: rooms.length,
              itemBuilder: (context, index) {
                final room = rooms[index];
                return GestureDetector(
                  onTap: () async {
                    // Navigate to RoomSelect screen on card tap

                    String? username = await extractUsernameFromToken();
                    if (username == null) {
                      // Handle the null case, for example:
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                'Username not found. Please log in again.')),
                      );
                      // Optionally, redirect to the login screen if needed
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RoomSelect(
                            roomId: room.roomId,
                            roomName: room.roomName,
                            // timeslotId: room.timeslot_id,
                          ),
                        ),
                      );
                    }
                  },
                  child: RoomCard(
                    roomName: room.roomName,
                  ),
                );
              },
            ),
          ),
        ],
      ),
      //Nav bar (bottom)
      bottomNavigationBar: NavigationBar(
        height: 60,
        elevation: 0,
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onDestinationSelected,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(
              icon: Icon(Icons.notifications), label: 'Status'),
          NavigationDestination(icon: Icon(Icons.schedule), label: 'History'),
          NavigationDestination(
              icon: Icon(Icons.account_circle), label: 'Profile'),
        ],
      ),
    );
  }
}

class Room {
  final String roomName;
  final int roomId;
  // final int timeslot_id;

  Room({
    required this.roomName,
    required this.roomId,
    // required this.timeslot_id
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      roomName: json['room_name'],
      roomId: json['room_id'],
      // timeslot_id: json['timeslot_id'],
    );
  }
}

class RoomCard extends StatelessWidget {
  final String roomName;
  // final String occupancy;

  const RoomCard({
    super.key,
    required this.roomName,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFF0EBE3), // Beige color
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/images/meeting.png',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    roomName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
