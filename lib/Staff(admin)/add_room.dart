import 'package:flutter/material.dart';
import 'home_staff.dart';

class AddRoom extends StatefulWidget {
  const AddRoom({super.key});

  @override
  State<AddRoom> createState() => _AddRoomState();
}

class _AddRoomState extends State<AddRoom> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Add Room',
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        // bottomNavigationBar: const TabBar(
        //   tabs: [
        //     Tab(
        //       icon: Icon(Icons.home_outlined),
        //     ),
        //     Tab(
        //       icon: Icon(Icons.pie_chart_outline),
        //     ),
        //     Tab(
        //       icon: Icon(Icons.access_time),
        //     ),
        //     Tab(
        //       icon: Icon(Icons.person_outline),
        //     ),
        //   ],
        // ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(64.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  TextField(
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Room Name',
                      suffixIcon: IconButton(
                        onPressed: _controller1.clear,
                        icon: const Icon(Icons.clear),
                      ),
                    ),
                    controller: _controller1,
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Room Number',
                      suffixIcon: IconButton(
                        onPressed: _controller2.clear,
                        icon: const Icon(Icons.clear),
                      ),
                    ),
                    controller: _controller2,
                  ),
                  const SizedBox(height: 50),
                  TextField(
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(32.0),
                      border: OutlineInputBorder(),
                      labelText: 'Detail',
                      suffixIcon: null,
                    ),
                    controller: _controller3,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Navigator.pushReplacement(
                          // context,
                          // MaterialPageRoute(
                          // builder: (context) => const HomeStaff(),
                          // ),
                          // );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          fixedSize: const Size(100, 60),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Add room logic can go here
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          fixedSize: const Size(100, 60),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text(
                          'Add',
                          style: TextStyle(color: Colors.white),
                        ),
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
