import 'package:flutter/material.dart';

class AppBackgound extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets margin;

  const AppBackgound({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.margin =
        const EdgeInsets.only(top: 25, bottom: 25, left: 25, right: 25),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
