import 'package:flutter/material.dart';

class CustomIconWidget extends StatelessWidget {
  final IconData? icon;
  final double? size;
  final Color? color;

  const CustomIconWidget({
    Key? key,
    this.icon,
    this.size,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: size ?? 24.0,
      color: color,
    );
  }
}
