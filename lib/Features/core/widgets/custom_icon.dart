import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final double size;
  final Color color;

  final EdgeInsets padding;
  final VoidCallback onPressed;

  const CustomIconButton({
    Key? key,
    required this.icon,
    this.size = 24.0,
    this.color = Colors.white,
    // this.backgroundColor = Colors.blue,
    this.padding = const EdgeInsets.all(8.0),
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          // color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: size,
          color: color,
        ),
      ),
    );
  }
}
