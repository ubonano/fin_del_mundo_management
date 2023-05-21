import 'package:flutter/material.dart';

class AppBackgound extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final double? width, height;

  const AppBackgound({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.margin =
        const EdgeInsets.only(top: 25, bottom: 25, left: 25, right: 25),
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
