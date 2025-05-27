import 'package:flutter/material.dart';
import 'package:rcet_complaint/routes/app_routes.dart';
import '../../widgets/event_card.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../../widgets/app_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/complaint.dart';
import 'package:rcet_complaint/screens/dashboard/ComplaintDetailScreen.dart';

class EventScheduleScreen extends StatefulWidget {
  @override
  State<EventScheduleScreen> createState() => _EventScheduleScreenState();
}

class _EventScheduleScreenState extends State<EventScheduleScreen> {
  int _selectedIndex = 1;
  late String _selectedDay;
  late String _selectedMonth;
  late final DateTime _currentDate;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _currentDate = DateTime.now();
    _selectedMonth = months[_currentDate.month - 1];
    _selectedDay = _currentDate.day.toString().padLeft(2, '0');
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final todayIndex = _currentDate.day - 1;
      _scrollController.jumpTo(todayIndex * 63.0);
    });
  }

  List<Map<String, String>> get days {
    final DateTime firstDayOfMonth =
        DateTime(_currentDate.year, months.indexOf(_selectedMonth) + 1, 1);
    final int daysInMonth =
        DateTime(_currentDate.year, months.indexOf(_selectedMonth) + 2, 0).day;
    final List<Map<String, String>> result = [];

    for (int i = 0; i < daysInMonth; i++) {
      final date = firstDayOfMonth.add(Duration(days: i));
      result.add({
        'day': date.day.toString().padLeft(2, '0'),
        'weekday': _getWeekdayShort(date.weekday),
      });
    }
    return result;
  }

  String _getWeekdayShort(int weekday) {
    switch (weekday) {
      case 1:
        return 'Mo';
      case 2:
        return 'Tu';
      case 3:
        return 'We';
      case 4:
        return 'Th';
      case 5:
        return 'Fr';
      case 6:
        return 'Sa';
      case 7:
        return 'Su';
      default:
        return '';
    }
  }

  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Timeline Schedule',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      drawer: const AppDrawer(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Event Schedule',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedMonth,
                        isDense: true,
                        icon: Icon(Icons.keyboard_arrow_down,
                            color: Colors.grey[600], size: 20),
                        items: months.map((String month) {
                          return DropdownMenuItem<String>(
                            value: month,
                            child: Text(
                              month,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[800],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              _selectedMonth = newValue;
                              if (_selectedMonth ==
                                  months[_currentDate.month - 1]) {
                                _selectedDay =
                                    _currentDate.day.toString().padLeft(2, '0');
                              } else {
                                final firstDay = days.first['day'];
                                if (firstDay != null) {
                                  _selectedDay = firstDay;
                                }
                              }
                            });
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Event count and filtering
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('complaints')
                    .where('status', isEqualTo: 'resolved')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Text('0 events for today',
                        style: TextStyle(fontSize: 16));
                  }
                  final docs = snapshot.data!.docs;
                  final allComplaints = docs
                      .map((doc) => Complaint.fromFirestore(
                          doc.data() as Map<String, dynamic>, doc.id))
                      .toList();
                  final filteredComplaints = allComplaints.where((complaint) {
                    final date = complaint.updatedAt ??
                        complaint.createdAt ??
                        DateTime.now();
                    final monthMatch =
                        date.month == (months.indexOf(_selectedMonth) + 1);
                    final dayMatch =
                        date.day.toString().padLeft(2, '0') == _selectedDay;
                    return monthMatch && dayMatch;
                  }).toList();
                  return Text(
                    '${filteredComplaints.length} events for today',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 80,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: days.length,
                itemBuilder: (context, index) {
                  final day = days[index];
                  final isSelected = day['day'] == _selectedDay;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedDay = day['day'] ?? '';
                      });
                    },
                    child: Container(
                      width: 55,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF1A1A4B)
                            : const Color(0xFFEEEEEE),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            day['day'] ?? '',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            day['weekday'] ?? '',
                            style: TextStyle(
                              fontSize: 14,
                              color: isSelected
                                  ? Colors.white.withOpacity(0.8)
                                  : Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          if (isSelected)
                            Container(
                              margin: const EdgeInsets.only(top: 6),
                              width: 4,
                              height: 4,
                              decoration: BoxDecoration(
                                color: Colors.orange[400],
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('complaints')
                    .where('status', isEqualTo: 'resolved')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final docs = snapshot.data!.docs;
                  final allComplaints = docs
                      .map((doc) => Complaint.fromFirestore(
                          doc.data() as Map<String, dynamic>, doc.id))
                      .toList();
                  final filteredComplaints = allComplaints.where((complaint) {
                    final date = complaint.updatedAt ??
                        complaint.createdAt ??
                        DateTime.now();
                    final monthMatch =
                        date.month == (months.indexOf(_selectedMonth) + 1);
                    final dayMatch =
                        date.day.toString().padLeft(2, '0') == _selectedDay;
                    return monthMatch && dayMatch;
                  }).toList();
                  if (filteredComplaints.isEmpty) {
                    return const Center(
                        child: Text('No resolved complaints for this day.'));
                  }
                  return ListView.builder(
                    itemCount: filteredComplaints.length,
                    itemBuilder: (context, index) {
                      final complaint = filteredComplaints[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ComplaintDetailScreen(
                                id: complaint.id,
                                title: complaint.title,
                              ),
                            ),
                          );
                        },
                        child: EventCard(
                          event: {
                            "id": index + 1,
                            "title": complaint.title,
                            "time": (complaint.updatedAt ??
                                    complaint.createdAt ??
                                    DateTime.now())
                                .toString()
                                .substring(11, 16),
                            "status": "green",
                            "description": complaint.description,
                          },
                        ),
                      );
                    },
                  );
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
              Navigator.pushReplacementNamed(context, AppRoutes.mainDashboard);
              break;
            case 1:
              // Already on event screen
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
}
