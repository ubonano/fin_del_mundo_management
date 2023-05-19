import 'package:flutter/material.dart';

class AppBackgound extends StatelessWidget {
  final Widget child;

  const AppBackgound({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(top: 25, bottom: 25, left: 25, right: 25),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: child,
      ),
    );
  }
}
