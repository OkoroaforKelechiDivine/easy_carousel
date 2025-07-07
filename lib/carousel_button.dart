import 'package:flutter/material.dart';

class CarouselButton extends StatelessWidget {
  final String text;
  final Widget? icon;
  final VoidCallback onPressed;
  final TextStyle? textStyle;
  final Color backgroundColor;
  final EdgeInsetsGeometry padding;
  final double borderRadius;

  const CarouselButton({
    super.key,
    required this.text,
    this.icon,
    required this.onPressed,
    this.textStyle,
    this.backgroundColor = Colors.black,
    this.padding = const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];

    children.add(
      Text(
        text,
        style: textStyle ?? const TextStyle(color: Colors.white, fontSize: 14),
      ),
    );

    if (icon != null) {
      children.add(const SizedBox(width: 8));
      children.add(icon!);
    }

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }
}
