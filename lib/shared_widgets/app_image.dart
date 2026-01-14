import 'package:flutter/material.dart';

class AppImage extends StatelessWidget {
  final String path;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final Widget? child;

  const AppImage({
    super.key,
    required this.path,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // ✅ SAFE FALLBACK LOGIC
        final double resolvedWidth =
            width ??
                (constraints.maxWidth.isFinite ? constraints.maxWidth : 40);

        final double resolvedHeight =
            height ??
                (constraints.maxHeight.isFinite ? constraints.maxHeight : 40);

        return ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.zero,
          child: SizedBox(
            width: resolvedWidth,
            height: resolvedHeight,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  path,
                  fit: fit,
                  errorBuilder: (_, __, ___) =>
                  const Icon(Icons.image_not_supported),
                ),
                if (child != null) child!,
              ],
            ),
          ),
        );
      },
    );
  }
}
