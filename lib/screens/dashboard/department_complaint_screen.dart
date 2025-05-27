import 'package:flutter/material.dart';
import 'package:rcet_complaint/screens/dashboard/ComplaintDetailScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.departmentName} Complaints',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: const Color.fromARGB(255, 255, 255, 255),
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
                      foregroundColor: !showResolved
                          ? Colors.white
                          : const Color(0xFF1A1A4B),
                      backgroundColor: !showResolved
                          ? const Color(0xFF1A1A4B)
                          : const Color.fromARGB(255, 255, 254, 254),
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
                      foregroundColor:
                          showResolved ? Colors.white : const Color(0xFF1A1A4B),
                      backgroundColor: showResolved
                          ? const Color(0xFF1A1A4B)
                          : const Color.fromARGB(255, 255, 254, 254),
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
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('complaints')
                  .where('department', isEqualTo: widget.departmentName)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final docs = snapshot.data!.docs;
                final filteredComplaints = docs.where((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  return showResolved
                      ? (data['status'] == 'resolved' ||
                          data['status'] == 'Resolved')
                      : (data['status'] != 'resolved' &&
                          data['status'] != 'Resolved');
                }).toList();
                if (filteredComplaints.isEmpty) {
                  return const Center(child: Text('No complaints found.'));
                }
                return ListView.builder(
                  itemCount: filteredComplaints.length,
                  padding: const EdgeInsets.all(16),
                  itemBuilder: (context, index) {
                    final doc = filteredComplaints[index];
                    final complaint = doc.data() as Map<String, dynamic>;
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ComplaintDetailScreen(
                              id: doc.id,
                              title: complaint['title'] ?? '',
                            ),
                          ),
                        );
                      },
                      child: Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      complaint['title'] ?? '',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: (complaint['status'] ==
                                                  'resolved' ||
                                              complaint['status'] == 'Resolved')
                                          ? Colors.green
                                          : Colors.orange,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      (complaint['status'] == 'resolved' ||
                                              complaint['status'] == 'Resolved')
                                          ? 'Resolved'
                                          : 'Unresolved',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                complaint['description'] ?? '',
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Date: ' +
                                    (complaint['createdAt'] != null
                                        ? (complaint['createdAt'] as Timestamp)
                                            .toDate()
                                            .toString()
                                            .split(' ')
                                            .first
                                        : (complaint['date'] ?? '')),
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
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
