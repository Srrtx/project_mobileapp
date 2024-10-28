import 'package:flutter/material.dart';

class Timeslots extends StatefulWidget {
  final String roomName;
  final String roomImage;

  Timeslots({
    required this.roomName,
    required this.roomImage,
  });

  @override
  State<Timeslots> createState() => _RoomDetailsState();
}

class _RoomDetailsState extends State<Timeslots> {
  // Example timeslot data
  List<TimeSlot> timeSlots = [
    TimeSlot(time: '08:00-10:00', status: 'disabled'),
    TimeSlot(time: '10:00-12:00', status: 'reserved'),
    TimeSlot(time: '13:00-15:00', status: 'free'),
    TimeSlot(time: '15:00-17:00', status: 'free'),
  ];

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String currentDate = '${now.day}/${now.month}/${now.year}';
    String currentTime = '${now.hour}:${now.minute.toString().padLeft(2, '0')}';

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.roomName),
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
          color: Colors.black,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Date and time
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildDateTimeCard(Icons.calendar_today, currentDate),
                  buildDateTimeCard(Icons.access_time, currentTime),
                ],
              ),
              SizedBox(height: 20),

              // Image of the room
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  widget.roomImage,
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 10),

              // Time slots
              Expanded(
                child: ListView.builder(
                  itemCount: timeSlots.length,
                  itemBuilder: (context, index) {
                    TimeSlot slot = timeSlots[index];
                    return buildTimeSlot(slot);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDateTimeCard(IconData icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Color.fromRGBO(240, 235, 227, 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18),
          SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
class TimeSlot {
  final String time;
  String status;

  TimeSlot({
    required this.time,
    required this.status,
  });
}

  Widget buildTimeSlot(TimeSlot slot) {
    Color backgroundColor;
    Color textColor = Colors.white;
    String buttonText;

    switch (slot.status) {
      case 'free':
        backgroundColor = const Color.fromRGBO(59, 160, 81, 1); // Green for free
        buttonText = 'Free';
        break;
      case 'pending':
        backgroundColor = const Color.fromRGBO(255, 191, 97, 1); // Orange for pending
        buttonText = 'Pending';
        break;
      case 'reserved':
        backgroundColor = const Color.fromRGBO(137, 121, 255, 1); // Purple for reserved
        buttonText = 'Reserved';
        break;
      case 'disabled':
        backgroundColor = Colors.grey; // Grey for disabled
        buttonText = 'Disabled';
        break;
      default:
        backgroundColor = const Color.fromRGBO(240, 235, 227, 1);
        buttonText = '';
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor, // Button color based on status
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          // Logic to handle slot selection based on status
          if (slot.status == 'free') {
            // Action to reserve or book this slot
            setState(() {
              slot.status = 'pending'; // Example: Change status to 'pending'
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Slot ${slot.time} is now pending!')),
            );
          } else if (slot.status == 'reserved') {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Slot ${slot.time} is already reserved.')),
            );
          } else if (slot.status == 'disabled') {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Slot ${slot.time} is disabled.')),
            );
          } else if (slot.status == 'pending') {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Slot ${slot.time} is pending confirmation.')),
            );
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Time ${slot.time}',
              style: TextStyle(color: textColor, fontSize: 16),
            ),
            Text(
              buttonText,
              style: TextStyle(color: textColor, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }



}
