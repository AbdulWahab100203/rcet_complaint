import 'package:flutter/material.dart';
import 'package:rcet_complaint/screens/dashboard/ComplaintDetailScreen.dart';

class ComplaintCard extends StatelessWidget {
  final String id;
  final String title;

  const ComplaintCard({
    required this.id,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black),
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: Text(
          id,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 14),
        ),
        trailing: GestureDetector(
          onTap: () {
            // Debugging line to check if onTap is triggered
            print("Navigating to Complaint Detail: $id, $title");

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ComplaintDetailScreen(
                  id: id,
                  title: title,
                ),
              ),
            );
          },
          child: const Text(
            "View",
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ),
    );
  }
}
