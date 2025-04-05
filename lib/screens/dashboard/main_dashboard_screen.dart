import 'package:flutter/material.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../../widgets/tab_button.dart';
import '../../widgets/complaint_card.dart';
import '../../widgets/dashboard_card.dart';

class ComplaintScreenMain extends StatefulWidget {
  ComplaintScreenMain({super.key});

  @override
  State<ComplaintScreenMain> createState() => _ComplaintScreenMainState();
}

class _ComplaintScreenMainState extends State<ComplaintScreenMain> {
  int _selectedIndex = 0;
  final List<Map<String, dynamic>> complaints = [
    {'id': '1', 'title': 'Complaint regarding boys hostels'},
    {'id': '2', 'title': 'Complaint regarding repair'},
    {'id': '3', 'title': 'Complaint regarding electricity'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Logo at the top
            Center(
              child: Image.asset(
                'assets/images/logo.png',
                height: 80,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error, size: 50, color: Colors.red);
                },
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // children: [
                  //   TabButton(title: "Solved Complaints", isActive: true),
                  //   TabButton(title: "Unresolved Complaints", isActive: false),
                  // ],
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Complaint List
            Expanded(
              child: complaints.isNotEmpty
                  ? ListView.builder(
                      itemCount: complaints.length,
                      itemBuilder: (context, index) {
                        // return ComplaintCard(
                        //   id: complaints[index]['id'].toString(),
                        //   title: complaints[index]['title'],
                        // );
                      },
                    )
                  : const Center(
                      child: Text(
                        "No Complaints Available",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomBar(
        selectedIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          // Handle navigation based on index
          switch (index) {
            case 0: // Home
              break;
            case 1: // Events
              Navigator.pushNamed(context, '/events');
              break;
            case 2: // Complaints
              Navigator.pushNamed(context, '/complaints');
              break;
            case 3: // Profile
              Navigator.pushNamed(context, '/profile');
              break;
          }
        },
      ),
    );
  }
}
