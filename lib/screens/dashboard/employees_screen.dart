import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/employee.dart';
import '../../widgets/app_drawer.dart';

class EmployeesScreen extends StatefulWidget {
  static const routeName = '/employees';

  const EmployeesScreen({super.key});

  @override
  State<EmployeesScreen> createState() => _EmployeesScreenState();
}

class _EmployeesScreenState extends State<EmployeesScreen> {
  final List<String> departments = [
    'Plumber',
    'Electrician',
    'Sweeper',
    'Carpenter',
    'Painter',
  ];

  void _showAddEmployeeDialog() {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final emailController = TextEditingController();
    String? selectedDepartment;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Employee'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: 'Phone'),
                keyboardType: TextInputType.phone,
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Department'),
                items: departments.map((String department) {
                  return DropdownMenuItem(
                    value: department,
                    child: Text(department),
                  );
                }).toList(),
                value: selectedDepartment,
                onChanged: (String? value) {
                  setState(() {
                    selectedDepartment = value;
                  });
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              if (nameController.text.isEmpty ||
                  phoneController.text.isEmpty ||
                  emailController.text.isEmpty ||
                  selectedDepartment == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please fill all fields')),
                );
                return;
              }
              await FirebaseFirestore.instance.collection('employees').add({
                'name': nameController.text,
                'phone': phoneController.text,
                'email': emailController.text,
                'department': selectedDepartment,
                'role': '',
                'createdAt': FieldValue.serverTimestamp(),
              });
              Navigator.of(context).pop();
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: departments.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Employees'),
          bottom: TabBar(
            isScrollable: true,
            tabs: departments.map((dept) => Tab(text: dept)).toList(),
          ),
        ),
        drawer: const AppDrawer(),
        body: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection('employees').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final docs = snapshot.data!.docs;
            final allEmployees = docs
                .map((doc) => Employee.fromFirestore(
                    doc.data() as Map<String, dynamic>, doc.id))
                .toList();
            return TabBarView(
              children: departments.map((department) {
                final deptEmployees = allEmployees
                    .where((emp) => emp.department == department)
                    .toList();
                return ListView.builder(
                  itemCount: deptEmployees.length,
                  itemBuilder: (ctx, i) => ListTile(
                    title: Text(deptEmployees[i].name),
                    subtitle: Text(deptEmployees[i].phone),
                    trailing: Text(deptEmployees[i].email),
                  ),
                );
              }).toList(),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _showAddEmployeeDialog,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
