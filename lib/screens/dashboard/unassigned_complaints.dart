import 'package:flutter/material.dart';

class UnassignedComplaints extends StatefulWidget {
  const UnassignedComplaints({Key? key}) : super(key: key);

  @override
  State<UnassignedComplaints> createState() => _UnassignedComplaintsState();
}

class _UnassignedComplaintsState extends State<UnassignedComplaints> {
  // List of departments and their staff
  final Map<String, List<String>> departments = {
    'Electrical': [
      'John (Electrician)',
      'Mike (Electrician)',
      'Sarah (Electronics)'
    ],
    'Cleaning': ['Alice (Sweeper)', 'Bob (Janitor)', 'Carol (Cleaner)'],
    'IT': [
      'David (System Admin)',
      'Eve (Network Engineer)',
      'Frank (IT Support)'
    ],
    'Maintenance': ['George (Plumber)', 'Helen (HVAC)', 'Ian (Carpenter)'],
  };

  String? selectedDepartment;
  String? selectedStaff;

  // Dummy data for unassigned complaints
  final List<Map<String, dynamic>> unassignedComplaints = [
    {
      'id': '3',
      'title': 'AC Maintenance',
      'description': 'AC not cooling in Room 105',
      'status': 'New',
      'date': '2025-04-27',
      'suggestedDepartment': 'Electrical',
    },
    {
      'id': '4',
      'title': 'Computer Issue',
      'description': 'System not booting in Lab 2',
      'status': 'New',
      'date': '2025-04-25',
      'suggestedDepartment': 'IT',
    },
    {
      'id': '5',
      'title': 'Washroom Cleaning',
      'description': 'First floor washroom needs cleaning',
      'status': 'New',
      'date': '2025-04-27',
      'suggestedDepartment': 'Cleaning',
    },
  ];

  void _showAssignmentDialog(Map<String, dynamic> complaint) {
    selectedDepartment = complaint['suggestedDepartment'];
    selectedStaff = null;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Assign Complaint'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Complaint: ${complaint['title']}',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(complaint['description']),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Select Department',
                      border: OutlineInputBorder(),
                    ),
                    value: selectedDepartment,
                    items: departments.keys.map((String department) {
                      return DropdownMenuItem<String>(
                        value: department,
                        child: Text(department),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedDepartment = newValue;
                        selectedStaff = null;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  if (selectedDepartment != null)
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Select Staff',
                        border: OutlineInputBorder(),
                      ),
                      value: selectedStaff,
                      items:
                          departments[selectedDepartment]!.map((String staff) {
                        return DropdownMenuItem<String>(
                          value: staff,
                          child: Text(staff),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedStaff = newValue;
                        });
                      },
                    ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: selectedDepartment != null && selectedStaff != null
                      ? () {
                          // Here you would typically update the complaint assignment in your backend
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Complaint assigned to ${selectedStaff} from ${selectedDepartment} department',
                              ),
                              backgroundColor: Colors.green,
                            ),
                          );
                          Navigator.of(context).pop();
                        }
                      : null,
                  child: const Text('Assign'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: unassignedComplaints.length,
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, index) {
        final complaint = unassignedComplaints[index];
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
                        complaint['status'],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    Text(complaint['date']),
                  ],
                ),
              ],
            ),
            onTap: () => _showAssignmentDialog(complaint),
          ),
        );
      },
    );
  }
}
