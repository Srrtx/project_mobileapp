import 'package:flutter/material.dart';
import 'package:project_mobileapp/User(student)/History_user.dart';
import 'Room_select.dart';
import 'Check_status.dart';
import 'Profile_user.dart';

class HomeUser extends StatefulWidget {
  const HomeUser({super.key});

  @override
  State<HomeUser> createState() => _HomeState();
}

class _HomeState extends State<HomeUser> {
  @override
  Widget build(BuildContext context) {
    // Get the current date and time
    DateTime now = DateTime.now();
    String currentDate = '${now.day}/${now.month}/${now.year}';
    String currentTime = '${now.hour}:${now.minute.toString().padLeft(2, '0')}';

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
            MaterialPageRoute(builder: (context) => const CheckStatus()),
          );
          break;
        case 2:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HistoryUser()),
          );
          break;
        case 3:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ProfileUser()),
          );
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
          SingleChildScrollView(
            child: Padding(
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
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const Roomselect()), // Change this if necessary
                    );
                  },
                  child: const RoomCard(
                      roomName: 'Meeting Room 1', occupancy: '2/4'),
                ),
                const RoomCard(roomName: 'Meeting Room 2', occupancy: '1/4'),
                const RoomCard(roomName: 'Meeting Room 3', occupancy: '0/4'),
              ],
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

class RoomCard extends StatelessWidget {
  final String roomName;
  final String occupancy;

  const RoomCard({super.key, required this.roomName, required this.occupancy});

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
                  Text(
                    occupancy,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
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
