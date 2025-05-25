import 'package:flutter/material.dart';
import 'package:rcet_complaint/widgets/app_drawer.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../../routes/app_routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/complaint.dart';

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

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(complaint.title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
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
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
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
                        style:
                            const TextStyle(fontSize: 13, color: Colors.green),
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
}
