import 'package:flutter/material.dart';
import '../routes/app_routes.dart';

class MenuFabButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const MenuFabButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.amber,
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed ??
              () => Navigator.pushNamed(context, AppRoutes.newComplaint),
          customBorder: const CircleBorder(),
          child: const Center(
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }
}
