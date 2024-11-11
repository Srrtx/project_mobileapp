import 'package:flutter/material.dart';
import 'package:project_mobileapp/Login.dart';
import 'package:project_mobileapp/User(student)/History_user.dart';
import 'package:project_mobileapp/User(student)/Profile_user.dart';
import 'home_user.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class CheckstatusUser extends StatefulWidget {
  const CheckstatusUser({super.key});

  @override
  State<CheckstatusUser> createState() => _CheckstatusUserState();
}

class _CheckstatusUserState extends State<CheckstatusUser> {
  final String _url = 'http://172.25.223.40:3000/:username/status/';
  bool _isloading = false;
  String username = '';
  List? status;

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String currentDate = '${now.day}/${now.month}/${now.year}';
    String currentTime = '${now.hour}:${now.minute.toString().padLeft(2, '0')}';

//pop up
    void popDialog(String title, String message) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(title),
              content: Text(message),
            );
          });
    }

    void getStatus() async {
      setState(() {
        _isloading = true;
      });
      try {
        //get JWT token for local storage
        final prefs = await SharedPreferences.getInstance();
        String? token = prefs.getString('token');

        if (token == null) {
          //no token, redirect to login page
          //check mounted to use 'context' for nav in 'async' method
          if (!mounted) return;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginApp()),
          );
        }
        //Token found
        //decode JWT to get username and role
        final jwt = JWT.decode(token!);
        Map playload = jwt.payload;

        //get status
        Uri uri = Uri.http(_url, '172.25.223.40/:username/status/');
        http.Response response = await http.get(
          uri,
          headers: {'Authorization': 'Bearer $token'},
        ).timeout(const Duration(days: 1));
        //check server's response
        if (response.statusCode == 200) {
          setState(() {
            username = playload['username'];
            status = jsonDecode(response.body);
          });
        } else {
          //wrong password, username
          popDialog('Error', response.body);
        }
      } on TimeoutException catch (e) {
        debugPrint(e.message);
        popDialog('Error', 'Timeout error, try again!');
      } catch (e) {
        debugPrint(e.toString());
        popDialog('Error', 'Unknown error, try again!');
      } finally {
        setState(() {
          _isloading = false;
        });
      }
    }

    @override
    void initState() {
      super.initState();
      getStatus();
    }

    //Nav
    int _selectedIndex = 1;
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
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(builder: (context) => const HistoryUser()),
          // );
          break;
        case 3:
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(builder: (context) => const ProfileUser()),
          // );
          break;
      }
    }

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Check Status',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Card(
                        color: const Color(0xFFF0EBE3),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Icon(Icons.calendar_today),
                              const SizedBox(width: 8),
                              Text(
                                currentDate,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        color: const Color(0xFFF0EBE3),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Icon(Icons.access_time),
                              const SizedBox(width: 8),
                              Text(
                                currentTime,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Show loading indicator if data is being fetched
                  if (_isloading)
                    const CircularProgressIndicator()
                  else if (status == null || status!.isEmpty)
                    const Text('No rooms available')
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: status!.length,
                      itemBuilder: (context, index) {
                        final room = status![index];
                        return InkWell(
                          onTap: () {
                            // Define any on-tap action here
                          },
                          child: Card(
                            color: const Color(0xFFF3F3E0),
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/images/meeting.png',
                                    width: 100,
                                    height: 100,
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        room[
                                            'roomName'], // Dynamically set room name
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Time: ${room['timeSlot']}', // Dynamically set time slot
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            'Status: ',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          Text(
                                            room[
                                                'status'], // Dynamically set status
                                            style: TextStyle(
                                              color: room['status'] == 'Pending'
                                                  ? Colors.amber
                                                  : room['status'] == 'Approved'
                                                      ? Colors.green
                                                      : Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                ],
              ),
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
      ),
    );
  }
}
