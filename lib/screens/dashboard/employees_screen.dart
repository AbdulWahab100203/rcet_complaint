import 'package:flutter/material.dart';
import '../../models/employee.dart';

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

  final List<Employee> employees = [
    Employee(
      id: 'e1',
      name: 'Ali Khan',
      department: 'Electrician',
      contact: '03001234567',
      email: 'ali.khan@example.com',
    ),
    Employee(
      id: 'e2',
      name: 'Ahmed Raza',
      department: 'Plumber',
      contact: '03019876543',
      email: 'ahmed.raza@example.com',
    ),
    Employee(
      id: 'e3',
      name: 'Sana Ullah',
      department: 'Sweeper',
      contact: '03111234567',
      email: 'sana.ullah@example.com',
    ),
    Employee(
      id: 'e4',
      name: 'Farhan Ali',
      department: 'Carpenter',
      contact: '03211234567',
      email: 'farhan.ali@example.com',
    ),
    Employee(
      id: 'e5',
      name: 'Zubair Ahmad',
      department: 'Painter',
      contact: '03311234567',
      email: 'zubair.ahmad@example.com',
    ),
  ];

  void _showAddEmployeeDialog() {
    final nameController = TextEditingController();
    final contactController = TextEditingController();
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
                controller: contactController,
                decoration: const InputDecoration(labelText: 'Contact'),
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
            onPressed: () => Navigator.of(context).pop(),
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
        body: TabBarView(
          children: departments.map((department) {
            final deptEmployees =
                employees.where((emp) => emp.department == department).toList();
            return ListView.builder(
              itemCount: deptEmployees.length,
              itemBuilder: (ctx, i) => ListTile(
                title: Text(deptEmployees[i].name),
                subtitle: Text(deptEmployees[i].contact),
                trailing: Text(deptEmployees[i].email),
              ),
            );
          }).toList(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _showAddEmployeeDialog,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
