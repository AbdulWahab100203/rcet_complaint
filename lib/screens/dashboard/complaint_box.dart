import 'package:flutter/material.dart';
import 'package:rcet_complaint/widgets/app_drawer.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../../widgets/complaint_box.dart';
import '../../widgets/primary_button.dart';
import '../../routes/app_routes.dart';
import 'dart:math' as math;
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/department_complaint_stats.dart';

class ComplaintScreen extends StatefulWidget {
  @override
  State<ComplaintScreen> createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  int _selectedIndex = 3;

  Stream<List<String>> departmentStream() {
    return FirebaseFirestore.instance.collection('departments').snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => doc['departmentname'] as String)
            .toList());
  }

  Widget _buildComplaintBoxes() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('complaints').snapshots(),
      builder: (context, complaintSnapshot) {
        if (!complaintSnapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final complaintDocs = complaintSnapshot.data!.docs;

        return StreamBuilder<List<String>>(
          stream: departmentStream(),
          builder: (context, deptSnapshot) {
            if (!deptSnapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final departments = deptSnapshot.data!;
            return Column(
              children: departments.map((deptName) {
                final complaints = complaintDocs
                    .where((doc) =>
                        (doc.data() as Map<String, dynamic>)['department'] ==
                        deptName)
                    .toList();
                final total = complaints.length;
                final solved = complaints
                    .where((doc) =>
                        (doc.data() as Map<String, dynamic>)['status'] ==
                        'resolved')
                    .length;
                final remaining = total - solved;
                final stats = DepartmentComplaintStats(
                  departmentName: deptName,
                  total: total,
                  solved: solved,
                  remaining: remaining,
                );
                // Assign icon/color based on department name or use default
                IconData icon = Icons.apartment;
                Color color = Colors.orange;
                if (deptName.toLowerCase().contains('computer')) {
                  icon = Icons.computer;
                  color = Colors.orange;
                } else if (deptName.toLowerCase().contains('mechanical')) {
                  icon = Icons.settings;
                  color = Colors.purple;
                } else if (deptName.toLowerCase().contains('electrical')) {
                  icon = Icons.settings;
                  color = Colors.purple;
                } else if (deptName.toLowerCase().contains('hostel')) {
                  icon = Icons.home;
                  color = Colors.cyan;
                }
                return ComplaintBox(
                  stats: stats,
                  icon: icon,
                  progressColor: color,
                );
              }).toList(),
            );
          },
        );
      },
    );
  }

  Widget _buildTotalComplaintsArc() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('complaints').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox(
            width: 200,
            height: 200,
            child: Center(child: CircularProgressIndicator()),
          );
        }
        final docs = snapshot.data!.docs;
        final total = docs.length;
        final solved = docs.where((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return data['status'] == 'resolved';
        }).length;
        final remaining = total - solved;
        return Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: CustomPaint(
                    painter: CircularArcPainter(
                      colors: [
                        Colors.tealAccent,
                        Colors.orangeAccent,
                        Colors.purpleAccent,
                        Colors.grey.shade400,
                      ],
                      strokeWidth: 12,
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      total.toString(),
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      'Total $total Complaints',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      '$solved Solved, $remaining left',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<void> _showCreateComplaintBoxDialog(BuildContext context) async {
    final controller = TextEditingController();
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Complaint Box'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: 'Department Name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              final name = controller.text.trim();
              if (name.isNotEmpty) {
                await FirebaseFirestore.instance.collection('departments').add({
                  'departmentname': name,
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
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
          'Complaint Box',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: const AppDrawer(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Column(
                children: [
                  _buildTotalComplaintsArc(),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 0),
              child: PrimaryButton(
                text: 'Create Complaint Box',
                onPressed: () => _showCreateComplaintBoxDialog(context),
                backgroundColor: Colors.white,
                textColor: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            _buildComplaintBoxes(),
            const SizedBox(height: 16),
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
              Navigator.pushReplacementNamed(context, AppRoutes.mainDashboard);
              break;
            case 1:
              Navigator.pushReplacementNamed(context, AppRoutes.event);
              break;
            case 2:
              Navigator.pushNamed(context, AppRoutes.addComplaintBox);
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

class CircularArcPainter extends CustomPainter {
  final List<Color> colors;
  final double strokeWidth;

  CircularArcPainter({
    required this.colors,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final totalAngle = 210 * (math.pi / 180);
    final startAngle = -195 * (math.pi / 180);

    final segmentCount = colors.length;
    final segmentAngle = totalAngle / segmentCount;

    for (var i = 0; i < segmentCount; i++) {
      final paint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      final segmentStart = startAngle + (i * segmentAngle);

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        segmentStart,
        segmentAngle - (2 * math.pi / 180),
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
