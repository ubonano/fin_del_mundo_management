import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:logging/logging.dart';
import '../../../../controllers/daily_income_controller.dart';
import '../../../../models/daily_income.dart';
import '../../../../setup/get_it_setup.dart';
import '../../../../setup/router.gr.dart';
import '../../../../utils/app_formaters.dart';
import '../../../widgets/app_dialog_confirm.dart';

class DailyIncomeTile extends StatefulWidget {
  final DailyIncome income;

  const DailyIncomeTile({Key? key, required this.income}) : super(key: key);

  @override
  State<DailyIncomeTile> createState() => _DailyIncomeTileState();
}

class _DailyIncomeTileState extends State<DailyIncomeTile> {
  final _logger = Logger('DailyIncomeTile');
  final _controller = getIt<DailyIncomeController>();

  StackRouter? get router => AutoRouter.of(context);

  @override
  void initState() {
    initializeDateFormatting('es_ES', null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _logger.info('Building DailyIncomeTile for income id: ${widget.income.id}');

    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 10),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: _buildIncomeInfo()),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: _generatePaymentMethodsWidgets(),
          ),
          _buildActionsButton(),
        ],
      ),
    );
  }

  Widget _buildIncomeInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '\$${AppFormaters.getFormattedTotal(widget.income.total)}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          AppFormaters.getFormattedDate(widget.income.date),
          style: const TextStyle(
            fontSize: 10.0,
          ),
        ),
      ],
    );
  }

  Widget _buildActionsButton() {
    return PopupMenuButton<int>(
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 0,
          child: ListTile(
            leading: Icon(Icons.edit),
            title: Text('Editar'),
          ),
        ),
        const PopupMenuItem(
          value: 1,
          child: ListTile(
            leading: Icon(Icons.delete, color: Colors.red),
            title: Text('Borrar', style: TextStyle(color: Colors.red)),
          ),
        ),
      ],
      onSelected: (value) {
        switch (value) {
          case 0:
            _onSelectEdit();
            break;
          case 1:
            _onSelectDelete();
            break;
        }
      },
      icon: const Icon(Icons.more_vert),
    );
  }

  void _onSelectEdit() {
    _logger
        .info('Edit button pressed for daily income:    ${widget.income.id}');
    router?.push(DailyIncomeFormRoute(income: widget.income));
  }

  void _deleteIncome() {
    _logger.info('Deleting daily income: ${widget.income.id}');
    try {
      _controller.delete(widget.income);
      router?.pop();
      _logger.info('Daily income deleted successfully');
    } catch (e) {
      _logger.severe('Error deleting daily income: ${e.toString()}');
      _showSnackbar('An error occurred');
    }
  }

  void _onSelectDelete() {
    _logger.info('Delete button pressed for daily income: ${widget.income.id}');
    AppDialogConfirm.showDeleteDialyIncome(
      context,
      onPressed: () => _deleteIncome(),
    );
  }

  List<Widget> _generatePaymentMethodsWidgets() {
    final totalPayment = widget.income.calculateTotal();
    return widget.income.paymentMethods.entries.map((entry) {
      final percentage =
          ((entry.value / totalPayment) * 100).toStringAsFixed(2);
      return Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _getPaymentMethodIcon(entry.key),
            _getPaymentMethodPercent(entry.key, percentage),
          ],
        ),
      );
    }).toList();
  }

  Text _getPaymentMethodPercent(String paymentMethod, String percentage) {
    TextStyle style;
    switch (paymentMethod) {
      case 'cash':
        style = const TextStyle(fontSize: 12, color: Colors.green);
        break;
      case 'cards':
        style = const TextStyle(fontSize: 12, color: Colors.orange);
        break;
      case 'mercadoPago':
        style = const TextStyle(fontSize: 12, color: Colors.blue);
        break;
      default:
        style = const TextStyle(fontSize: 12, color: Colors.grey);
        break;
    }

    return Text('($percentage%)', style: style);
  }

  Icon _getPaymentMethodIcon(String paymentMethod) {
    switch (paymentMethod) {
      case 'cash':
        return const Icon(Icons.wallet, size: 25, color: Colors.green);
      case 'cards':
        return const Icon(Icons.credit_card, size: 25, color: Colors.orange);
      case 'mercadoPago':
        return const Icon(Icons.handshake, size: 25, color: Colors.blue);
      default:
        return const Icon(Icons.payment, size: 25, color: Colors.grey);
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
