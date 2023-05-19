import 'package:flutter/material.dart';

class AppActionsButton extends StatelessWidget {
  final Function onEdit;
  final Function onDelete;

  const AppActionsButton(
      {Key? key, required this.onEdit, required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            onEdit();
            break;
          case 1:
            onDelete();
            break;
        }
      },
      icon: const Icon(Icons.more_vert),
    );
  }
}
