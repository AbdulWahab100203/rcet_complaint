import 'package:flutter/material.dart';
import '../routes/app_routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text('Abdul Wahab'),
            accountEmail: const Text('rcet.complaint@gmail.com'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile.png'),
            ),
            otherAccountsPictures: [
              IconButton(
                icon: const Icon(Icons.settings, size: 28, color: Colors.white),
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, AppRoutes.setting); // Update route if needed
                },
              ),
            ],
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/back.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pushReplacementNamed(
                  context, AppRoutes.mainDashboard); // Update route if needed
            },
          ),
          ListTile(
            leading: const Icon(Icons.event),
            title: const Text('Timeline'),
            onTap: () {
              Navigator.pushReplacementNamed(
                  context, AppRoutes.event); // Update route if needed
            },
          ),
          ListTile(
            leading: const Icon(Icons.message),
            title: const Text('Complaint Box'),
            onTap: () {
              Navigator.pushReplacementNamed(
                  context, AppRoutes.complaintbox); // Update route if needed
            },
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Employees'),
            onTap: () {
              Navigator.pushReplacementNamed(context, AppRoutes.employees);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pushReplacementNamed(
                  context, AppRoutes.setting); // Update route if needed
            },
          ),
        ],
      ),
    );
  }
}
