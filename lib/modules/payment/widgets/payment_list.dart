import 'package:auto_route/auto_route.dart';
import 'package:fin_del_mundo_management/widgets/app_stream_builder.dart';
import 'package:flutter/material.dart';
import '../../../setup/get_it_setup.dart';
import '../../../utils/app_formaters.dart';
import '../../../widgets/app_actions_buttons.dart';
import '../../../widgets/app_dialog_confirm.dart';
import '../payment.dart';
import '../payment_controller.dart';

class PaymentList extends StatefulWidget {
  const PaymentList({Key? key}) : super(key: key);

  @override
  State<PaymentList> createState() => _PaymentListState();
}

class _PaymentListState extends State<PaymentList> {
  final _controller = getIt<PaymentController>();

  StackRouter get router => AutoRouter.of(context);

  @override
  Widget build(BuildContext context) {
    return AppStreamBuilder<List<Payment>>(
      stream: _controller.$payments,
      onData: (incomes) {
        return Expanded(
          child: ListView.builder(
            itemCount: incomes.length,
            itemBuilder: (context, index) => PaymentTile(
              payment: incomes[index],
              onEdit: (payment) {},
              // onEdit: _onEdit,
              onDelete: _onDelete,
            ),
          ),
        );
      },
    );
  }

  // _onEdit(payment) => router.push(PaymentFormRoute(payment: payment));

  _onDelete(payment) {
    try {
      _controller.delete(payment);
      router.pop();
    } catch (e) {
      _showSnackbar('Ocurrio un error...');
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

class PaymentTile extends StatelessWidget {
  final Payment payment;
  final Function(Payment) onEdit;
  final Function(Payment) onDelete;

  const PaymentTile({
    Key? key,
    required this.payment,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 0.45,
            blurRadius: 6,
          ),
        ],
      ),
      child: _buildTile(context),
    );
  }

  Widget _buildTile(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildInfo(),
        const Spacer(),
        AppActionsButton(
          onEdit: () => onEdit(payment),
          onDelete: () => AppDialogConfirm.showDeleteDialyIncome(
            context,
            onPressed: () => onDelete(payment),
          ),
        ),
      ],
    );
  }

  Widget _buildInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '\$ ${AppFormaters.getFormattedTotal(payment.total)}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
        ),
        const SizedBox(height: 5),
        Text(
          AppFormaters.getFormattedDate(payment.date),
          style: const TextStyle(fontSize: 10.0),
        ),
      ],
    );
  }
}
