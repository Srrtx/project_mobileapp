import 'package:flutter/material.dart';

class EditRoom extends StatefulWidget {
  const EditRoom({super.key});

  @override
  State<EditRoom> createState() => _EditRoomState();
}

class _EditRoomState extends State<EditRoom> {
  bool sw = true;

  // Function to toggle switch
  void toggleSwitch(bool? status) {
    setState(() {
      sw = status ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double buttonWidth = MediaQuery.of(context).size.width * 0.9;
    // Get the current date and time
    DateTime now = DateTime.now();
    String currentDate = '${now.day}/${now.month}/${now.year}';
    String currentTime = '${now.hour}:${now.minute.toString().padLeft(2, '0')}';

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
        // Body Content
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
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
                              // icon: const Icon(Icons.lock),
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
      ),
    );
  }
}
