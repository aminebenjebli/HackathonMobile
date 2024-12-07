import 'package:flutter/material.dart';

class UserProfileRow extends StatelessWidget {
  final String greeting;
  final String username;
  final String avatarUrl;
  final VoidCallback onNotificationTap;

  const UserProfileRow({
    Key? key,
    required this.greeting,
    required this.username,
    required this.avatarUrl,
    required this.onNotificationTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left Section: Avatar and Greeting
          Row(
            children: [
              // User Avatar
              CircleAvatar(
                radius: 22.5,
                backgroundImage: NetworkImage(avatarUrl),
                backgroundColor: Colors.grey[200],
              ),
              const SizedBox(width: 8),
              // Greeting and Username
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    greeting,
                    style: const TextStyle(
                      color: Color(0xFF7B7B7B),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.06,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    username,
                    style: const TextStyle(
                      color: Color(0xFF000B23),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.10,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Right Section: Icons
          Row(
            children: [
              // Placeholder for Icon Button
              CircleAvatar(
                radius: 22.5,
                backgroundColor: Colors.transparent,
                child: IconButton(
                  onPressed: () {}, // Add your onPressed logic
                  icon: const Icon(Icons.search, color: Color.fromARGB(255, 158, 136, 136)),
                ),
              ),
              const SizedBox(width: 10),

              // Notifications Icon
              Stack(
                children: [
                  IconButton(
                    onPressed: onNotificationTap,
                    icon: const Icon(Icons.notifications, color: Colors.grey),
                  ),
                  Positioned(
                    right: 4,
                    top: 4,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Color(0xFFBC1F2A),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
