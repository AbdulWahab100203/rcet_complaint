import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../../widgets/primary_button.dart';

class Complaint {
  final String title;
  final String description;
  final String department;
  final DateTime dateSubmitted;
  final String status;

  Complaint({
    required this.title,
    required this.description,
    required this.department,
    required this.dateSubmitted,
    required this.status,
  });
}

class DashboardScreen extends StatelessWidget {
  final List<Complaint> complaints = [
    Complaint(
      title: 'Network Issue in Lab 3',
      description: 'Wifi not working in Computer Lab 3',
      department: 'IT Department',
      dateSubmitted: DateTime.now().subtract(const Duration(days: 1)),
      status: 'Pending',
    ),

    Complaint(
      title: 'Broken Chair',
      description: 'Chair broken in Room 201',
      department: 'Maintenance',
      dateSubmitted: DateTime.now().subtract(const Duration(days: 2)),
      status: 'In Progress',
    ),
    Complaint(
      title: 'Broken Chair',
      description: 'Chair broken in Room 201',
      department: 'Maintenance',
      dateSubmitted: DateTime.now().subtract(const Duration(days: 2)),
      status: 'In Progress',
    ),

    // Add more sample complaints here
  ];

  DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 40),
          Expanded(
            child: ListView.builder(
              itemCount: complaints.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final complaint = complaints[index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 16),
                  child: ListTile(
                    title: Text(
                      complaint.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(complaint.department),
                        const SizedBox(height: 4),
                        Text(
                          'Submitted: ${complaint.dateSubmitted.toString().split(' ')[0]}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: complaint.status == 'Pending'
                            ? Colors.orange
                            : complaint.status == 'In Progress'
                                ? Colors.blue
                                : Colors.green,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        complaint.status,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    onTap: () => Navigator.pushNamed(
                      context,
                      '/complaint-details',
                      arguments: complaint,
                    ),
                  ),
                );
              },
            ),
          ),
          const CustomBottomBar(selectedIndex: 0),
        ],
      ),
    );
  }
}
