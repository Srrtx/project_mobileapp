// import 'package:flutter/material.dart';
// import 'package:project_mobileapp/Staff(admin)/Dashboard_staff.dart';
// import 'package:project_mobileapp/Staff(admin)/add_room.dart';
// import 'package:project_mobileapp/Staff(admin)/edit_room.dart';
// import 'package:project_mobileapp/Staff(admin)/history_staff.dart';
// import 'package:project_mobileapp/Staff(admin)/profile_staff.dart';

// class HomeStaff extends StatefulWidget {
//   final String userId;
//   final String userName;
//   final String userEmail;

//   const HomeStaff({
//     super.key,
//     required this.userId,
//     required this.userName,
//     required this.userEmail,
//   });
//   // @override
//   // const HomeStaff({super.key});

//   @override
//   State<HomeStaff> createState() => _HomeStaffState();
// }

// class _HomeStaffState extends State<HomeStaff> {
//   // List to store room data
//   List<Room> rooms = [
//     Room('Meeting Room', '1', 'assets/images/meeting.png', '2/4',
//         'First meeting room'),
//     Room('Meeting Room', '2', 'assets/images/meeting.png', '1/4',
//         'Second meeting room'),
//     Room('Meeting Room', '3', 'assets/images/meeting.png', '0/4',
//         'Third meeting room'),
//   ];

//   // Variable to keep track of the room number
//   int roomNumberCounter = 4;
//   Widget build(BuildContext context) {
//     // Get the current date and time
//     DateTime now = DateTime.now();
//     String currentDate = '${now.day}/${now.month}/${now.year}';
//     String currentTime = '${now.hour}:${now.minute.toString().padLeft(2, '0')}';

//     //Nav
//     int _selectedIndex = 0;
//     void _onDestinationSelected(int index) {
//       switch (index) {
//         case 0:
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => const HomeStaff(
//                       userId: widget.userId,
//                       userName: widget.userName,
//                       userEmail: widget.userEmail,
//                     )),
//           );
//           break;
//         case 1:
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => const DashboardStaff()),
//           );
//           break;
//         case 2:
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => const HistoryStaff(
//                       userId: widget.userId,
//                     )),
//           );
//           break;
//         case 3:
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => const ProfileStaff(
//                       userId: widget.userId,
//                       userName: widget.userName,
//                       userEmail: widget.userEmail,
//                     )),
//           );
//           break;
//       }
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('All Room'),
//         backgroundColor: Colors.transparent,
//         elevation: 0, // Remove shadow
//         titleTextStyle: const TextStyle(
//           color: Colors.black,
//           fontSize: 28,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               // Date and Time Row
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   // Date container
//                   Container(
//                     padding:
//                         const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                     decoration: BoxDecoration(
//                       color: const Color.fromRGBO(240, 235, 227, 1),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Row(
//                       children: [
//                         const Icon(Icons.calendar_today, size: 18),
//                         const SizedBox(width: 8),
//                         Text(
//                           currentDate,
//                           style: const TextStyle(fontSize: 16),
//                         ),
//                       ],
//                     ),
//                   ),
//                   // Time container
//                   Container(
//                     padding:
//                         const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                     decoration: BoxDecoration(
//                       color: const Color.fromRGBO(240, 235, 227, 1),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Row(
//                       children: [
//                         const Icon(Icons.access_time, size: 18),
//                         const SizedBox(width: 8),
//                         Text(
//                           currentTime,
//                           style: const TextStyle(fontSize: 16),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16), // Space between time and room slots

//               // Room Slots Section
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: rooms.length,
//                   itemBuilder: (context, index) {
//                     return RoomSlot(
//                         roomName: rooms[index].name,
//                         roomNumber: rooms[index].number,
//                         imagePath: rooms[index].imagePath,
//                         occupancy: rooms[index].occupancy,
//                         details: rooms[index].details,
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => EditRoom(),
//                             ),
//                           );
//                         });
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       //Nav bar (bottom)
//       bottomNavigationBar: NavigationBar(
//         height: 60,
//         elevation: 0,
//         selectedIndex: _selectedIndex,
//         onDestinationSelected: _onDestinationSelected,
//         destinations: const [
//           NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
//           NavigationDestination(
//               icon: Icon(Icons.pie_chart), label: 'Dashboard'),
//           NavigationDestination(icon: Icon(Icons.schedule), label: 'History'),
//           NavigationDestination(
//               icon: Icon(Icons.account_circle), label: 'Profile'),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => const AddRoom()),
//           );
//           // Action to add a room
//           // _showAddRoomDialog(context);
//         },
//         child: const Icon(Icons.add),
//         backgroundColor: const Color.fromARGB(255, 104, 104, 104),
//       ),
//     );
//   }

//   void _showAddRoomDialog(BuildContext context) {
//     // Controllers to capture user input
//     final TextEditingController roomNameController = TextEditingController();
//     final TextEditingController roomDetailsController = TextEditingController();

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Add Room'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller: roomNameController,
//                 decoration: const InputDecoration(labelText: 'Room Name'),
//               ),
//               // Room Number (auto-generated)
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 10),
//                 child: Row(
//                   children: [
//                     Text(
//                       '$roomNumberCounter', // Auto-generated room number
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               TextField(
//                 controller: roomDetailsController,
//                 decoration: const InputDecoration(labelText: 'Room Details'),
//                 maxLines: 3,
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 // Capture the input data and add it to the rooms list
//                 String roomName = roomNameController.text;
//                 String roomDetails = roomDetailsController.text;

//                 // Ensure that roomName and roomDetails are not empty to avoid null-related errors
//                 if (roomName.isNotEmpty && roomDetails.isNotEmpty) {
//                   setState(() {
//                     // Add the new room to the list
//                     rooms.add(Room(
//                       roomName,
//                       roomNumberCounter
//                           .toString(), // Auto-generated room number
//                       'assets/images/meeting.png',
//                       '0/4', // Default occupancy for new rooms
//                       roomDetails,
//                     ));

//                     // Increment the room number counter for the next room
//                     roomNumberCounter++;
//                   });
//                 }

//                 Navigator.of(context).pop(); // Close the dialog
//               },
//               child: const Text('Add'),
//             ),
//             TextButton(
//               onPressed: () {
//                 // Navigator.push(
//                 //   context,
//                 //   MaterialPageRoute(builder: (context) => const AddRoom()),
//                 // ); // Close the dialog
//               },
//               child: const Text('Close'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// // Room model class with non-nullable fields
// class Room {
//   String name;
//   String number;
//   String imagePath;
//   String occupancy;
//   String details;

//   Room(this.name, this.number, this.imagePath, this.occupancy, this.details);
// }

// class RoomSlot extends StatelessWidget {
//   final String roomName;
//   final String roomNumber;
//   final String imagePath;
//   final String occupancy;
//   final String details; // Include details for editing
//   final VoidCallback onTap; // Add onTap callback

//   const RoomSlot({
//     Key? key,
//     required this.roomName,
//     required this.roomNumber,
//     required this.imagePath,
//     required this.occupancy,
//     required this.details,
//     required this.onTap, // Accept onTap as a parameter
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap, // Trigger the onTap callback
//       child: Card(
//         color: const Color.fromRGBO(240, 235, 227, 1),
//         margin: const EdgeInsets.symmetric(vertical: 8),
//         elevation: 4,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Container(
//           height: 120, // Larger height for the card
//           padding: const EdgeInsets.all(12),
//           child: Row(
//             children: [
//               // Image with larger size
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(8),
//                 child: Image.asset(
//                   imagePath,
//                   width: 100,
//                   height: 100, // Increased image size
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               const SizedBox(width: 16), // Space between image and text
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       '$roomName $roomNumber',
//                       style: const TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       '$occupancy',
//                       style: const TextStyle(
//                         fontSize: 16,
//                         color: Colors.grey,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
