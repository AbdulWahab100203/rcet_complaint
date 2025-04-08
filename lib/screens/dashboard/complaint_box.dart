import 'package:flutter/material.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../../widgets/complaint_box.dart';
import '../../widgets/primary_button.dart';
import '../../routes/app_routes.dart';

class ComplaintScreen extends StatefulWidget {
  const ComplaintScreen({super.key});

  @override
  State<ComplaintScreen> createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  int _selectedIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 16),
            child: Text(
              'Complaint Box',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 25),
            child: PrimaryButton(
              text: 'Create Complaint Box',
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.addComplaintBox);
              },
              backgroundColor: Colors.white,
              textColor: Colors.black,
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              children: const [
                ComplaintBox(
                  title: "CSE Department",
                  total: 114,
                  solved: 90,
                  remaining: 24,
                  icon: Icons.computer,
                  progressColor: Colors.orange,
                ),
                ComplaintBox(
                  title: "Mech Department",
                  total: 56,
                  solved: 50,
                  remaining: 6,
                  icon: Icons.settings,
                  progressColor: Colors.purple,
                ),
                ComplaintBox(
                  title: "Electrical Department",
                  total: 56,
                  solved: 50,
                  remaining: 6,
                  icon: Icons.settings,
                  progressColor: Colors.purple,
                ),
                ComplaintBox(
                  title: "Boys Hostel A",
                  total: 64,
                  solved: 23,
                  remaining: 41,
                  icon: Icons.home,
                  progressColor: Colors.cyan,
                ),
                ComplaintBox(
                  title: "Boys Hostel B",
                  total: 64,
                  solved: 23,
                  remaining: 41,
                  icon: Icons.home,
                  progressColor: Color.fromARGB(255, 77, 112, 73),
                ),
                ComplaintBox(
                  title: "Boys Hostel C",
                  total: 64,
                  solved: 23,
                  remaining: 41,
                  icon: Icons.home,
                  progressColor: Color.fromARGB(255, 108, 90, 169),
                ),
                ComplaintBox(
                  title: "Girls Hostel",
                  total: 64,
                  solved: 23,
                  remaining: 41,
                  icon: Icons.home,
                  progressColor: Colors.cyan,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomBar(
        selectedIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, AppRoutes.mainDashboard);
              break;
            case 1:
              Navigator.pushReplacementNamed(context, AppRoutes.event);
              break;
            case 2:
              Navigator.pushNamed(context, AppRoutes.addComplaintBox);
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
}
