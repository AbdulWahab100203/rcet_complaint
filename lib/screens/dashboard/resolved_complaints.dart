import 'package:flutter/material.dart';
import 'package:rcet_complaint/widgets/dashboard_card.dart';

class ResolvedComplaints extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> resolved = [
      {'id': '1', 'title': 'Resolved electricity issue'},
      {'id': '2', 'title': 'Fixed water leakage'},
      {'id': '3', 'title': 'Cleanliness improved'},
    ];

    return ListView.builder(
      itemCount: resolved.length,
      itemBuilder: (context, index) {
        return ComplaintCard(
          id: resolved[index]['id']!,
          title: resolved[index]['title']!,
        );
      },
    );
  }
}
