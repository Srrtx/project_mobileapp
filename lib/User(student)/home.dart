import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the current date and time
    DateTime now = DateTime.now();
    String currentDate = '${now.day}/${now.month}/${now.year}';
    String currentTime = '${now.hour}:${now.minute.toString().padLeft(2, '0')}';

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Room'),
        backgroundColor: Colors.transparent,
        elevation: 0, // Remove shadow
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
        // centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Date and Time Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Date container
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(243, 243, 224, 1),
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
                  // Time container
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(243, 243, 224, 1),
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
              const SizedBox(height: 16), // Space between time and room slots

              // Room Slots Section
              Expanded(
                child: ListView(
                  children: const [
                    RoomSlot(
                      roomName: 'Meeting Room 1',
                      imagePath: 'assets/images/meeting.png',
                      occupancy: '2/4',
                    ),
                    RoomSlot(
                      roomName: 'Meeting Room 2',
                      imagePath: 'assets/images/meeting.png',
                      occupancy: '1/4',
                    ),
                    RoomSlot(
                      roomName: 'Meeting Room 3',
                      imagePath: 'assets/images/meeting.png',
                      occupancy: '0/4',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.notifications),
      //       label: 'Notifications',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.access_time),
      //       label: 'Schedule',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.account_balance),
      //       label: 'Profile',
      //     ),
      //   ],
      // ),

      bottomNavigationBar: NavigationBar(
        height: 60,
        elevation: 0,
        selectedIndex: 0,
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

class RoomSlot extends StatelessWidget {
  final String roomName;
  final String imagePath;
  final String occupancy;

  const RoomSlot({
    Key? key,
    required this.roomName,
    required this.imagePath,
    required this.occupancy,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromRGBO(243, 243, 224, 1),
      margin: const EdgeInsets.symmetric(vertical: 4),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        height: 120, // Larger height for the card
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Image with larger size
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imagePath,
                width: 100,
                height: 100, // Increased image size
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16), // Space between image and text
            Expanded(
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        roomName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '$occupancy',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
