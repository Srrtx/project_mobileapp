import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'Homepage_staff.dart';

class AddRoom extends StatefulWidget {
  const AddRoom({super.key});

  @override
  State<AddRoom> createState() => _AddRoomState();
}

class _AddRoomState extends State<AddRoom> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
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
            'Add Room',
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
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
              padding: const EdgeInsets.all(64.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[300],
                      backgroundImage:
                          _image != null ? FileImage(_image!) : null,
                      child: _image == null
                          ? Icon(
                              Icons.camera_alt,
                              color: Colors.grey[700],
                              size: 50,
                            )
                          : null,
                    ),
                  ),
                  SizedBox(height: 50),
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
                  SizedBox(height: 20),
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
                  SizedBox(height: 50),
                  TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(32.0),
                      border: const OutlineInputBorder(),
                      labelText: 'Detail',
                      suffixIcon: IconButton(
                        onPressed: _controller3.clear,
                        icon: const Icon(Icons.clear),
                      ),
                    ),
                    controller: _controller3,
                    maxLines: null,
                    scrollController: _scrollController,
                    keyboardType: TextInputType.multiline,
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomepageStaff(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          fixedSize: Size(100, 60),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          //
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          fixedSize: Size(100, 60),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Text(
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
