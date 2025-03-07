import 'package:flutter/material.dart';
import '../../widgets/profile_pic.dart';
import '../../widgets/custom_text_field.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100, // Light background
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 24),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Edit Profile",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: const [
              ProfilePicture(), // Using custom Profile Picture widget
              SizedBox(height: 25),
              CustomTextField(label: "Username", hintText: "Faiqa Farooq"),
              CustomTextField(
                  label: "Password", hintText: "**********", isPassword: true),
              CustomTextField(label: "Phone", hintText: "+92-300 268 6600"),
            ],
          ),
        ),
      ),
    );
  }
}
