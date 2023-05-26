import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class AppDialogConfirm extends StatefulWidget {
  final String title;
  final String content;
  final void Function()? onPressed;

  const AppDialogConfirm({
    Key? key,
    required this.onPressed,
    required this.title,
    required this.content,
  }) : super(key: key);

  static Future<void> showDeleteDialyIncome(
    BuildContext context, {
    required void Function()? onPressed,
  }) async {
    await showDialog<bool>(
      context: context,
      builder: (context) {
        return AppDialogConfirm(
          title: 'Borrar ingreso diario',
          content: '¿Esta seguro que desea eliminar este ingreso diario?',
          onPressed: onPressed,
        );
      },
    );
  }

  @override
  State<AppDialogConfirm> createState() => _AppDialogConfirmState();
}

class _AppDialogConfirmState extends State<AppDialogConfirm> {
  late StackRouter? router;

  @override
  Widget build(BuildContext context) {
    router = AutoRouter.of(context);
    return _buildAlertDialog();
  }

  Widget _buildAlertDialog() {
    return AlertDialog(
      title: Text(widget.title),
      content: Text(widget.content),
      actions: [
        _buildCancelButton(),
        _buildConfirmButton(),
      ],
    );
  }

  Widget _buildCancelButton() {
    return TextButton(
      child: const Text('Cancelar'),
      onPressed: () => router?.pop(false),
    );
  }

  Widget _buildConfirmButton() {
    return TextButton(
      onPressed: widget.onPressed,
      child: const Text('Confirmar'),
    );
  }
}
