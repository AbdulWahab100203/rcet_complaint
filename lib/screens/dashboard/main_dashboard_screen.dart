import 'package:flutter/material.dart';
import 'package:rcet_complaint/widgets/app_drawer.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../../routes/app_routes.dart';
import 'resolved_complaints.dart';
import 'unassigned_complaints.dart';
import 'assigned_complaints.dart';

class ComplaintScreenMain extends StatefulWidget {
  const ComplaintScreenMain({Key? key}) : super(key: key);

  @override
  State<ComplaintScreenMain> createState() => _ComplaintScreenMainState();
}

class _ComplaintScreenMainState extends State<ComplaintScreenMain> {
  int _selectedIndex = 0;
  String selectedTab =
      "unassigned"; // Can be "unassigned", "assigned", or "resolved"

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        title: const Text(
          'RCET Complaint Box',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            // const SizedBox(height: 5),
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
                    toggleButton("Unassigned", selectedTab == "unassigned"),
                    toggleButton("Assigned", selectedTab == "assigned"),
                    toggleButton("Resolved", selectedTab == "resolved"),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: _buildSelectedView(),
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
          switch (index) {
            case 0:
              break;
            case 1:
              Navigator.pushReplacementNamed(context, AppRoutes.event);
              break;
            case 2:
              Navigator.pushReplacementNamed(
                  context, AppRoutes.addComplaintBox);
              break;
            case 3:
              Navigator.pushReplacementNamed(context, AppRoutes.complaintbox);
              break;
            case 4:
              Navigator.pushReplacementNamed(context, AppRoutes.setting);
              break;
          }
        },
      ),
    );
  }

  Widget _buildSelectedView() {
    switch (selectedTab) {
      case "unassigned":
        return UnassignedComplaints();
      case "assigned":
        return AssignedComplaintsScreen();
      case "resolved":
        return ResolvedComplaints();
      default:
        return UnassignedComplaints();
    }
  }

  // Toggle Button Widget
  Widget toggleButton(String title, bool isActive) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedTab = title.toLowerCase();
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
