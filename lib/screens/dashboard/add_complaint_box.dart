import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/custom_bottom_bar.dart';

class AddComplaintBox extends StatefulWidget {
  @override
  State<AddComplaintBox> createState() => _AddComplaintBoxState();
}

class _AddComplaintBoxState extends State<AddComplaintBox> {
  String name = '';
  String description = '';
  int _selectedIndex = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                'Add Complaint Box',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.lightBlue[200],
                child: const Icon(Icons.person, size: 30, color: Colors.white),
              ),
              const SizedBox(height: 20),
              TextField(
                onChanged: (value) => name = value,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                onChanged: (value) => description = value,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              PrimaryButton(
                text: 'Create',
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, AppRoutes.complaintbox);
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomBar(
        selectedIndex: _selectedIndex,
        onTap: (index) {
          setState(() => _selectedIndex = index);
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, AppRoutes.mainDashboard);
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
}
