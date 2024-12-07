import 'package:cement_flutter/components/SideBar.dart';
import 'package:flutter/material.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4F4F4),
        elevation: 0,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: Color(0xFF000B23)),
              onPressed: () {
                // Open the drawer when menu icon is tapped
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: const Text(
          'Calendrier',
          style: TextStyle(
            color: Color(0xFF000B23),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      drawer: Drawer(
        width: MediaQuery.of(context).size.width *
            0.6, // Sidebar width (60% of screen width)
        child: const Sidebar(
          avatarUrl: 'assets/images/logo.png',
          cityName: 'Tunis',
          userName: 'Habib',
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '2024 décembre',
                        style: TextStyle(
                          color: Color(0xFF000B23),
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '09:56:12 pm',
                        style: TextStyle(
                          color: Color(0xFF7B7B7B),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      _iconButton(Icons.calendar_today_outlined),
                      _iconButton(Icons.search),
                      _iconButton(Icons.notifications_outlined),
                    ],
                  )
                ],
              ),
            ),

            // Days Row
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: ['Dim', 'Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam']
                    .map((day) => Text(
                          day,
                          style: TextStyle(
                            color: day == 'Lun'
                                ? const Color(0xFF577BFF)
                                : const Color(0xFF7B7B7B),
                            fontSize: 14,
                            fontWeight: day == 'Lun'
                                ? FontWeight.w600
                                : FontWeight.w400,
                          ),
                        ))
                    .toList(),
              ),
            ),

            // Date Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  7,
                  (index) => Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: index == 1
                          ? const Color(0xFFBC1F2A)
                          : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${3 + index}',
                      style: TextStyle(
                        color:
                            index == 1 ? Colors.white : const Color(0xFF9F9F9F),
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Time Slots and Events
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: [
                  _timeSlot('7h', isHighlighted: false),
                  _timeSlot('8h', isHighlighted: true),
                  _eventCard(
                    title: 'Magasin Amine',
                    location: 'La Soukra',
                    time: '9h - 10h30',
                    color: const Color(0xFF916AFE),
                    hasReminder: true,
                  ),
                  _timeSlot('10h'),
                  _eventCard(
                    title: 'Magasin Yessine',
                    location: 'Marsa',
                    time: '11h - 12h',
                    color: const Color(0xFFF26AFE),
                    hasReminder: false,
                  ),
                  _timeSlot('11h'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper for Time Slot
  Widget _timeSlot(String time, {bool isHighlighted = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            time,
            style: const TextStyle(
              color: Color(0xFF7B7B7B),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          if (isHighlighted) ...[
            const SizedBox(width: 8),
            const Expanded(
              child: Divider(
                color: Color(0xFF577BFF),
                thickness: 1.5,
              ),
            ),
          ],
        ],
      ),
    );
  }

  // Helper for Event Card
  Widget _eventCard({
    required String title,
    required String location,
    required String time,
    required Color color,
    bool hasReminder = false,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (hasReminder)
                const Icon(
                  Icons.notifications_outlined,
                  color: Colors.white,
                ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            location,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              const Icon(Icons.access_time, color: Colors.white70, size: 16),
              const SizedBox(width: 5),
              Text(
                time,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper for Icon Button
  Widget _iconButton(IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 20,
        child: Icon(
          icon,
          color: const Color(0xFF7B7B7B),
          size: 20,
        ),
      ),
    );
  }
}
