import 'package:flutter/material.dart';
import 'package:rcet_complaint/routes/app_routes.dart';
import '../../widgets/event_card.dart';
import '../../widgets/date_selector.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../../widgets/app_drawer.dart';

class EventScheduleScreen extends StatefulWidget {
  @override
  State<EventScheduleScreen> createState() => _EventScheduleScreenState();
}

class _EventScheduleScreenState extends State<EventScheduleScreen> {
  int _selectedIndex = 1; // Events tab is selected

  final List<Map<String, dynamic>> events = [
    {
      "id": 1,
      "title": "Maintenance of Hostel kitchen switch boards.",
      "time": "9:00 AM",
      "status": "green"
    },
    {"id": 2, "title": "Other Event", "time": "11:00 AM", "status": "red"},
    {
      "id": 3,
      "title": "Electrical Department Washroom",
      "time": "11:00 AM",
      "status": "green"
    },
    {"id": 4, "title": "Other Event", "time": "11:00 AM", "status": "red"},
    {"id": 5, "title": "Other Event", "time": "11:00 AM", "status": "red"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true, // This centers the title
        title: const Text(
          'Event Schedule',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: const AppDrawer(),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            const Text("2 events for today",
                style: TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 16),
            const DateSelector(),
            const SizedBox(height: 16),
            const Text("January",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Text("26.02.2025",
                style: TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: events.length,
                itemBuilder: (context, index) {
                  return EventCard(event: events[index]);
                },
              ),
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
              Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
              break;
            case 1:
              break; // Already on events
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
}
