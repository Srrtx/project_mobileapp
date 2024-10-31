import 'dart:async';
import '../Staff(admin)/edit_room.dart';
import 'package:flutter/material.dart';
import '../Staff(admin)/add_room.dart';

class HomepageStaff extends StatefulWidget {
  const HomepageStaff({super.key});

  @override
  State<HomepageStaff> createState() => _HomepageStaffState();
}

class _HomepageStaffState extends State<HomepageStaff> {
  String _date = '';
  String _time = '';

  @override
  void initState() {
    super.initState();
    _updateTime(); // Initialize the time on startup
    Timer.periodic(const Duration(seconds: 1),
        (Timer t) => _updateTime()); // Update time every second
  }

  // Get current time
  void _updateTime() {
    final now = DateTime.now();
    setState(() {
      _time =
          '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
    });
  }

  // Show date
  void showDate() async {
    DateTime? dt = await showDatePicker(
      context: context,
      firstDate: DateTime(2024, 1, 1),
      lastDate: DateTime(2024, 12, 31),
    ); // DateTime(year, month, date)
    if (dt != null) {
      setState(() {
        // _date = dt.toString();
        _date = '${dt.day}/${dt.month}/${dt.year}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'All Room',
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,

        //Tab Bar
        bottomNavigationBar: Container(
          child: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.home_outlined),
              ),
              Tab(
                icon: Icon(Icons.pie_chart_outline),
              ),
              Tab(
                icon: Icon(Icons.access_time),
              ),
              Tab(
                icon: Icon(Icons.person_outline),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          ElevatedButton.icon(
                            onPressed: showDate,
                            label: Text(
                              '$_date',
                              style: TextStyle(color: Colors.black),
                            ),
                            icon: const Icon(
                              Icons.calendar_today,
                              color: Colors.black,
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFF3F3E0),
                            ),
                          ),
                          const Spacer(),
                          ElevatedButton.icon(
                            onPressed: () {},
                            label: Text(
                              _time,
                              style: TextStyle(color: Colors.black),
                            ),
                            icon: const Icon(
                              Icons.access_time,
                              color: Colors.black,
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFF3F3E0),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          //Meeting Room 1
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const EditRoom(),
                                ),
                              );
                            },
                            icon: Image.asset(
                              'assets/images/meeting_room.png',
                              width: 120,
                              height: 120,
                            ),
                            label: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        'Meeting Room 1',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: Text(
                                          '2/4',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(500, 135),
                              backgroundColor: Color(0xFFF3F3E0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              shadowColor: Color.fromARGB(150, 94, 93, 93),
                              elevation: 3,
                            ),
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          //Meeting room 2
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: Image.asset(
                              'assets/images/meeting_room.png',
                              width: 120,
                              height: 120,
                            ),
                            label: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        'Meeting Room 2',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: Text(
                                          '1/4',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(500, 135),
                              backgroundColor: Color(0xFFF3F3E0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              shadowColor: Color.fromARGB(150, 94, 93, 93),
                              elevation: 3,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          //Meeting room 3
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: Image.asset(
                              'assets/images/meeting_room.png',
                              width: 120,
                              height: 120,
                            ),
                            label: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        'Meeting Room 3',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: Text(
                                          '0/4',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(500, 135),
                              backgroundColor: Color(0xFFF3F3E0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              shadowColor: Color.fromARGB(150, 94, 93, 93),
                              elevation: 3,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddRoom(),
              ),
            );
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.black,
        ),
      ),
    );
  }
}
