import 'package:flutter/material.dart';
import 'package:rcet_complaint/widgets/app_drawer.dart';
import '../../routes/app_routes.dart';
import '../../widgets/custom_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  int _selectedIndex = 4; // Profile/Settings tab is selected
  String? userName;
  String? userEmail;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserInfo();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Always refresh user info when returning to this screen
    fetchUserInfo();
  }

  Future<void> fetchUserInfo() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      userEmail = user.email;
      // Fetch from 'User' collection and use 'username' field
      final doc = await FirebaseFirestore.instance
          .collection('User')
          .doc(user.uid)
          .get();
      setState(() {
        userName = doc.data()?['username'] ?? user.displayName ?? 'No Name';
        isLoading = false;
      });
    }
  }

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
                  const SizedBox(height: 10),
                  Center(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.grey[200],
                          child: const Icon(
                            Icons.person,
                            size: 25,
                          ),
                        ),
                        const SizedBox(height: 12),
                        isLoading
                            ? const CircularProgressIndicator()
                            : Text(
                                userName ?? '',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                        const SizedBox(height: 8),
                        isLoading
                            ? const SizedBox.shrink()
                            : Text(
                                userEmail ?? '',
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey,
                                ),
                              ),
                        TextButton(
                          onPressed: () async {
                            await Navigator.pushNamed(
                                context, AppRoutes.editProfile);
                            fetchUserInfo();
                          },
                          child: const Text('Edit profile'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'General',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 7),
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
                              const Icon(Icons.arrow_forward_ios, size: 12),
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.changePassword);
                          },
                        ),
                        // const Divider(height: 1),
                        // ListTile(
                        //   leading: const Icon(Icons.dark_mode_outlined),
                        //   title: const Text('Dark Mode'),
                        //   trailing: const Switch(
                        //     value: false,
                        //     onChanged: null,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Help & Legal',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 7),
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
                              const Icon(Icons.arrow_forward_ios, size: 12),
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.help);
                          },
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: const Icon(Icons.policy_outlined),
                          title: const Text('Policies'),
                          trailing:
                              const Icon(Icons.arrow_forward_ios, size: 12),
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.policies);
                          },
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: const Icon(Icons.report_problem_outlined),
                          title: const Text('Report Problem'),
                          trailing:
                              const Icon(Icons.arrow_forward_ios, size: 12),
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
