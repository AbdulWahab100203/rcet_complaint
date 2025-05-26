import 'package:flutter/material.dart';

class ComplaintDetailScreen extends StatelessWidget {
  final String id;
  final String title;
  final int total;
  final int solved;

  const ComplaintDetailScreen({
    required this.id,
    required this.title,
    this.total = 1,
    this.solved = 0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double progress = total > 0 ? solved / total : 0.0;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complaint Detail'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.blue.shade100,
                          child: Text(
                            id,
                            style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Complaint ID: $id',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.grey[300],
                      color: Colors.blue,
                      minHeight: 6,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$solved of $total solved',
                      style:
                          const TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    const Divider(),
                    const SizedBox(height: 16),
                    _buildInfoRow('Status', 'Under Review', Colors.orange),
                    const SizedBox(height: 12),
                    _buildInfoRow('Department', 'IT Department', Colors.blue),
                    const SizedBox(height: 12),
                    _buildInfoRow('Priority', 'High', Colors.red),
                    const SizedBox(height: 16),
                    const Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, Color tagColor) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: tagColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: tagColor.withOpacity(0.5)),
          ),
          child: Text(
            value,
            style: TextStyle(
              color: tagColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
