import 'package:flutter/material.dart';

class BookingReq extends StatefulWidget {
  const BookingReq({super.key});

  @override
  State<BookingReq> createState() => _BookingReqState();
}

class _BookingReqState extends State<BookingReq> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Booking Request',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        leading: null, // Remove the leading back button from the AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row containing calendar and access time
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Card(
                  color: Color(0xFFF0EBE3),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(Icons.calendar_today),
                        SizedBox(width: 8),
                        Text(
                          '21/10/24',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  color: Color(0xFFF0EBE3),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(Icons.access_time),
                        SizedBox(width: 8),
                        Text(
                          '10:42',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // List of booking requests
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(0), // Reset padding for list view
                children: const [
                  BookingRequestCard(
                    roomName: 'Meeting Room 1',
                    time: '13:00-15:00',
                    user: 'User1',
                  ),
                  BookingRequestCard(
                    roomName: 'Meeting Room 3',
                    time: '10:00-12:00',
                    user: 'User3',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
      ),
    );
  }
}

class BookingRequestCard extends StatelessWidget {
  final String roomName;
  final String time;
  final String user;

  const BookingRequestCard({
    super.key,
    required this.roomName,
    required this.time,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFF0EBE3), // Set the background color here
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Image.asset(
              'assets/meeting.png',
              width: 160,
              height: 160,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    roomName,
                    style: const TextStyle(
                      fontSize: 18, // ปรับขนาดตามต้องการ
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Time: $time',
                    style: TextStyle(fontSize: 16), // เพิ่มขนาดตัวอักษร
                  ),
                  Text(
                    'Book: $user',
                    style: TextStyle(fontSize: 16), // เพิ่มขนาดตัวอักษร
                  ),
                  Row(
                    children: [
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.purple,
                          side: const BorderSide(color: Colors.purple),
                        ),
                        child: Row(
                          children: const [
                            Icon(Icons.close),
                            SizedBox(width: 8),
                            Text(
                              'N',
                              style:
                                  TextStyle(fontSize: 16), // ปรับขนาดตัวอักษร
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 18),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                        ),
                        child: Row(
                          children: const [
                            Icon(Icons.check, color: Colors.white),
                            SizedBox(width: 8),
                            Text(
                              'Y',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white), // ปรับขนาดตัวอักษร
                            ),
                          ],
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
