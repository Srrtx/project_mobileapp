import 'package:flutter/material.dart';
import 'Home_approver.dart';
import 'booking_req.dart';
import 'history_approver.dart';
import 'profile_approver.dart';

class DashboardApproved extends StatelessWidget {
  const DashboardApproved({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the current date and time
    DateTime now = DateTime.now();
    String currentDate = '${now.day}/${now.month}/${now.year}';
    String currentTime = '${now.hour}:${now.minute.toString().padLeft(2, '0')}';

    //Display Number
    final int allroom = 3; // Replace with actual data
    final int disabled = 0; // Replace with actual data
    final int pending = 1; // Replace with actual data
    final int free = 9; // Replace with actual data

//Nav
    int _selectedIndex = 2;
    void _onDestinationSelected(int index) {
      switch (index) {
        case 0:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeApprover()),
          );
          break;
        case 1:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const BookingReq()),
          );
          break;
        case 2:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const DashboardApproved()),
          );
          break;
        case 3:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HistoryApprover()),
          );
          break;
        case 4:
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
      // Nav bar (bottom)
      bottomNavigationBar: NavigationBar(
        height: 60,
        elevation: 0,
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onDestinationSelected,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(
              icon: Icon(Icons.notifications), label: 'Request'),
          NavigationDestination(
              icon: Icon(Icons.space_dashboard_rounded), label: 'Dashboard'),
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
    super.key,
    required this.title,
    required this.count,
    required this.color,
    required this.icon,
  });

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
