import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextAlign? align;
  final int? maxLines;
  final TextOverflow? overflow;

  const AppText(
      this.text, {
        super.key,
        required this.style,
        this.align,
        this.maxLines,
        this.overflow,
      });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style.copyWith(
        color: style.color ?? Theme.of(context).textTheme.bodyMedium?.color,
      ),
      textAlign: align,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
