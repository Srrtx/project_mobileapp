// import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
// import 'package:flutter/material.dart';
// import 'package:project_mobileapp/User(student)/History_user.dart'; // Make sure this is correct
// import 'package:shared_preferences/shared_preferences.dart';
// import 'Room_select.dart';
// import 'Check_status.dart';
// import 'Profile_user.dart';

// class HomeUser extends StatefulWidget {
//   const HomeUser({super.key});

//   @override
//   State<HomeUser> createState() => _HomeState();
// }

// class _HomeState extends State<HomeUser> {
//   // Get the JWT token from SharedPreferences
//   Future<String?> getToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     print("SharedPreferences initialized");
//     return prefs.getString('jwtToken');
//   }

//   // Save JWT token and username to SharedPreferences
//   Future<void> saveToken(String token, String username) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('jwtToken', token); // Save token
//     await prefs.setString('username', username); // Save username
//     print('Saved JWT token: $token');
//     print('Saved username: $username');

//     // Verify that the token is saved
//     print("Saved JWT Token: $token");
//     String? savedToken = prefs.getString('jwtToken');
//     print('Token saved: $savedToken');
//   }

//   // Extract username from the JWT token
//   Future<String?> extractUsernameFromToken() async {
//     String? token = await getToken();
//     if (token == null) {
//       print("No token found in SharedPreferences");
//       return null;
//     }

//     print("Retrieved token: $token");

//     try {
//       // Decode the JWT token
//       final decodedToken = JWT.decode(token);

//       print("Decoded Token: $decodedToken");

//       String? username = decodedToken.payload['username'];
//       return username;
//     } catch (e) {
//       print("Error decoding JWT: $e");
//       return null;
//     }
//   }

//   Future<void> delayedSaveToken(String token, String username) async {
//     await Future.delayed(Duration(seconds: 2)); // Simulate delay
//     await saveToken(token, username);
//     String? savedToken = await getToken();
//     print("Delayed token: $savedToken");
//   }

//   // Navigation function
//   int _selectedIndex = 0;

//   Future<void> _onDestinationSelected(int index) async {
//     switch (index) {
//       case 0:
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const HomeUser()),
//         );
//         break;
//       case 1:
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const CheckstatusUser()),
//         );
//         break;
//       case 2:
//         String? username = await extractUsernameFromToken();
//         if (username == null) {
//           // Handle the null case, for example:
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//                 content: Text('Username not found. Please log in again.')),
//           );
//           // Optionally, redirect to the login screen if needed
//         } else {
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               builder: (context) => HistoryUser(username: username),
//             ),
//           );
//         }
//         break;
//       case 3:
//         String? username = await extractUsernameFromToken();
//         if (username == null) {
//           // Handle the null case, for example:
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//                 content: Text('Username not found. Please log in again.')),
//           );
//           // Optionally, redirect to the login screen if needed
//         } else {
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               builder: (context) => ProfileUser(username: username),
//             ),
//           );
//         }
//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Get the current date and time
//     DateTime now = DateTime.now();
//     String currentDate = '${now.day}/${now.month}/${now.year}';
//     String currentTime = '${now.hour}:${now.minute.toString().padLeft(2, '0')}';

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'All Room',
//           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
//         ),
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//         elevation: 0,
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Card(
//                   color: const Color(0xFFF0EBE3), // Beige color
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       children: [
//                         const Icon(Icons.calendar_today),
//                         const SizedBox(width: 8),
//                         Text(
//                           currentDate, // Use dynamic date
//                           style: const TextStyle(fontSize: 16),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Card(
//                   color: const Color(0xFFF0EBE3), // Beige color
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       children: [
//                         const Icon(Icons.access_time),
//                         const SizedBox(width: 8),
//                         Text(
//                           currentTime, // Use dynamic time
//                           style: const TextStyle(fontSize: 16),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: ListView(
//               padding: const EdgeInsets.all(16),
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     // Uncomment to navigate to Room Select
//                     // Navigator.push(
//                     //   context,
//                     //   MaterialPageRoute(
//                     //       builder: (context) => const RoomSelect()),
//                     // );
//                   },
//                   child: const RoomCard(
//                       roomName: 'Meeting Room 1', occupancy: '2/4'),
//                 ),
//                 const RoomCard(roomName: 'Meeting Room 2', occupancy: '1/4'),
//                 const RoomCard(roomName: 'Meeting Room 3', occupancy: '0/4'),
//               ],
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: NavigationBar(
//         height: 60,
//         elevation: 0,
//         selectedIndex: _selectedIndex,
//         onDestinationSelected: _onDestinationSelected,
//         destinations: const [
//           NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
//           NavigationDestination(
//               icon: Icon(Icons.notifications), label: 'Status'),
//           NavigationDestination(icon: Icon(Icons.schedule), label: 'History'),
//           NavigationDestination(
//               icon: Icon(Icons.account_circle), label: 'Profile'),
//         ],
//       ),
//     );
//   }
// }

// class RoomCard extends StatelessWidget {
//   final String roomName;
//   final String occupancy;

//   const RoomCard({super.key, required this.roomName, required this.occupancy});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: const Color(0xFFF0EBE3), // Beige color
//       margin: const EdgeInsets.only(bottom: 16),
//       child: Padding(
//         padding: const EdgeInsets.all(8),
//         child: Row(
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(8),
//               child: Image.asset(
//                 'assets/images/meeting.png',
//                 width: 100,
//                 height: 100,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     roomName,
//                     style: const TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),
//                   const SizedBox(height: 40),
//                   Text(
//                     occupancy,
//                     style: const TextStyle(
//                         color: Colors.black,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
