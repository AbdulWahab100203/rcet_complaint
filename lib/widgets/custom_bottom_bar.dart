import 'package:flutter/material.dart';
import '../routes/app_routes.dart';
import 'menu_fab_button.dart';

class CustomBottomBar extends StatelessWidget {
  final int selectedIndex;

  const CustomBottomBar({
    super.key,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      // margin: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(left: 2, right: 2),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A4B),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(
            context,
            icon: Icons.home_outlined,
            isSelected: selectedIndex == 0,
            onTap: () =>
                Navigator.pushReplacementNamed(context, AppRoutes.dashboard),
          ),
          _buildNavItem(
            context,
            icon: Icons.grid_view,
            isSelected: selectedIndex == 1,
            onTap: () {},
          ),
          const MenuFabButton(),
          _buildNavItem(
            context,
            icon: Icons.calendar_today,
            isSelected: selectedIndex == 2,
            onTap: () {},
          ),
          _buildNavItem(
            context,
            icon: Icons.settings,
            isSelected: selectedIndex == 3,
            onTap: () =>
                Navigator.pushReplacementNamed(context, AppRoutes.setting),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        icon,
        // ignore: deprecated_member_use
        color: isSelected ? Colors.white : Colors.white.withOpacity(0.5),
        size: 24,
      ),
    );
  }
}
