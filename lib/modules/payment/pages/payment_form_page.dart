import 'package:auto_route/auto_route.dart';
import 'package:fin_del_mundo_management/widgets/app_background.dart';
import 'package:flutter/material.dart';

import '../payment.dart';
import '../widgets/payment_form.dart';

@RoutePage()
class PaymentFormPage extends StatelessWidget {
  final Payment? payment;

  const PaymentFormPage({Key? key, this.payment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          payment == null ? 'Registrar gasto' : 'Actualizar gasto',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 400, vertical: 150),
        child: AppBackgound(child: PaymentForm(payment: payment)),
      ),
    );
  }
}
