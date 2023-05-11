import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class AppDialog extends StatefulWidget {
  final String title;
  final String content;
  final void Function()? onPressed;

  const AppDialog({
    Key? key,
    required this.onPressed,
    this.title = 'Eliminar registro',
    this.content = '¿Esta seguro que desea eliminar este registro',
  }) : super(key: key);

  static Future<void> showDelete(
    BuildContext context, {
    required void Function()? onPressed,
  }) async {
    await showDialog<bool>(
      context: context,
      builder: (context) {
        return AppDialog(
          title: 'Borrar ingreso diario',
          content: '¿Esta seguro que desea eliminar esta orden?',
          onPressed: onPressed,
        );
      },
    );
  }

  @override
  State<AppDialog> createState() => _AppDialogState();
}

class _AppDialogState extends State<AppDialog> {
  StackRouter? router;

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
      child: const Text('Eliminar'),
    );
  }
}
