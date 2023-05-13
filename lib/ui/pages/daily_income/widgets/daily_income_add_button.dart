import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../../setup/router.gr.dart';

class DailyIncomeAddButton extends StatelessWidget {
  const DailyIncomeAddButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);

    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () => router.push(DailyIncomeFormRoute()),
    );
  }
}
