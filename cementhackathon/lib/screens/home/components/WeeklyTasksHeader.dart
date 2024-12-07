import 'package:flutter/material.dart';

class WeeklyTasksHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onSliderTap;
  final VoidCallback onAddTap;

  const WeeklyTasksHeader({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.onSliderTap,
    required this.onAddTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 48, // Increased slightly to prevent overflow
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left Section: Title and Subtitle
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF000B23),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.09,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Color.fromARGB(255, 136, 114, 114),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),

          // Right Section: Icons
          Row(
            children: [
              // Slider Icon Button
              GestureDetector(
                onTap: onSliderTap,
                child: const Icon(Icons.tune, size: 24, color: Colors.black), // Sliders icon
              ),
              const SizedBox(width: 20),

              // Vertical Divider
              Container(
                width: 1,
                height: 20, // Adjusted to match spacing
                color: const Color(0xFFE4E4E4),
              ),
              const SizedBox(width: 20),

              // Add Icon Button
              GestureDetector(
                onTap: onAddTap,
                child: const Icon(Icons.add, size: 24, color: Colors.black), // Plus icon
              ),
            ],
          ),
        ],
      ),
    );
  }
}
