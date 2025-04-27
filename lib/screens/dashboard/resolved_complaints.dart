import 'package:flutter/material.dart';

class ResolvedComplaints extends StatelessWidget {
  const ResolvedComplaints({Key? key}) : super(key: key);

  // Dummy data for resolved complaints
  final List<Map<String, dynamic>> resolvedComplaints = const [
    {
      'id': '1',
      'title': 'Printer Issue',
      'description': 'Printer not working in Staff Room',
      'status': 'Resolved',
      'date': '2025-04-25',
      'resolvedBy': 'Frank (IT Support)',
      'department': 'IT',
      'resolvedDate': '2025-04-26',
      'resolution': 'Replaced faulty printer cartridge and cleaned print heads',
    },
    {
      'id': '2',
      'title': 'Light Fixture',
      'description': 'Flickering lights in Room 302',
      'status': 'Resolved',
      'date': '2025-04-24',
      'resolvedBy': 'John (Electrician)',
      'department': 'Electrical',
      'resolvedDate': '2025-04-25',
      'resolution': 'Replaced faulty ballast and LED tubes',
    },
    {
      'id': '3',
      'title': 'Bathroom Maintenance',
      'description': 'Ground floor bathroom needs cleaning',
      'status': 'Resolved',
      'date': '2025-04-26',
      'resolvedBy': 'Carol (Cleaner)',
      'department': 'Cleaning',
      'resolvedDate': '2025-04-26',
      'resolution': 'Deep cleaned the bathroom and replaced supplies',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: resolvedComplaints.length,
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, index) {
        final complaint = resolvedComplaints[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            title: Text(complaint['title']),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(complaint['description']),
                const SizedBox(height: 4),
                // Department and resolved by info
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
                          '${complaint['resolvedBy']} - ${complaint['department']}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                // Resolution details
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.check_circle_outline,
                        size: 16,
                        color: Colors.green,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          complaint['resolution'],
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'Resolved',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Text('Resolved on: ${complaint['resolvedDate']}'),
                  ],
                ),
              ],
            ),
            onTap: () {
              // Show full complaint details if needed
            },
          ),
        );
      },
    );
  }
}
