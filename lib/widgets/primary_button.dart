import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent, // Transparent to show boxShadow effect
      borderRadius: BorderRadius.circular(25),
      child: InkWell(
        onTap: !isLoading ? onPressed : null,
        borderRadius: BorderRadius.circular(25),
        child: Container(
          height: 48,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: backgroundColor ?? const Color(0xFF1A1A4B),
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3), // Shadow color
                blurRadius: 8, // Blur effect
                spreadRadius: 1, // Spread radius
                offset: const Offset(0, 4), // Vertical shadow
              ),
            ],
          ),
          child:
              // isLoading
              //     ? const SizedBox(
              //         height: 24,
              //         width: 24,
              //         child: CircularProgressIndicator(
              //           color: Colors.white,
              //           strokeWidth: 3,
              //         ),
              //       ):
              Text(
            text,
            style: TextStyle(
              color: textColor ?? Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
