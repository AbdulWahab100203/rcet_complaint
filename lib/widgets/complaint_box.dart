import 'package:flutter/material.dart';
import '../screens/dashboard/department_complaint_screen.dart';
import '../models/department_complaint_stats.dart';

class ComplaintBox extends StatelessWidget {
  final DepartmentComplaintStats stats;
  final IconData icon;
  final Color progressColor;

  const ComplaintBox({
    Key? key,
    required this.stats,
    required this.icon,
    required this.progressColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double progress = stats.total > 0 ? stats.solved / stats.total : 0.0;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DepartmentComplaintScreen(
              departmentName: stats.departmentName,
              total: stats.total,
              solved: stats.solved,
              remaining: stats.remaining,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
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
                Icon(icon, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    stats.departmentName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                Text(
                  stats.total.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '${stats.remaining} left to solve',
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 4),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.white24,
              color: progressColor,
              minHeight: 6,
            ),
            const SizedBox(height: 4),
            Text(
              '${stats.solved} Solved',
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
