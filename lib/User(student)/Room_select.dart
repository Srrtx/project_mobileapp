import 'package:flutter/material.dart';
import 'package:project_mobileapp/User(student)/Check_status.dart';
import 'package:project_mobileapp/User(student)/History_user.dart';
import 'package:project_mobileapp/User(student)/Profile_user.dart';
import 'home_user.dart';

class RoomSelect extends StatefulWidget {
  const RoomSelect({super.key});

  @override
  State<RoomSelect> createState() => _RoomselectState();
}

class _RoomselectState extends State<RoomSelect> {
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
            MaterialPageRoute(builder: (context) => const CheckstatusUser()),
          );
          break;
        case 2:
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(builder: (context) => const HistoryUser),
          // );
          break;
        case 3:
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(builder: (context) => const ProfileUser(),
          // );
          break;
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Meeting Room1',
        ),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
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

                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/images/meeting.png',
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
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
              icon: Icon(Icons.notifications), label: 'Status'),
          NavigationDestination(icon: Icon(Icons.schedule), label: 'History'),
          NavigationDestination(
              icon: Icon(Icons.account_circle), label: 'Profile'),
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
