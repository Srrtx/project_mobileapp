import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the current date and time
    DateTime now = DateTime.now();
    String currentDate = '${now.day}/${now.month}/${now.year}';
    String currentTime = '${now.hour}:${now.minute.toString().padLeft(2, '0')}';

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Room'),
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
              const SizedBox(height: 16), // Space between time and room slots

              // Room Slots Section
              Expanded(
                child: ListView(
                  children: const [
                    RoomSlot(
                      roomName: 'Meeting Room 1',
                      imagePath: 'assets/images/meeting.png',
                      occupancy: '2/4',
                    ),
                    RoomSlot(
                      roomName: 'Meeting Room 2',
                      imagePath: 'assets/images/meeting.png',
                      occupancy: '1/4',
                    ),
                    RoomSlot(
                      roomName: 'Meeting Room 3',
                      imagePath: 'assets/images/meeting.png',
                      occupancy: '0/4',
                    ),
                  ],
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
        selectedIndex: 0,
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

class RoomSlot extends StatelessWidget {
  final String roomName;
  final String imagePath;
  final String occupancy;

  const RoomSlot({
    super.key,
    required this.roomName,
    required this.imagePath,
    required this.occupancy,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          // Navigate to Timeslots page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Timeslots(
                roomName: roomName,
                roomImage: imagePath,
              ),
            ),
          );
        },
        splashColor: Colors.grey.withOpacity(0.3), // Add splash effect
        borderRadius:
            BorderRadius.circular(12), // Match with card's border radius
        child: Card(
          color: const Color.fromRGBO(240, 235, 227, 1),
          margin: const EdgeInsets.symmetric(vertical: 4),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            height: 120, // Larger height for the card
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    imagePath,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16), // Space between image and text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        roomName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        occupancy,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Timeslots extends StatelessWidget {
  final String roomName;
  final String roomImage;

  const Timeslots({
    Key? key,
    required this.roomName,
    required this.roomImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String currentDate = '${now.day}/${now.month}/${now.year}';
    String currentTime = '${now.hour}:${now.minute.toString().padLeft(2, '0')}';

    List<TimeSlot> timeSlots = [
      TimeSlot(time: '08:00-10:00', status: 'free'),
      TimeSlot(time: '10:00-12:00', status: 'reserved'),
      TimeSlot(time: '13:00-15:00', status: 'disabled'),
      TimeSlot(time: '15:00-17:00', status: 'pending'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(roomName),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
              const SizedBox(height: 20),

              // Image of the room
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  roomImage,
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),

              // Time slots
              Expanded(
                child: ListView.builder(
                  itemCount: timeSlots.length,
                  itemBuilder: (context, index) {
                    TimeSlot slot = timeSlots[index];
                    return buildTimeSlot(context, slot);
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
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(240, 235, 227, 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget buildTimeSlot(BuildContext context, TimeSlot slot) {
    Color backgroundColor;
    Color textColor = Colors.white;
    String buttonText;

    switch (slot.status) {
      case 'free':
        backgroundColor =
            const Color.fromRGBO(59, 160, 81, 1); // Green for free
        buttonText = 'Free';
        break;
      case 'pending':
        backgroundColor =
            const Color.fromRGBO(255, 191, 97, 1); // Orange for pending
        buttonText = 'Pending';
        break;
      case 'reserved':
        backgroundColor =
            const Color.fromRGBO(137, 121, 255, 1); // Purple for reserved
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
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          // Logic to handle slot selection based on status
          if (slot.status == 'free') {
            // Action to reserve or book this slot
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
              SnackBar(
                  content: Text('Slot ${slot.time} is pending confirmation.')),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
      ),
    );
  }
}

class TimeSlot {
  final String time;
  String status;

  TimeSlot({
    required this.time,
    required this.status,
  });
}
