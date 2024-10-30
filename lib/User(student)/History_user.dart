import 'package:flutter/material.dart';

class HistoryUser extends StatelessWidget {
  const HistoryUser({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the current date and time
    DateTime now = DateTime.now();
    String currentDate = '${now.day}/${now.month}/${now.year}';
    String currentTime = '${now.hour}:${now.minute.toString().padLeft(2, '0')}';

    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
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
              // Date and Time Row
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
              const SizedBox(height: 16), // Space between time and room slots

              // Room Slots Section
              Expanded(
                child: ListView(
                  children: const [
                    RoomSlot(
                      roomName: 'Meeting Room 1',
                      date: '20/10/2024',
                      time: '13:00-15:00',
                      user: 'User1',
                      approver: 'John',
                      imagePath: 'assets/images/meeting.png',
                      isApproved: true,
                    ),
                    RoomSlot(
                      roomName: 'Meeting Room 2',
                      date: '18/10/2024',
                      time: '10:00-12:00',
                      user: 'User1',
                      approver: 'S',
                      imagePath: 'assets/images/meeting.png',
                      isApproved: false,
                    ),
                    RoomSlot(
                      roomName: 'Meeting Room 3',
                      date: '17/10/2024',
                      time: '15:00-17:00',
                      user: 'User1',
                      approver: 'S',
                      imagePath: 'assets/images/meeting.png',
                      isApproved: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // Nav bar (bottom)
      bottomNavigationBar: NavigationBar(
        height: 60,
        elevation: 0,
        selectedIndex: 3,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(
              icon: Icon(Icons.notifications), label: 'Status'),
          NavigationDestination(
              icon: Icon(Icons.dashboard), label: 'Dashboard'),
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
  final bool isApproved; // Add this property to define the approval status

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
        splashColor: Colors.grey.withOpacity(0.3), // Add splash effect
        borderRadius:
            BorderRadius.circular(12), // Match with card's border radius
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
                    // Image section
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        imagePath,
                        width: 130,
                        height: 130,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Room info section
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            roomName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            ' $date',
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black),
                          ),
                          Text(
                            'Time: $time',
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black),
                          ),
                          Text(
                            'Booked: $user',
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black),
                          ),
                          Text(
                            'Approver: $approver',
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                // Approver/Disapprover button display
                Align(
                  alignment: Alignment.centerRight, // Move button to the right
                  child: Padding(
                    padding: const EdgeInsets.only(
                        right: 40.0), // Adjust padding to fine-tune position
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isApproved
                            ? Colors.green
                            : Colors.red, // Fixed color based on approval
                        minimumSize: const Size(90, 35), // Adjust button size
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10), // Rounder button
                        ),
                      ),
                      // Remove onPressed to make button unclickable
                      onPressed: () {},
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
