import 'package:flutter/material.dart';

class AppIcons extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color iconColor;
  final Color borderColor;
  final double size;

  const AppIcons({
    super.key,
    required this.icon,
    required this.onTap,
    this.iconColor = Colors.black87,
    this.borderColor = Colors.black87,
    this.size = 50,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          size: size * 0.6,
          color: iconColor,
        ),
      ),
    );
  }
}
