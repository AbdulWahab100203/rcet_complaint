import 'package:flutter/material.dart';

class AssignedComplaintsScreen extends StatelessWidget {
  AssignedComplaintsScreen({Key? key}) : super(key: key);

  final List<Map<String, String>> assignedComplaints = [
    {
      'id': '1',
      'title': 'Wi-Fi Issue',
      'description': 'Wi-Fi not working in Lab 3',
      'status': 'In Progress',
      'date': '2025-04-27',
      'assignedTo': 'Eve',
      'role': 'Network Engineer',
      'department': 'IT',
    },
    {
      'id': '2',
      'title': 'Projector Problem',
      'description': 'Projector not working in Room 201',
      'status': 'Pending',
      'date': '2025-04-26',
      'assignedTo': 'Sarah',
      'role': 'Electronics Engineer',
      'department': 'Electrical',
    },
    {
      'id': '3',
      'title': 'Washroom Maintenance',
      'description': 'Second floor washroom needs cleaning',
      'status': 'In Progress',
      'date': '2025-04-27',
      'assignedTo': 'Alice',
      'role': 'Maintenance Staff',
      'department': 'Cleaning',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: assignedComplaints.length,
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, index) {
          final complaint = assignedComplaints[index];

          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              title: Text(complaint['title']!),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(complaint['description']!),
                  const SizedBox(height: 8),
                  // Employee and Department Info
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1A4B).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.person, size: 16),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            '${complaint['assignedTo']} (${complaint['role']}) - ${complaint['department']} Department',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: complaint['status'] == 'New'
                              ? Colors.blue
                              : complaint['status'] == 'In Progress'
                                  ? Colors.orange
                                  : Colors.red,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          complaint['status']!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Text(
                        complaint['date']!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              onTap: () {
                // Handle complaint selection
              },
            ),
          );
        },
      ),
    );
  }
}
