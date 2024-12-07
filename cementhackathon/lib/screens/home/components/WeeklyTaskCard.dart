import 'package:flutter/material.dart';

class WeeklyTaskCard extends StatelessWidget {
  final String city;
  final String region;
  final String storeName;
  final String date;
  final VoidCallback onTap;

  const WeeklyTaskCard({
    Key? key,
    required this.city,
    required this.region,
    required this.storeName,
    required this.date,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 203,
        height: 230,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          children: [
            // City & Region Labels
            Positioned(
              left: 17,
              top: 19,
              child: _RegionLabel(
                label: region,
                color: const Color(0x198E61E9),
                textColor: const Color(0xFF8E61E9),
              ),
            ),
            Positioned(
              left: 124,
              top: 19,
              child: _RegionLabel(
                label: city,
                color: const Color(0x19E86161),
                textColor: const Color(0xFFE86161),
              ),
            ),

            // Store Name
            Positioned(
              left: 17,
              top: 74,
              child: Text(
                storeName,
                style: const TextStyle(
                  color: Color(0xFF000B23),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.09,
                ),
              ),
            ),

          

            // Date & Icon
            Positioned(
  left: 17,
  top: 186,
  child: Row(
    children: [
      const Icon(
        Icons.calendar_today, // Replace with calendar icon
        size: 24,
        color: Color(0xFF7B7B7B), // Same color as the text for consistency
      ),
      const SizedBox(width: 8),
      Text(
        date,
        style: const TextStyle(
          color: Color(0xFF7B7B7B),
          fontSize: 12,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.06,
        ),
      ),
    ],
  ),
),

          ],
        ),
      ),
    );
  }
}

class _RegionLabel extends StatelessWidget {
  final String label;
  final Color color;
  final Color textColor;

  const _RegionLabel({
    Key? key,
    required this.label,
    required this.color,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        label,
        textAlign: TextAlign.right,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          letterSpacing: -0.06,
        ),
      ),
    );
  }
}
