import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  final String path;
  final double size;
  final Color? color;

  const AppIcon({
    super.key,
    required this.path,
    this.size = 24,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path,
      height: size,
      width: size,
      color: color,
    );
  }
}
