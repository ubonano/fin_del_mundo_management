import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../controllers/daily_income_controller.dart';
import '../../../models/daily_income.dart';
import '../../../setup/get_it_setup.dart';

@RoutePage()
class DailyIncomeFormPage extends StatefulWidget {
  final DailyIncome? income;

  const DailyIncomeFormPage({Key? key, this.income}) : super(key: key);

  @override
  _DailyIncomeFormPageState createState() => _DailyIncomeFormPageState();
}

class _DailyIncomeFormPageState extends State<DailyIncomeFormPage> {
  final _controller = getIt<DailyIncomeController>();

  final _formKey = GlobalKey<FormState>();

  // Initialize your form fields here...

  @override
  void initState() {
    super.initState();
    if (widget.income != null) {
      // Populate your form fields with widget.income data...
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ingreso diario')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            // Add your form fields here...
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            // Save and add or update income...
          }
        },
      ),
    );
  }
}
