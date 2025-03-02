import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  final String icon;
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color? textColor;

  const SignInButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onPressed,
    required this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(icon, height: 24),
          const SizedBox(width: 12),
          Text(
            text,
            style: TextStyle(
              color: textColor ?? Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
