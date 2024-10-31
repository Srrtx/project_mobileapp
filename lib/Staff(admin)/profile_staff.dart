import 'package:flutter/material.dart';
import 'package:project_mobileapp/Login.dart';
import 'package:project_mobileapp/Staff(admin)/home_staff.dart';
import 'Dashboard_staff.dart';
import 'history_staff.dart';

class ProfileStaff extends StatelessWidget {
  const ProfileStaff({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 3;

  void _onDestinationSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });

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
          MaterialPageRoute(builder: (context) => const DashboardStaff()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HistoryStaff()),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProfileStaff()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your Profile',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFFF0EBE3),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            AssetImage('assets/images/Profile.png'),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'J',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'About',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16.0),
                        margin: EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Full Name: jj',
                                style: TextStyle(fontSize: 14)),
                            SizedBox(height: 8),
                            Text('Email: abc@example.com',
                                style: TextStyle(fontSize: 14)),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: Colors.red),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.exit_to_app, color: Colors.red),
                              SizedBox(width: 8),
                              Text(
                                'Logout',
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
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

void main() {
  runApp(const ProfileStaff());
}
