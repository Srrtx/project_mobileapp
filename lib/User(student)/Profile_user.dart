import 'package:flutter/material.dart';
import 'package:project_mobileapp/Login.dart';
import 'package:project_mobileapp/User(student)/Check_status.dart';
import 'package:project_mobileapp/User(student)/History_user.dart';
import 'package:project_mobileapp/User(student)/home_user.dart';

class ProfileUser extends StatelessWidget {
  const ProfileUser({super.key});

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
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 3;

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
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Profile'), // เพิ่มหัวข้อที่นี่
      ),
      body: Container(
        color: Colors.white, // ตั้งค่าสีพื้นหลังให้เต็มหน้าจอ
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFFF0EBE3), // สีพื้นหลังของกล่องโปรไฟล์
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
                      SizedBox(height: 20),
                      Text(
                        'J',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
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
              Expanded(child: Container()), // ส่วนที่เหลือของหน้าจอ
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
              icon: Icon(Icons.notifications), label: 'Status'),
          NavigationDestination(icon: Icon(Icons.schedule), label: 'History'),
          NavigationDestination(
              icon: Icon(Icons.account_circle), label: 'Profile'),
        ],
      ),
    );
  }
}

void main() {
  runApp(const ProfileUser());
}
