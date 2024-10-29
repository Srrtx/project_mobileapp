import 'package:flutter/material.dart';

class Roomselect extends StatefulWidget {
  const Roomselect({super.key});

  @override
  State<Roomselect> createState() => _RoomselectState();
}

class _RoomselectState extends State<Roomselect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Meeting Room 1',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        leading: null, // Remove the leading back button from the AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Column(
              children: [
                Row(
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
              ],
            ),
            const SizedBox(height: 16),
            Center(
              child: Image.asset(
                'assets/meeting.png',
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            const BookingSlot(
              time: '08:00-10:00',
              status: '',
              color: Colors.grey,
            ),
            const BookingSlot(
              time: '10:00-12:00',
              status: 'Reserved',
              color: Color(0xFF8979FF),
            ),
            BookingSlot(
              time: '13:00-15:00',
              status: 'Free',
              color: Colors.green,
              onFreeTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor:
                          const Color(0xFFF0EBE3), // Set background color
                      title: const Text('Meeting Room 1'),
                      content: const Text('Time : 13:00-15:00'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                                color: Colors.black), // Cancel text color
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Add booking logic here
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black, // Button color
                          ),
                          child: const Text(
                            'Book',
                            style: TextStyle(
                                color: Colors.white), // Book text color
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            BookingSlot(
              time: '15:00-17:00',
              status: 'Free',
              color: Colors.green,
              onFreeTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor:
                          const Color(0xFFF0EBE3), // Set background color
                      title: const Text('Meeting Room 1'),
                      content: const Text('Time : 15:00-17:00'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                                color: Colors.black), // Cancel text color
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Add booking logic here
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                          ),
                          child: const Text(
                            'Book',
                            style: TextStyle(
                                color: Colors.white), // Book text color
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
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

class BookingSlot extends StatelessWidget {
  final String time;
  final String status;
  final Color color;
  final VoidCallback? onFreeTap;

  const BookingSlot({
    super.key,
    required this.time,
    required this.status,
    required this.color,
    this.onFreeTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: GestureDetector(
        onTap: status == 'Free' ? onFreeTap : null,
        child: Container(
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            title: Text(
              'Time $time',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: status.isNotEmpty
                ? Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      status,
                      style: const TextStyle(color: Colors.white),
                    ),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
