import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/employee.dart';

class EmployeesScreen extends StatefulWidget {
  const EmployeesScreen({Key? key}) : super(key: key);

  @override
  State<EmployeesScreen> createState() => _EmployeesScreenState();
}

class _EmployeesScreenState extends State<EmployeesScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _roleController = TextEditingController();
  final _departmentController = TextEditingController();

  Future<void> _addEmployee() async {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _roleController.text.isEmpty ||
        _departmentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }
    await FirebaseFirestore.instance.collection('employees').add({
      'name': _nameController.text,
      'email': _emailController.text,
      'phone': _phoneController.text,
      'role': _roleController.text,
      'department': _departmentController.text,
      'createdAt': FieldValue.serverTimestamp(),
    });
    _nameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _roleController.clear();
    _departmentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Employees')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Name')),
                TextField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'Email')),
                TextField(
                    controller: _phoneController,
                    decoration: InputDecoration(labelText: 'Phone')),
                TextField(
                    controller: _roleController,
                    decoration: InputDecoration(labelText: 'Role')),
                TextField(
                    controller: _departmentController,
                    decoration: InputDecoration(labelText: 'Department')),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: _addEmployee,
                  child: Text('Add Employee'),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('employees')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(child: CircularProgressIndicator());
                final docs = snapshot.data!.docs;
                if (docs.isEmpty)
                  return Center(child: Text('No employees found.'));
                final employees = docs
                    .map((doc) => Employee.fromFirestore(
                        doc.data() as Map<String, dynamic>, doc.id))
                    .toList();
                return ListView.builder(
                  itemCount: employees.length,
                  itemBuilder: (context, index) {
                    final emp = employees[index];
                    return ListTile(
                      title: Text(emp.name),
                      subtitle: Text(
                          '${emp.role} | ${emp.department} | ${emp.email}'),
                      trailing: Text(emp.phone),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
