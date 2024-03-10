import 'package:flutter/material.dart';


class RoundedContainer extends StatelessWidget {
  const RoundedContainer({super.key, this.width, this.heigth, required this.radius, this.child, required this.showBorder, required this.borderColor, required this.backgroundColor, this.padding, this.margin});

  final double? width;
  final double? heigth;
  final double radius;
  final Widget? child;
  final bool showBorder;
  final Color borderColor;
  final Color backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: heigth,
      padding: padding,
      margin:margin,
      decoration: BoxDecoration(
        color:backgroundColor,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color:borderColor)
      ),
      child : child

    );
  }
}
