import 'package:fin_del_mundo_management/widgets/app_stream_builder.dart';
import 'package:fin_del_mundo_management/utils/app_validators.dart';
import 'package:flutter/material.dart';

class AppDropdownField<T> extends StatelessWidget {
  final Function(T?) onChanged;
  final T? initialValue;
  final bool enabled;
  final Stream<List<T>> stream;
  final String Function(T entity) getDisplayName;
  final String label;

  const AppDropdownField({
    Key? key,
    required this.onChanged,
    required this.initialValue,
    required this.stream,
    required this.getDisplayName,
    required this.label,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: AppStreamBuilder(
        stream: stream,
        onData: (entities) => DropdownButtonFormField<T>(
          decoration: InputDecoration(
            labelText: label,
            filled: true,
            isDense: true,
            enabled: enabled,
          ),
          value: initialValue,
          validator: AppValidators.object,
          items: _buildDropdownMenuItems(entities),
          onChanged: onChanged,
        ),
      ),
    );
  }

  List<DropdownMenuItem<T>> _buildDropdownMenuItems(List<T> entities) {
    return entities.map(
      (entity) {
        return DropdownMenuItem<T>(
          value: entity,
          child: Text(getDisplayName(entity)),
        );
      },
    ).toList();
  }
}
