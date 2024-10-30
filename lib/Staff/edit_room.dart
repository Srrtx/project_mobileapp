import 'package:flutter/material.dart';
import 'Homepage_staff.dart';
import 'Dashboard_staff.dart';
import 'history_staff.dart';
import 'profile_staff.dart';

class EditRoom extends StatefulWidget {
  const EditRoom({super.key});

  @override
  State<EditRoom> createState() => _EditRoomState();
}

class _EditRoomState extends State<EditRoom> {
  // Nav
  int _selectedIndex = 1;

  // For date and time display
  String _date = '';
  String _time = '';
  bool sw = true;

  // Function to toggle switch
  void toggleSwitch(bool? status) {
    setState(() {
      sw = status ?? false;
    });
  }

  @override
  void initState() {
    super.initState();
    _updateTime();
    // Updating the time every second
    // Timer.periodic(const Duration(seconds: 1), (Timer t) => _updateTime());
  }

  // Get current time
  void _updateTime() {
    final now = DateTime.now();
    setState(() {
      _time =
          '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
    });
  }

  // Show date picker and update selected date
  void showDate() async {
    DateTime? dt = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024, 1, 1),
      lastDate: DateTime(2024, 12, 31),
    );
    if (dt != null) {
      setState(() {
        _date = '${dt.day}/${dt.month}/${dt.year}';
      });
    }
  }

  // Navigation logic
  void _onDestinationSelected(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });

      switch (index) {
        case 0:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomepageStaff()),
          );
          break;
        case 1:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DashboardStaff()),
          );
          break;
        case 2:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HistoryStaff()),
          );
          break;
        case 3:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProfileStaff()),
          );
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double buttonWidth = MediaQuery.of(context).size.width * 0.9;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Meeting Room 1',
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,

        // // Tab Bar
        // bottomNavigationBar: const TabBar(
        //   tabs: [
        //     Tab(icon: Icon(Icons.home_outlined)),
        //     Tab(icon: Icon(Icons.pie_chart_outline)),
        //     Tab(icon: Icon(Icons.access_time)),
        //     Tab(icon: Icon(Icons.person_outline)),
        //   ],
        // ),

        // Body Content
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: showDate,
                        label: Text(
                          _date.isEmpty ? 'Select Date' : _date,
                          style: const TextStyle(color: Colors.black),
                        ),
                        icon: const Icon(
                          Icons.calendar_today,
                          color: Colors.black,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF3F3E0),
                        ),
                      ),
                      const Spacer(),
                      ElevatedButton.icon(
                        onPressed: () {},
                        label: Text(
                          _time,
                          style: const TextStyle(color: Colors.black),
                        ),
                        icon: const Icon(
                          Icons.access_time,
                          color: Colors.black,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF3F3E0),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Switch(
                        value: sw,
                        onChanged: toggleSwitch,
                        activeColor: Colors.black,
                        inactiveThumbColor: Colors.black,
                        inactiveTrackColor: Colors.white,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            'assets/images/meeting.png',
                            height: 230,
                            width: 230,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Time Slot Buttons
                      ElevatedButton.icon(
                        onPressed: () {},
                        label: Row(
                          children: [
                            Text(
                              'Time 08:00 - 10:00',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(buttonWidth, 65),
                          backgroundColor: Colors.grey[350],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          shadowColor: const Color.fromARGB(150, 94, 93, 93),
                          elevation: 3,
                        ),
                      ),
                      const SizedBox(height: 10),

                      ElevatedButton.icon(
                        onPressed: () {},
                        label: Row(
                          children: [
                            Text(
                              'Time 10:00 - 12:00',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                            TextButton.icon(
                              onPressed: () {},
                              label: const Text('Reserved'),
                              icon: const Icon(Icons.lock),
                              style: TextButton.styleFrom(
                                side: const BorderSide(
                                  color: Color.fromARGB(100, 137, 121, 255),
                                  width: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(buttonWidth, 65),
                          backgroundColor:
                              const Color.fromARGB(100, 137, 121, 255),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          shadowColor: const Color.fromARGB(150, 94, 93, 93),
                          elevation: 3,
                        ),
                      ),
                      const SizedBox(height: 10),

                      ElevatedButton.icon(
                        onPressed: () {},
                        label: Row(
                          children: [
                            Text(
                              'Time 13:00 - 15:00',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                            TextButton.icon(
                              onPressed: () {},
                              label: const Text('Free'),
                              icon: const Icon(Icons.check),
                              style: TextButton.styleFrom(
                                side: const BorderSide(
                                    color: Colors.green, width: 1),
                              ),
                            ),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(buttonWidth, 65),
                          backgroundColor:
                              const Color.fromARGB(130, 59, 160, 81),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          shadowColor: const Color.fromARGB(150, 94, 93, 93),
                          elevation: 3,
                        ),
                      ),
                      const SizedBox(height: 10),

                      ElevatedButton.icon(
                        onPressed: () {},
                        label: Row(
                          children: [
                            Text(
                              'Time 15:00 - 17:00',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                            TextButton.icon(
                              onPressed: () {},
                              label: const Text('Free'),
                              icon: const Icon(Icons.check),
                              style: TextButton.styleFrom(
                                side: const BorderSide(
                                    color: Colors.green, width: 1),
                              ),
                            ),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(buttonWidth, 65),
                          backgroundColor:
                              const Color.fromARGB(130, 59, 160, 81),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          shadowColor: const Color.fromARGB(150, 94, 93, 93),
                          elevation: 3,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        // // Bottom Navigation Bar
        // bottomNavigationBar: NavigationBar(
        //   height: 60,
        //   elevation: 0,
        //   selectedIndex: _selectedIndex,
        //   onDestinationSelected: _onDestinationSelected,
        //   destinations: const [
        //     NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
        //     NavigationDestination(
        //         icon: Icon(Icons.pie_chart), label: 'Dashboard'),
        //     NavigationDestination(icon: Icon(Icons.schedule), label: 'History'),
        //     NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        //   ],
        // ),
      ),
    );
  }
}
