import 'package:flutter/material.dart';

class CarouselIndicator extends StatelessWidget {
  final int itemCount;
  final int currentIndex;

  final Color activeColor;
  final Color inactiveColor;

  final double activeWidth;
  final double activeHeight;

  final double inactiveWidth;
  final double inactiveHeight;

  final double spacing;

  final Color activeBorderColor;
  final double activeBorderWidth;
  final Color inactiveBorderColor;
  final double inactiveBorderWidth;

  const CarouselIndicator({
    super.key,
    required this.itemCount,
    required this.currentIndex,
    this.activeColor = Colors.black,
    this.inactiveColor = Colors.grey,
    this.activeWidth = 20.0,
    this.activeHeight = 5.0,
    this.inactiveWidth = 10.0,
    this.inactiveHeight = 5.0,
    this.spacing = 8.0,
    this.activeBorderColor = Colors.transparent,
    this.activeBorderWidth = 0.0,
    this.inactiveBorderColor = Colors.transparent,
    this.inactiveBorderWidth = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(itemCount, (index) {
        bool isActive = index == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: spacing / 2),
          width: isActive ? activeWidth : inactiveWidth,
          height: isActive ? activeHeight : inactiveHeight,
          decoration: BoxDecoration(
            color: isActive ? activeColor : inactiveColor,
            borderRadius: BorderRadius.circular(
              (isActive ? activeHeight : inactiveHeight) / 2,
            ),
            border: Border.all(
              color: isActive ? activeBorderColor : inactiveBorderColor,
              width: isActive ? activeBorderWidth : inactiveBorderWidth,
            ),
          ),
        );
      }),
    );
  }
}