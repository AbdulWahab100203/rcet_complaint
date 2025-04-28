import 'package:flutter/material.dart';
import 'package:rcet_complaint/widgets/app_drawer.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../../widgets/complaint_box.dart';
import '../../widgets/primary_button.dart';
import '../../routes/app_routes.dart';
import 'dart:math' as math;

class ComplaintScreen extends StatefulWidget {
  @override
  State<ComplaintScreen> createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  int _selectedIndex = 3;

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
                        children: const [
                          Text(
                            '3',
                            style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            'Total 34 Complaints',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 25),
              child: PrimaryButton(
                text: 'Create Complaint Box',
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.addComplaintBox);
                },
                backgroundColor: Colors.white,
                textColor: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            // ✅ No Expanded, no ListView here
            const ComplaintBox(
              title: "Computer Science Department",
              total: 114,
              solved: 90,
              remaining: 24,
              icon: Icons.computer,
              progressColor: Colors.orange,
            ),
            const ComplaintBox(
              title: "Mechanical Department",
              total: 56,
              solved: 50,
              remaining: 6,
              icon: Icons.settings,
              progressColor: Colors.purple,
            ),
            const ComplaintBox(
              title: "Electrical Department",
              total: 56,
              solved: 50,
              remaining: 6,
              icon: Icons.settings,
              progressColor: Colors.purple,
            ),
            const ComplaintBox(
              title: "Boys Hostel A",
              total: 64,
              solved: 23,
              remaining: 41,
              icon: Icons.home,
              progressColor: Colors.cyan,
            ),
            const ComplaintBox(
              title: "Boys Hostel B",
              total: 64,
              solved: 23,
              remaining: 41,
              icon: Icons.home,
              progressColor: Color.fromARGB(255, 77, 112, 73),
            ),
            const ComplaintBox(
              title: "Boys Hostel C",
              total: 64,
              solved: 23,
              remaining: 41,
              icon: Icons.home,
              progressColor: Color.fromARGB(255, 108, 90, 169),
            ),
            const ComplaintBox(
              title: "Girls Hostel",
              total: 64,
              solved: 23,
              remaining: 41,
              icon: Icons.home,
              progressColor: Colors.cyan,
            ),
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
