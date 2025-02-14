import 'package:flutter/material.dart';

class DynamicFloatingButton extends StatelessWidget {
  final String labelText;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  const DynamicFloatingButton({
    super.key,
    required this.labelText,
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      label: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 8),
          Text(labelText, style: const TextStyle(color: Colors.white)),
        ],
      ),
      backgroundColor: color,
      onPressed: onPressed,
    );
  }
}
