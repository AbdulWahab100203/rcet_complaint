import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';
import '../../widgets/primary_button.dart';

class AddComplaintBox extends StatefulWidget {
  const AddComplaintBox({super.key});

  @override
  State<AddComplaintBox> createState() => _AddComplaintBoxState();
}

class _AddComplaintBoxState extends State<AddComplaintBox> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  int _maxUsers = 7;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Add new\nComplaint Box',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.lightBlue[200],
                        child: const Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 10,
                      bottom: 10,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.add, size: 16),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Enter Name For Complaint Box',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Description',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                'Maximum Users',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.grey[200],
                    child: IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        if (_maxUsers > 1) {
                          setState(() {
                            _maxUsers--;
                          });
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      '$_maxUsers',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.grey[200],
                    child: IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          _maxUsers++;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              PrimaryButton(
                text: 'Create Complaint Box',
                onPressed: () {
                  // Handle create complaint box
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
