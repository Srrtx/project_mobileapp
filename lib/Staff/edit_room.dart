import 'dart:async';

import 'package:flutter/material.dart';

class EditRoom extends StatefulWidget {
  const EditRoom({super.key});

  @override
  State<EditRoom> createState() => _EditRoomState();
}

class _EditRoomState extends State<EditRoom> {
  String _date = '';
  String _time = '';
  bool sw = false;

  void toggleSwitch(bool? status) {
    setState(() {
      sw = status!;
    });
  }

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
            'Meeting Room 1',
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
                    height: 30,
                  ),
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
                      //Meeting rooom 1
                      Center(
                        child: Image.asset('assets/images/meeting_room.png'),
                      ),
                      SizedBox(
                        height: 40,
                      ),

                      //Time 08:00 - 10:00
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
                            Spacer(),
                            Text(''),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(500, 65),
                          backgroundColor: Colors.grey[350],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          shadowColor: Color.fromARGB(150, 94, 93, 93),
                          elevation: 3,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

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
                            Spacer(),
                            TextButton.icon(
                              onPressed: () {},
                              label: Text('Reserved'),
                              style: TextButton.styleFrom(
                                side: const BorderSide(
                                    color: Color.fromARGB(100, 137, 121, 255),
                                    width: 1),
                              ),
                            )
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(500, 65),
                          backgroundColor: Color.fromARGB(100, 137, 121, 255),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          shadowColor: Color.fromARGB(150, 94, 93, 93),
                          elevation: 3,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

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
                            Spacer(),
                            TextButton.icon(
                              onPressed: () {},
                              label: Text('Free'),
                              style: TextButton.styleFrom(
                                side: const BorderSide(
                                    color: Colors.green, width: 1),
                              ),
                            )
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(500, 65),
                          backgroundColor: Color.fromARGB(130, 59, 160, 81),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          shadowColor: Color.fromARGB(150, 94, 93, 93),
                          elevation: 3,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

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
                            Spacer(),
                            TextButton.icon(
                              onPressed: () {},
                              label: Text('Free'),
                              style: TextButton.styleFrom(
                                side: const BorderSide(
                                    color: Colors.green, width: 1),
                              ),
                            )
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(500, 65),
                          backgroundColor: Color.fromARGB(130, 59, 160, 81),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
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
      ),
    );
  }
}
