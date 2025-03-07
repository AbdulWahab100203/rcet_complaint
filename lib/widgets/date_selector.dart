import 'package:flutter/material.dart';

class DateSelector extends StatelessWidget {
  const DateSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(6, (index) {
        return DateItem(
          date: (8 + index).toString(),
          day: ["Mo", "Tu", "We", "Th", "Fr", "Sa"][index],
          isSelected: index == 0, // Select the first date by default
        );
      }),
    );
  }
}

class DateItem extends StatelessWidget {
  final String date;
  final String day;
  final bool isSelected;

  const DateItem({
    super.key,
    required this.date,
    required this.day,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: isSelected ? Colors.black : Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            date,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
          Text(
            day,
            style: TextStyle(
              fontSize: 14,
              color: isSelected ? Colors.white : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
