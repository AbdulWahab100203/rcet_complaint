import 'package:flutter/material.dart';
import 'package:rcet_complaint/widgets/app_drawer.dart';
import '../../routes/app_routes.dart';
import '../../widgets/custom_bottom_bar.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  int _selectedIndex = 4; // Profile/Settings tab is selected

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true, // ✅ This centers the title
        title: const Text(
          'Settings',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: const AppDrawer(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                children: [
                  const SizedBox(height: 15),
                  Center(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey[200],
                          child: const Icon(
                            Icons.person,
                            size: 40,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Ali Hassan',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'ali@gmail.com',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pushNamed(
                              context, AppRoutes.editProfile),
                          child: const Text('Edit profile'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'General',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.lock_outline),
                          title: const Text('Change Password'),
                          trailing:
                              const Icon(Icons.arrow_forward_ios, size: 14),
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.changePassword);
                          },
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: const Icon(Icons.dark_mode_outlined),
                          title: const Text('Dark Mode'),
                          trailing: const Switch(
                            value: false,
                            onChanged: null,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Help & Legal',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.help_outline),
                          title: const Text('Help'),
                          trailing:
                              const Icon(Icons.arrow_forward_ios, size: 14),
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.help);
                          },
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: const Icon(Icons.policy_outlined),
                          title: const Text('Policies'),
                          trailing:
                              const Icon(Icons.arrow_forward_ios, size: 14),
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.policies);
                          },
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: const Icon(Icons.report_problem_outlined),
                          title: const Text('Report Problem'),
                          trailing:
                              const Icon(Icons.arrow_forward_ios, size: 14),
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.reportProblem);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.logout, color: Colors.red),
                      title: const Text(
                        'Logout',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, AppRoutes.login);
                      },
                    ),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
            CustomBottomBar(
              selectedIndex: _selectedIndex,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
                // Handle navigation based on index
                switch (index) {
                  case 0: // Home

                    Navigator.pushReplacementNamed(
                        context, AppRoutes.mainDashboard);
                    break;
                  case 1: // Events
                    Navigator.pushReplacementNamed(context, AppRoutes.event);
                    break;
                  case 2: // Complaints
                    Navigator.pushReplacementNamed(
                        context, AppRoutes.addComplaintBox);
                    break;
                  case 3: // Complaints
                    Navigator.pushReplacementNamed(
                        context, AppRoutes.complaintbox);
                    break;
                  case 4: // Profile
                    break; // Already on profile/settings
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
