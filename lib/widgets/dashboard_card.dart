import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {
  final String title;
  final String count;

  const DashboardCard({
    required this.title,
    required this.count,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100, // Fixed width
      height: 80, // Fixed height
      decoration: BoxDecoration(
        color: Colors.grey.shade500, // Grey background like the image
        borderRadius: BorderRadius.circular(15), // Rounded edges
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12, // Adjusted font size for better fit
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            count,
            style: const TextStyle(
              fontSize: 18, // Bigger font for emphasis
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
