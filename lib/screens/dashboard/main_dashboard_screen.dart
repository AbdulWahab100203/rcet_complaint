import 'package:flutter/material.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../../widgets/dashboard_card.dart';
import '../../routes/app_routes.dart';
<<<<<<< HEAD
=======
import 'resolved_complaints.dart'; // ✅ your component
import 'unresolved_complaints.dart'; // ✅ your component
>>>>>>> 93e3a5861ffed1c97d1301867c39aed0dfcbe7d1

class ComplaintScreenMain extends StatefulWidget {
  const ComplaintScreenMain({super.key});

  @override
  State<ComplaintScreenMain> createState() => _ComplaintScreenMainState();
}

class _ComplaintScreenMainState extends State<ComplaintScreenMain> {
  int _selectedIndex = 0;
<<<<<<< HEAD
  final List<Map<String, dynamic>> complaints = [
    {'id': '1', 'title': 'Complaint regarding boys hostels'},
    {'id': '2', 'title': 'Complaint regarding repair'},
    {'id': '3', 'title': 'Complaint regarding electricity'},
  ];
=======
  bool showResolved = true;
>>>>>>> 93e3a5861ffed1c97d1301867c39aed0dfcbe7d1

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

<<<<<<< HEAD
            // Logo at the top
            Center(
              child: Image.asset(
                'assets/images/logo.png',
                height: 80,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error, size: 50, color: Colors.red);
                },
=======
            // Logo
            Center(
              child: Image.asset(
                'images/logo.png',
                height: 80,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error, size: 50, color: Colors.red),
>>>>>>> 93e3a5861ffed1c97d1301867c39aed0dfcbe7d1
              ),
            ),

            const SizedBox(height: 15),

<<<<<<< HEAD
            // Dashboard Cards Row
=======
            // Dashboard
>>>>>>> 93e3a5861ffed1c97d1301867c39aed0dfcbe7d1
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
<<<<<<< HEAD
                children: [
                  DashboardCard(title: "Complaint Box", count: "3"),
                  DashboardCard(title: "Complaints", count: "99"),
                  DashboardCard(title: "Resolved Complaints", count: "56"),
=======
                children: const [
                  DashboardCard(title: "Complaint Box", count: "3"),
                  DashboardCard(title: "Complaints", count: "99"),
                  DashboardCard(title: "Resolved", count: "56"),
>>>>>>> 93e3a5861ffed1c97d1301867c39aed0dfcbe7d1
                ],
              ),
            ),

            const SizedBox(height: 20),

<<<<<<< HEAD
            // Tab Bar Section
=======
            // Toggle Buttons
>>>>>>> 93e3a5861ffed1c97d1301867c39aed0dfcbe7d1
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
<<<<<<< HEAD
                  // children: [
                  //   TabButton(title: "Solved Complaints", isActive: true),
                  //   TabButton(title: "Unresolved Complaints", isActive: false),
                  // ],
=======
                  children: [
                    toggleButton("Resolved", showResolved),
                    toggleButton("Unresolved", !showResolved),
                  ],
>>>>>>> 93e3a5861ffed1c97d1301867c39aed0dfcbe7d1
                ),
              ),
            ),

            const SizedBox(height: 10),

<<<<<<< HEAD
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
=======
            // Complaint List from Components
            Expanded(
              child: showResolved
                  ? const ResolvedComplaints()
                  : UnresolvedComplaints(),
>>>>>>> 93e3a5861ffed1c97d1301867c39aed0dfcbe7d1
            ),
          ],
        ),
      ),
<<<<<<< HEAD
=======

      // Bottom Navigation Bar
>>>>>>> 93e3a5861ffed1c97d1301867c39aed0dfcbe7d1
      bottomNavigationBar: CustomBottomBar(
        selectedIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
<<<<<<< HEAD
          // Handle navigation based on index
          switch (index) {
            case 0: // Home
              break;
            case 1: // Events
              Navigator.pushReplacementNamed(context, AppRoutes.event);
              break;
            case 2: // Events
              Navigator.pushReplacementNamed(
                  context, AppRoutes.addComplaintBox);
              break;
            case 3: // Complaints
              Navigator.pushReplacementNamed(context, AppRoutes.complaintbox);
              break;
            case 4: // Profile
=======
          switch (index) {
            case 1:
              Navigator.pushReplacementNamed(context, AppRoutes.event);
              break;
            case 2:
              Navigator.pushReplacementNamed(context, AppRoutes.complaintbox);
              break;
            case 3:
>>>>>>> 93e3a5861ffed1c97d1301867c39aed0dfcbe7d1
              Navigator.pushReplacementNamed(context, AppRoutes.setting);
              break;
          }
        },
      ),
<<<<<<< HEAD
=======
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
>>>>>>> 93e3a5861ffed1c97d1301867c39aed0dfcbe7d1
    );
  }
}

// import "package:flutter/material.dart";

// class ComplaintScreenMain extends StatelessWidget {
//   const ComplaintScreenMain({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Text("home screen"),
//     );
//   }
// }
