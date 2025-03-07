import 'package:flutter/material.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../../widgets/tab_button.dart';
import '../../widgets/complaint_card.dart';
import '../../widgets/dashboard_card.dart';

class ComplaintScreenMain extends StatelessWidget {
  final List<Map<String, String>> complaints = [
    {'id': '1', 'title': 'Complaint regarding boys hostels'},
    {'id': '2', 'title': 'Complaint regarding repair'},
    {'id': '3', 'title': 'Complaint regarding electricity'},
  ];

  ComplaintScreenMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 30),

          // Logo at the top
          Center(
            child: Image.asset(
              'assets/images/logo.png',
              height: 80,
            ),
          ),

          const SizedBox(height: 15),

          // Dashboard Cards Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DashboardCard(title: "Complaint Box", count: "3"),
                DashboardCard(title: "Complaints", count: "99"),
                DashboardCard(title: "Resolved Complaints", count: "56"),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Tab Bar Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A4B),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TabButton(title: "Solved Complaints", isActive: true),
                  TabButton(title: "Unresolved Complaints", isActive: false),
                ],
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Complaint List
          Expanded(
            child: ListView.builder(
              itemCount: complaints.length,
              itemBuilder: (context, index) {
                return ComplaintCard(
                  id: complaints[index]['id']!,
                  title: complaints[index]['title']!,
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomBar(selectedIndex: 0),
    );
  }
}
