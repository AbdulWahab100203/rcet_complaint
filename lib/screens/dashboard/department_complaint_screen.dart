import 'package:flutter/material.dart';

class DepartmentComplaintScreen extends StatefulWidget {
  final String departmentName;
  final int total;
  final int solved;
  final int remaining;

  const DepartmentComplaintScreen({
    Key? key,
    required this.departmentName,
    required this.total,
    required this.solved,
    required this.remaining,
  }) : super(key: key);

  @override
  State<DepartmentComplaintScreen> createState() =>
      _DepartmentComplaintScreenState();
}

class _DepartmentComplaintScreenState extends State<DepartmentComplaintScreen> {
  bool showResolved = false;

  // Sample complaint data - replace with your actual data
  List<Map<String, dynamic>> complaints = [
    {
      'title': 'Computer not working',
      'description': 'PC in Lab 3 not booting up',
      'status': 'Unresolved',
      'date': '2025-04-27',
      'priority': 'High',
    },
    {
      'title': 'Projector Issue',
      'description': 'Projector not working in Room 201',
      'status': 'Resolved',
      'date': '2025-04-26',
      'priority': 'Medium',
    },
    {
      'title': 'Software Installation',
      'description': 'Need to install Visual Studio',
      'status': 'Unresolved',
      'date': '2025-04-25',
      'priority': 'Low',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredComplaints = complaints
        .where((complaint) => showResolved
            ? complaint['status'] == 'Resolved'
            : complaint['status'] == 'Unresolved')
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.departmentName} Complaints',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 242, 242, 245),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: const Color.fromARGB(255, 198, 198, 200),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatCard('Total', widget.total),
                _buildStatCard('Resolved', widget.solved),
                _buildStatCard('Pending', widget.remaining),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          !showResolved ? const Color(0xFF1A1A4B) : Colors.grey,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () {
                      setState(() {
                        showResolved = false;
                      });
                    },
                    child: const Text('Unresolved'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          showResolved ? const Color(0xFF1A1A4B) : Colors.grey,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () {
                      setState(() {
                        showResolved = true;
                      });
                    },
                    child: const Text('Resolved'),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredComplaints.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final complaint = filteredComplaints[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                complaint['title'],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: complaint['status'] == 'Resolved'
                                    ? Colors.green
                                    : Colors.orange,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                complaint['status'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          complaint['description'],
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Date: ${complaint['date']}',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: complaint['priority'] == 'High'
                                    ? Colors.red
                                    : complaint['priority'] == 'Medium'
                                        ? Colors.orange
                                        : Colors.green,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'Priority: ${complaint['priority']}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, int value) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        child: Column(
          children: [
            Text(
              value.toString(),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A4B),
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
