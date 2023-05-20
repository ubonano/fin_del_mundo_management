import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../../../setup/router.gr.dart';

class DailyIncomeAddButton extends StatelessWidget {
  const DailyIncomeAddButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);

    return ElevatedButton.icon(
      onPressed: () => router.push(DailyIncomeFormRoute()),
      icon: const Icon(Icons.add, color: Colors.white, size: 18),
      label: const Text(
        'Nuevo ingreso',
        style: TextStyle(color: Colors.white, fontSize: 14),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff5E27FA),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
    );
  }
}
