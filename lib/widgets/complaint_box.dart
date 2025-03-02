import 'package:flutter/material.dart';

class ComplaintBox extends StatelessWidget {
  final String title;
  final int total;
  final int solved;
  final int remaining;
  final IconData icon;
  final Color progressColor;

  const ComplaintBox({
    Key? key,
    required this.title,
    required this.total,
    required this.solved,
    required this.remaining,
    required this.icon,
    required this.progressColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF1A1A4B),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.blue, size: 24),
              const SizedBox(width: 8),
              Text(title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              Spacer(),
              Text("$total",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 4),
          Text("$remaining left to solve",
              style: TextStyle(color: Colors.white60)),
          SizedBox(height: 4),
          LinearProgressIndicator(
            value: solved / total,
            backgroundColor: Colors.white24,
            color: progressColor,
          ),
          SizedBox(height: 4),
          Text("$solved Solved", style: TextStyle(color: Colors.white60)),
        ],
      ),
    );
  }
}
