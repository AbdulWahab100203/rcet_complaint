import 'package:flutter/material.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../../widgets/dashboard_card.dart';
import '../../routes/app_routes.dart';
import 'resolved_complaints.dart';
import 'unresolved_complaints.dart';

class ComplaintScreenMain extends StatefulWidget {
  const ComplaintScreenMain({super.key});

  @override
  State<ComplaintScreenMain> createState() => _ComplaintScreenMainState();
}

class _ComplaintScreenMainState extends State<ComplaintScreenMain> {
  int _selectedIndex = 0;
  bool showResolved = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Image.asset(
                'assets/images/logo.png',
                height: 80,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error, size: 50, color: Colors.red),
              ),
            ),

            const SizedBox(height: 15),

            // Dashboard
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  DashboardCard(title: "ComplaintBox", count: "3"),
                  DashboardCard(title: "Complaints", count: "99"),
                  DashboardCard(title: "Resolved", count: "56"),
                ],
              ),
            ),
            const SizedBox(height: 20),
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
                    toggleButton("Resolved", showResolved),
                    toggleButton("Unresolved", !showResolved),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Complaint List from Components
            Expanded(
              child: showResolved
                  ? const ResolvedComplaints()
                  : UnresolvedComplaints(),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: CustomBottomBar(
        selectedIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          switch (index) {
            case 1:
              Navigator.pushReplacementNamed(context, AppRoutes.event);
              break;
            case 2:
              Navigator.pushReplacementNamed(context, AppRoutes.complaintbox);
              break;
            case 3:
              Navigator.pushReplacementNamed(context, AppRoutes.setting);
              break;
          }
        },
      ),
    );
  }

  // Toggle Button Widget
  Widget toggleButton(String title, bool isActive) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            showResolved = (title == "Resolved");
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
