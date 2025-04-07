import 'package:flutter/material.dart';
import 'package:rcet_complaint/widgets/dashboard_card.dart';

class UnresolvedComplaints extends StatelessWidget {
  final List<Map<String, String>> complaints = [
    {'id': '3', 'title': 'Complaint about electricity issue'},
    {'id': '4', 'title': 'Complaint about water leak'},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: complaints.length,
      itemBuilder: (context, index) {
        return ComplaintCard(
          id: complaints[index]['id']!,
          title: complaints[index]['title']!,
        );
      },
    );
  }
}
