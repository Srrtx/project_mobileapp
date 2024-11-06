import 'package:flutter/material.dart';
import 'package:project_mobileapp/Approver/history_approver.dart';
import 'package:project_mobileapp/Approver/profile_approver.dart';
import 'package:project_mobileapp/Staff(admin)/home_staff.dart';
import 'history_approver.dart';
import 'profile_approver.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DashboardApproved extends StatefulWidget {
  const DashboardApproved({Key? key}) : super(key: key);

  @override
  State<DashboardApproved> createState() => _DashboardApprovedState();
}

class _DashboardApprovedState extends State<DashboardApproved> {
  int allroom = 0;
  int free = 0;
  int pending = 0;
  int disabled = 0;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response =
          await http.get(Uri.parse('http://172.25.193.55:3000/room-stats'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          allroom = data['allroom'];
          free = data['free'];
          pending = data['pending'];
          disabled = data['disabled'];
        });
      } else {
        print('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the current date and time
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
            MaterialPageRoute(builder: (context) => const HomeStaff()),
          );
          break;
        case 1:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const DashboardApproved()),
          );
          break;
        case 2:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HistoryApprover()),
          );
          break;
        case 3:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Profileapprover()),
          );
          break;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SafeArea(
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
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
              const SizedBox(height: 16), // Space between time and dashboard

              // Dashboard Section
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Wrap each DashboardCard in a Container to set size
                      Container(
                        width: double.infinity, // Full width
                        height: 150, // Adjust height as needed
                        child: DashboardCard(
                          title: 'All Room',
                          count: allroom,
                          color: Color.fromARGB(134, 137, 121, 255),
                          icon: Icons.show_chart,
                        ),
                      ),
                      const SizedBox(height: 8), // Space between cards
                      Container(
                        width: double.infinity,
                        height: 150,
                        child: DashboardCard(
                          title: 'Free',
                          count: free,
                          color: const Color.fromARGB(134, 121, 255, 177),
                          icon: Icons.done,
                        ),
                      ),
                      const SizedBox(height: 8), // Space between cards
                      Container(
                        width: double.infinity,
                        height: 150,
                        child: DashboardCard(
                          title: 'Pending',
                          count: pending,
                          color: const Color.fromARGB(255, 255, 191, 97),
                          icon: Icons.stream,
                        ),
                      ),
                      const SizedBox(height: 8), // Space between cards

                      Container(
                        width: double.infinity,
                        height: 150,
                        child: DashboardCard(
                          title: 'Disabled',
                          count: disabled,
                          color: const Color.fromARGB(255, 228, 105, 98),
                          icon: Icons.close,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      //Nav bar (bottom)
      bottomNavigationBar: NavigationBar(
        height: 60,
        elevation: 0,
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onDestinationSelected,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(
              icon: Icon(Icons.pie_chart), label: 'Dashboard'),
          NavigationDestination(icon: Icon(Icons.schedule), label: 'History'),
          NavigationDestination(
              icon: Icon(Icons.account_circle), label: 'Profile'),
        ],
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final int count;
  final Color color; // Added color parameter
  final IconData icon; // Added icon parameter

  const DashboardCard({
    Key? key,
    required this.title,
    required this.count,
    required this.color,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: color, // Use the passed color
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 36), // Display the icon at the top
            const SizedBox(height: 8), // Space between icon and title
            Text(
              '$count',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center, // Center the count text
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
              ),
              textAlign: TextAlign.center, // Center the title text
            ),
            const SizedBox(height: 4), // Space between title and count
          ],
        ),
      ),
    );
  }
}
