import 'dart:async';

import 'package:flutter/material.dart';

class CheckstatusUser extends StatefulWidget {
  const CheckstatusUser({super.key});

  @override
  State<CheckstatusUser> createState() => _CheckstatusUserState();
}

class _CheckstatusUserState extends State<CheckstatusUser> {
  String _date = '';
  String _time = '';

  @override
  void initState() {
    super.initState();
    _updateTime();
    Timer.periodic(const Duration(seconds: 1), (Timer t) => _updateTime());
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
    );
    if (dt != null) {
      setState(() {
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
            'Check status',
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
        // backgroundColor: Color(0xFFF3F3E0),
        body: SafeArea(
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
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      //Meeting rooom 1
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Meeting Room 1',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
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
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(500, 135),
                          backgroundColor: const Color(0xFFF3F3E0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          shadowColor: const Color.fromARGB(150, 94, 93, 93),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Meeting Room 2',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
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
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(500, 135),
                          backgroundColor: const Color(0xFFF3F3E0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          shadowColor: const Color.fromARGB(150, 94, 93, 93),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Meeting Room 3',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
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
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(500, 135),
                          backgroundColor: const Color(0xFFF3F3E0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          shadowColor: const Color.fromARGB(150, 94, 93, 93),
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
      ),
    );
  }
}
