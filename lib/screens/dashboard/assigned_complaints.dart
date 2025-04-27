import 'package:flutter/material.dart';

class AssignedComplaintsScreen extends StatefulWidget {
  const AssignedComplaintsScreen({Key? key}) : super(key: key);

  @override
  _AssignedComplaintsScreenState createState() =>
      _AssignedComplaintsScreenState();
}

class _AssignedComplaintsScreenState extends State<AssignedComplaintsScreen> {
  bool showAssigned = true; // Toggle between assigned and unassigned complaints

  // Dummy data for complaints
  final List<Map<String, dynamic>> assignedComplaints = [
    {
      'id': '1',
      'title': 'Network Issue',
      'description': 'Wi-Fi not working in Lab 3',
      'status': 'In Progress',
      'date': '2025-04-27',
    },
    {
      'id': '2',
      'title': 'Projector Problem',
      'description': 'Projector not working in Room 201',
      'status': 'Pending',
      'date': '2025-04-26',
    },
  ];

  final List<Map<String, dynamic>> unassignedComplaints = [
    {
      'id': '3',
      'title': 'AC Maintenance',
      'description': 'AC not cooling in Room 105',
      'status': 'New',
      'date': '2025-04-27',
    },
    {
      'id': '4',
      'title': 'Computer Issue',
      'description': 'System not booting in Lab 2',
      'status': 'New',
      'date': '2025-04-25',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A4B),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _toggleButton("Assigned", showAssigned),
                  _toggleButton("Unassigned", !showAssigned),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: showAssigned
                ? AssignedComplaints()
                : ListView.builder(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                          onTap: () {
                            // Handle complaint selection
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _toggleButton(String title, bool isActive) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            showAssigned = (title == "Assigned");
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: isActive ? Colors.black : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AssignedComplaints extends StatelessWidget {
  const AssignedComplaints({Key? key}) : super(key: key);

  // Dummy data for assigned complaints
  final List<Map<String, dynamic>> assignedComplaints = const [
    {
      'id': '1',
      'title': 'Network Issue',
      'description': 'Wi-Fi not working in Lab 3',
      'status': 'In Progress',
      'date': '2025-04-27',
    },
    {
      'id': '2',
      'title': 'Projector Problem',
      'description': 'Projector not working in Room 201',
      'status': 'Pending',
      'date': '2025-04-26',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: assignedComplaints.length,
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, index) {
        final complaint = assignedComplaints[index];
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
            onTap: () {
              // Handle complaint selection
            },
          ),
        );
      },
    );
  }
}
