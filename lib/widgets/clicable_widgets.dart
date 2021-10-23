import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:innovers_exam/utils/styles.dart';

class Clickable extends StatelessWidget {
  const Clickable({
    Key? key,
    required this.child,
    required this.onPressed,
    this.borderRadius = Corners.smBorder,
    this.isAbleToPress = true,
  }) : super(key: key);

  final Widget child;

  final VoidCallback? onPressed;

  final bool isAbleToPress;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: borderRadius,
      onTap: onPressed,
      child: child,
    );
  }
}
