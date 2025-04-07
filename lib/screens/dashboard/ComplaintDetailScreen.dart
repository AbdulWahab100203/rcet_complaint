import 'package:flutter/material.dart';

class ComplaintDetailScreen extends StatelessWidget {
  final String id;
  final String title;

  const ComplaintDetailScreen(
      {required this.id, required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Complaint Detail')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Complaint ID: $id',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text('Title: $title', style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
