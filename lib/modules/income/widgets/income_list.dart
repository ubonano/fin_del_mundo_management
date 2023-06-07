import 'package:auto_route/auto_route.dart';
import 'package:fin_del_mundo_management/widgets/app_stream_builder.dart';
import 'package:flutter/material.dart';
import '../../../setup/get_it_setup.dart';
import '../../../setup/router.gr.dart';
import '../../../utils/app_formaters.dart';
import '../../../widgets/app_actions_buttons.dart';
import '../../../widgets/app_dialog_confirm.dart';
import '../income.dart';
import '../income_controller.dart';

class IncomeList extends StatefulWidget {
  const IncomeList({Key? key}) : super(key: key);

  @override
  State<IncomeList> createState() => _IncomeListState();
}

class _IncomeListState extends State<IncomeList> {
  final _controller = getIt<IncomeController>();

  StackRouter get router => AutoRouter.of(context);

  @override
  Widget build(BuildContext context) {
    return AppStreamBuilder<List<Income>>(
      stream: _controller.$incomes,
      onData: (incomes) {
        return Expanded(
          child: ListView.builder(
            itemCount: incomes.length,
            itemBuilder: (context, index) => IncomeTile(
              income: incomes[index],
              onEdit: _onEdit,
              onDelete: _onDelete,
            ),
          ),
        );
      },
    );
  }

  _onEdit(income) => router.push(IncomeFormRoute(income: income));

  _onDelete(income) {
    try {
      _controller.delete(income);
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

class IncomeTile extends StatelessWidget {
  final Income income;
  final Function(Income) onEdit;
  final Function(Income) onDelete;

  const IncomeTile({
    Key? key,
    required this.income,
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
        _buildCollectionMethodDetail(),
        AppActionsButton(
          onEdit: () => onEdit(income),
          onDelete: () => AppDialogConfirm.showDeleteDialyIncome(
            context,
            onPressed: () => onDelete(income),
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
          '\$ ${AppFormaters.getFormattedTotal(income.total)}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
        ),
        const SizedBox(height: 5),
        Text(
          AppFormaters.getFormattedDate(income.date),
          style: const TextStyle(fontSize: 10.0),
        ),
      ],
    );
  }

  Widget _buildCollectionMethodDetail() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: income.incomeItems.map(
        (entry) {
          final percentage =
              ((entry.amount / income.total) * 100).toStringAsFixed(2);

          return Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  entry.getIcon(),
                  size: 25,
                  color: entry.getColor(),
                ),
                Text(
                  '($percentage%)',
                  style: TextStyle(
                    fontSize: 12,
                    color: entry.getColor(),
                  ),
                ),
              ],
            ),
          );
        },
      ).toList(),
    );
  }
}
