import 'package:flutter/material.dart';
import 'home_user.dart';
import 'Check_status.dart';
import 'History_user.dart';
import 'Profile_user.dart';

class CheckstatusUser extends StatefulWidget {
  const CheckstatusUser({super.key});

  @override
  State<CheckstatusUser> createState() => _CheckstatusUserState();
}

class _CheckstatusUserState extends State<CheckstatusUser> {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String currentDate = '${now.day}/${now.month}/${now.year}';
    String currentTime = '${now.hour}:${now.minute.toString().padLeft(2, '0')}';

    //Nav
    int _selectedIndex = 1;
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

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Check Status',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  Row(
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
                  const SizedBox(
                    height: 8,
                  ),

                  // Meeting Room 1
                  InkWell(
                    onTap: () {},
                    child: Card(
                      color: const Color(0xFFF3F3E0),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/meeting.png',
                              width: 100,
                              height: 100,
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Meeting Room 1',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                const Text(
                                  'Time: 13.00 - 15.00',
                                  style: TextStyle(color: Colors.black),
                                ),
                                const Row(
                                  children: [
                                    Text(
                                      'Status: ',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    Text(
                                      'Pending',
                                      style: TextStyle(color: Colors.amber),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),

                  // Meeting Room 2
                  InkWell(
                    onTap: () {},
                    child: Card(
                      color: const Color(0xFFF3F3E0),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/meeting.png',
                              width: 100,
                              height: 100,
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Meeting Room 2',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                const Text(
                                  'Time: 08.00 - 10.00',
                                  style: TextStyle(color: Colors.black),
                                ),
                                const Row(
                                  children: [
                                    Text(
                                      'Status: ',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    Text(
                                      'Disapproved',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),

                  // Meeting Room 3
                  InkWell(
                    onTap: () {
                      // Handle the on tap action
                    },
                    child: Card(
                      color: const Color(0xFFF3F3E0),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/meeting.png',
                              width: 100,
                              height: 100,
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Meeting Room 3',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                const Text(
                                  'Time: 15.00 - 17.00',
                                  style: TextStyle(color: Colors.black),
                                ),
                                const Row(
                                  children: [
                                    Text(
                                      'Status: ',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    Text(
                                      'Approved',
                                      style: TextStyle(color: Colors.green),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
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
      ),
    );
  }
}
