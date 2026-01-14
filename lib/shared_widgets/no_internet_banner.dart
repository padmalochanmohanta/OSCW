import 'package:flutter/material.dart';

class NoInternetBanner extends StatelessWidget {
  final bool visible;
  final String message;

  const NoInternetBanner({
    super.key,
    required this.visible,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      height: visible ? 45 : 0, // Slide effect
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.red.shade700,
        boxShadow: [
          if (visible)
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 3),
            )
        ],
      ),
      child: visible
          ? Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      )
          : null,
    );
  }
}
