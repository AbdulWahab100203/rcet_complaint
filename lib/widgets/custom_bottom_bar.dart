import 'package:flutter/material.dart';

class CustomBottomBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const CustomBottomBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      backgroundColor: const Color(0xFF1A1A4B),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.event),
          label: 'Events',
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                color: Colors.amber,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ),
          label: '',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.message),
          label: 'Complaints',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
