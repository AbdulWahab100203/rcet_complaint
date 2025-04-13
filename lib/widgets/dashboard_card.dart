import 'package:flutter/material.dart';

// Dashboard Card Widget
class DashboardCard extends StatelessWidget {
  final String title;
  final String count;

  const DashboardCard({
    required this.title,
    required this.count,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        color: Colors.grey.shade400,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Text(count, style: const TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}

// Tab Button Widget
class TabButton extends StatelessWidget {
  final String title;
  final bool isActive;

  const TabButton({
    required this.title,
    required this.isActive,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF1A1A4B) : Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// Complaint Card Widget
class ComplaintCard extends StatelessWidget {
  final String id;
  final String title;

  const ComplaintCard({
    required this.id,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: ListTile(
        leading: Text(id,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        title: Text(title),
        trailing: TextButton(
          onPressed: () {
            // Handle complaint viewing logic
          },
          child: const Text("View", style: TextStyle(color: Colors.blue)),
        ),
      ),
    );
  }
}

// Main Complaint Screen
class ComplaintScreenMain extends StatelessWidget {
  final List<Map<String, String>> complaints = [
    {'id': '1', 'title': 'Complaint regarding boys hostels'},
    {'id': '2', 'title': 'Complaint regarding repair'},
    {'id': '3', 'title': 'Complaint regarding electricity'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),

            // Dashboard Summary
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  DashboardCard(title: "Complaint Box", count: "3"),
                  DashboardCard(title: "Complaints", count: "99"),
                  DashboardCard(title: "Resolved Complaints", count: "56"),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Tabs for Switching Complaints
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: const [
                    Expanded(
                        child: TabButton(
                            title: "Solved Complaints", isActive: true)),
                    Expanded(
                        child: TabButton(
                            title: "Unresolved Complaints", isActive: false)),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Complaints List
            Expanded(
              child: ListView.builder(
                itemCount: complaints.length,
                itemBuilder: (context, index) {
                  return ComplaintCard(
                    id: complaints[index]['id']!,
                    title: complaints[index]['title']!,
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle adding new complaint
        },
        backgroundColor: Colors.yellow.shade700,
        child: const Icon(Icons.add, color: Colors.black),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // Set selected index
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle, size: 40), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
        ],
      ),
    );
  }
}
