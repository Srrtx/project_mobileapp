import 'dart:async';
import 'dart:convert';
import 'package:project_mobileapp/Register.dart';
import 'package:project_mobileapp/Login.dart';
import 'package:project_mobileapp/User(student)/home_user.dart';
import 'Approver/Home_approver.dart';
import 'Staff(admin)/Home_staff.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Uri _uri = Uri.parse('http://172.25.236.139:3000/login');
  String _message = '';
  bool isWaiting = false;
  final formKey = GlobalKey<FormState>();
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();

  // void connect() async {
  //   if (isWaiting) return; // ป้องกันการกดปุ่มหลายครั้ง

  //   setState(() {
  //     isWaiting = true;
  //     _message = 'Connecting...';
  //   });

  //   try {
  //     // ส่ง POST request พร้อมกับข้อมูล username และ password
  //     final response = await http
  //         .post(
  //           _uri,
  //           headers: {'Content-Type': 'application/json; charset=UTF-8'},
  //           body: jsonEncode({
  //             'username': username.text,
  //             'password': password.text,
  //           }),
  //         )
  //         .timeout(
  //             const Duration(seconds: 10)); // เพิ่มเวลา timeout เป็น 10 วินาที

  //     if (response.statusCode == 200) {
  //       // อ่านข้อความตอบกลับจากเซิร์ฟเวอร์
  //       final responseData = jsonDecode(response.body);

  //       // ตรวจสอบว่า responseData มีค่าที่จำเป็น
  //       setState(() {
  //         _message = responseData['message'] != null
  //             ? responseData['message']
  //             : 'Login successful!';
  //       });

  //       // นำทางตามบทบาทผู้ใช้
  //       String userRole = responseData['role'] ??
  //           ''; // ตรวจสอบให้แน่ใจว่าเซิร์ฟเวอร์ส่งกลับบทบาท
  //       if (userRole == 'Student') {
  //         Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(builder: (context) => HomeUser()),
  //         );
  //       } else if (userRole == 'Staff') {
  //         // Navigator.pushReplacement(
  //         //   context,
  //         //   MaterialPageRoute(builder: (context) => HomeStaff()),
  //         // );
  //       } else if (userRole == 'Approver') {
  //         Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(builder: (context) => HomeApprover()),
  //         );
  //       } else {
  //         setState(() {
  //           _message = 'Invalid role';
  //         });
  //       }
  //     } else {
  //       // อ่านข้อความผิดพลาดจากเซิร์ฟเวอร์
  //       final responseData = jsonDecode(response.body);
  //       setState(() {
  //         _message = responseData['message'] != null
  //             ? responseData['message']
  //             : 'Login failed';
  //       });
  //     }
  //   } on TimeoutException {
  //     setState(() {
  //       _message = 'Timeout error!';
  //     });
  //   } catch (e) {
  //     setState(() {
  //       _message = 'Unknown error: ${e.toString()}';
  //     });
  //   } finally {
  //     setState(() {
  //       isWaiting = false;
  //     });
  //   }
  // }
  // Save username and token to SharedPreferences
  Future<void> saveLoginDetails(String username, String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username); // Save username
    await prefs.setString('jwtToken', token); // Save token
    print('Saved username: ${prefs.getString('username')}');
    print('Saved token: ${prefs.getString('jwtToken')}');
  }

  void connect() async {
    if (isWaiting) return;

    setState(() {
      isWaiting = true;
      _message = 'Connecting...';
    });

    try {
      final response = await http
          .post(
            _uri,
            headers: {'Content-Type': 'application/json; charset=UTF-8'},
            body: jsonEncode({
              'username': username.text,
              'password': password.text,
            }),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final token = responseData['token'];
        final usernameValue = username.text;

        // Save the token and username in SharedPreferences
        await saveLoginDetails(usernameValue, token);

        setState(() {
          _message = responseData['message'] ?? 'Login successful!';
        });

        // Navigate based on user role
        String userRole = responseData['role'] ?? '';
        if (userRole == 'Student') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeUser()),
          );
        } else if (userRole == 'Staff') {
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(builder: (context) => HomeStaff()),
          // );
        } else if (userRole == 'Approver') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeApprover()),
          );
        } else {
          setState(() {
            _message = 'Invalid role';
          });
        }
      } else {
        final responseData = jsonDecode(response.body);
        setState(() {
          _message = responseData['message'] ?? 'Login failed';
        });
      }
    } on TimeoutException {
      setState(() {
        _message = 'Timeout error!';
      });
    } catch (e) {
      setState(() {
        _message = 'Unknown error: ${e.toString()}';
      });
    } finally {
      setState(() {
        isWaiting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Color(0xFFF0EBE3),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Login',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: username,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Username',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade500),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: password,
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade500),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          connect(); // เรียกใช้ฟังก์ชัน connect()
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      ),
                      child: isWaiting
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text(
                              'Login',
                              style: TextStyle(color: Colors.white),
                            ),
                    ),
                    SizedBox(height: 20),
                    Text(_message), // แสดงข้อความตอบกลับ
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterPage(),
                            ),
                          );
                        },
                        child: Text(
                          "Don't have an account? Create an Account",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
