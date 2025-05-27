import 'package:flutter/material.dart';
import 'package:rcet_complaint/widgets/app_drawer.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../../routes/app_routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/complaint.dart';
import '../../models/employee.dart';

class ComplaintScreenMain extends StatefulWidget {
  const ComplaintScreenMain({Key? key}) : super(key: key);

  @override
  State<ComplaintScreenMain> createState() => _ComplaintScreenMainState();
}

class _ComplaintScreenMainState extends State<ComplaintScreenMain> {
  int _selectedIndex = 0;
  String selectedTab = "unassigned";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        title: const Text(
          'RCET Complaint Box',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A4B),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    toggleButton("Unassigned", selectedTab == "unassigned"),
                    toggleButton("Assigned", selectedTab == "assigned"),
                    toggleButton("Resolved", selectedTab == "resolved"),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: _buildSelectedView(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomBar(
        selectedIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          switch (index) {
            case 0:
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

  Widget _buildSelectedView() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('complaints').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final docs = snapshot.data!.docs;
        final allComplaints = docs
            .map((doc) => Complaint.fromFirestore(
                doc.data() as Map<String, dynamic>, doc.id))
            .toList();

        List<Complaint> filteredComplaints;
        if (selectedTab == "unassigned") {
          filteredComplaints =
              allComplaints.where((c) => c.status == "unassigned").toList();
        } else if (selectedTab == "assigned") {
          filteredComplaints =
              allComplaints.where((c) => c.status == "assign").toList();
        } else {
          filteredComplaints =
              allComplaints.where((c) => c.status == "resolved").toList();
        }

        if (filteredComplaints.isEmpty) {
          return const Center(child: Text('No complaints found.'));
        }

        return ListView.builder(
          itemCount: filteredComplaints.length,
          itemBuilder: (context, index) {
            final complaint = filteredComplaints[index];
            return _buildComplaintCard(complaint);
          },
        );
      },
    );
  }

  Widget _buildComplaintCard(Complaint complaint) {
    final date = (complaint.updatedAt ?? complaint.createdAt ?? DateTime.now())
        .toString()
        .split(' ')
        .first;

    Color badgeColor;
    String badgeText;
    if (selectedTab == "unassigned") {
      badgeColor = Colors.blue;
      badgeText = "New";
    } else if (selectedTab == "assigned") {
      badgeColor = complaint.status == "assign" ? Colors.orange : Colors.red;
      badgeText = complaint.status == "assign" ? "In Progress" : "Pending";
    } else {
      badgeColor = Colors.green;
      badgeText = "Resolved";
    }

    return InkWell(
      onTap: selectedTab == "unassigned"
          ? () => _showAssignmentDialog(context, complaint)
          : null,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(complaint.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 4),
              Text(complaint.description),
              if (selectedTab == "assigned" || selectedTab == "resolved")
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      const Icon(Icons.person, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        "${complaint.assignedTo} - ${complaint.department}",
                        style:
                            const TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              if (selectedTab == "resolved" &&
                  complaint.resolutionNote.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle,
                          color: Colors.green, size: 16),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          complaint.resolutionNote,
                          style: const TextStyle(
                              fontSize: 13, color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: badgeColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      badgeText,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    selectedTab == "resolved" ? "Resolved on: $date" : date,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget toggleButton(String title, bool isActive) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedTab = title.toLowerCase();
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: isActive ? Colors.black : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showAssignmentDialog(BuildContext context, Complaint complaint) {
    String? selectedDepartment =
        complaint.department.isNotEmpty ? complaint.department : null;
    String? selectedEmployee;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Assign Complaint'),
              content: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 320),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Complaint: ${complaint.title}',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text(complaint.description),
                      const SizedBox(height: 16),
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('departments')
                            .snapshots(),
                        builder: (context, deptSnapshot) {
                          if (!deptSnapshot.hasData) {
                            return const CircularProgressIndicator();
                          }
                          final departments = deptSnapshot.data!.docs
                              .map((d) => d['departmentname'] as String)
                              .toList();
                          return DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                                labelText: 'Select Department',
                                border: OutlineInputBorder()),
                            value: selectedDepartment,
                            items: departments.map((department) {
                              return DropdownMenuItem<String>(
                                value: department,
                                child: Text(department),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedDepartment = newValue;
                                selectedEmployee = null;
                              });
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      if (selectedDepartment != null)
                        StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('employees')
                              .where('department',
                                  isEqualTo: selectedDepartment)
                              .snapshots(),
                          builder: (context, empSnapshot) {
                            if (!empSnapshot.hasData) {
                              return const CircularProgressIndicator();
                            }
                            final employees = empSnapshot.data!.docs
                                .map((e) => e['name'] as String)
                                .toList();
                            return DropdownButtonFormField<String>(
                              decoration: const InputDecoration(
                                  labelText: 'Select Employee',
                                  border: OutlineInputBorder()),
                              value: selectedEmployee,
                              items: employees.map((employee) {
                                return DropdownMenuItem<String>(
                                  value: employee,
                                  child: Text(employee),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedEmployee = newValue;
                                });
                              },
                            );
                          },
                        ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: selectedDepartment != null &&
                          selectedEmployee != null
                      ? () async {
                          await FirebaseFirestore.instance
                              .collection('complaints')
                              .doc(complaint.id)
                              .update({
                            'department': selectedDepartment,
                            'assignedTo': selectedEmployee,
                            'status': 'assign',
                            'updatedAt': FieldValue.serverTimestamp(),
                          });
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Complaint assigned successfully!'),
                                backgroundColor: Colors.green),
                          );
                        }
                      : null,
                  child: const Text('Assign'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
