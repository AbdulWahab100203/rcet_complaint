import 'package:flutter/material.dart';
import 'package:rcet_complaint/widgets/app_drawer.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../../routes/app_routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/complaint.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ComplaintScreenMain extends StatefulWidget {
  const ComplaintScreenMain({Key? key}) : super(key: key);

  @override
  State<ComplaintScreenMain> createState() => _ComplaintScreenMainState();
}

class _ComplaintScreenMainState extends State<ComplaintScreenMain> {
  int _selectedIndex = 0;
  String selectedTab = "unassigned";
  String? userName;
  bool isLoadingUser = true;

  @override
  void initState() {
    super.initState();
    fetchUserName();
  }

  Future<void> fetchUserName() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance
          .collection('User')
          .doc(user.uid)
          .get();
      setState(() {
        userName = doc.data()?['username'] ?? 'User';
        isLoadingUser = false;
      });
    } else {
      setState(() {
        userName = 'User';
        isLoadingUser = false;
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
            isLoadingUser
                ? const SizedBox(
                    height: 80,
                    child: Center(child: CircularProgressIndicator()))
                : AnimatedWelcomeHeader(userName: userName ?? 'User'),
            const SizedBox(height: 10),
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
          padding: const EdgeInsets.symmetric(vertical: 9),
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

    final List<String> departments = [
      'Plumber',
      'Electrician',
      'Sweeper',
      'Carpenter',
      'Painter',
      'IT',
    ];

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
                      DropdownButtonFormField<String>(
                        isExpanded: true,
                        decoration: const InputDecoration(
                            labelText: 'Select Department',
                            border: OutlineInputBorder()),
                        value: departments.contains(selectedDepartment)
                            ? selectedDepartment
                            : null,
                        items: departments.map((department) {
                          return DropdownMenuItem<String>(
                            value: department,
                            child: Text(
                              department,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                            ),
                          );
                        }).toList(),
                        selectedItemBuilder: (context) {
                          return departments.map((department) {
                            return Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                department,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                              ),
                            );
                          }).toList();
                        },
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedDepartment = newValue;
                            selectedEmployee = null;
                          });
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
                            print('Selected department: $selectedDepartment');
                            print('Employees: $employees');
                            if (employees.isEmpty) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                setState(() {
                                  selectedEmployee = null;
                                });
                              });
                              return DropdownButtonFormField<String>(
                                isExpanded: true,
                                decoration: const InputDecoration(
                                    labelText: 'Select Employee',
                                    border: OutlineInputBorder()),
                                items: [
                                  DropdownMenuItem<String>(
                                    value: null,
                                    child: Text('No employees found',
                                        style: TextStyle(color: Colors.grey)),
                                    enabled: false,
                                  ),
                                ],
                                onChanged: null,
                              );
                            }
                            return DropdownButtonFormField<String>(
                              isExpanded: true,
                              decoration: const InputDecoration(
                                  labelText: 'Select Employee',
                                  border: OutlineInputBorder()),
                              value: employees.contains(selectedEmployee)
                                  ? selectedEmployee
                                  : null,
                              items: employees.map((employee) {
                                return DropdownMenuItem<String>(
                                  value: employee,
                                  child: Text(
                                    employee,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                  ),
                                );
                              }).toList(),
                              selectedItemBuilder: (context) {
                                return employees.map((employee) {
                                  return Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      employee,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                    ),
                                  );
                                }).toList();
                              },
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

class AnimatedWelcomeHeader extends StatefulWidget {
  final String userName;
  final String? profileImageUrl; // Optional

  const AnimatedWelcomeHeader(
      {Key? key, required this.userName, this.profileImageUrl})
      : super(key: key);

  @override
  State<AnimatedWelcomeHeader> createState() => _AnimatedWelcomeHeaderState();
}

class _AnimatedWelcomeHeaderState extends State<AnimatedWelcomeHeader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _slideAnimation = Tween<Offset>(
            begin: const Offset(0, 0.2), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Container(
          margin: const EdgeInsets.all(18),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: const LinearGradient(
              colors: [Color(0xFF1A1A4B), Color(0xFF3A3A8B)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 32,
                backgroundColor: Colors.white,
                backgroundImage: widget.profileImageUrl != null
                    ? NetworkImage(widget.profileImageUrl!)
                    : null,
                child: widget.profileImageUrl == null
                    ? const Icon(Icons.person,
                        size: 36, color: Color(0xFF1A1A4B))
                    : null,
              ),
              const SizedBox(width: 18),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome back,',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.userName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.1,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
