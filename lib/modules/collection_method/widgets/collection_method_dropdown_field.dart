import 'package:fin_del_mundo_management/widgets/app_dropdown_field.dart';
import 'package:flutter/material.dart';
import '../../../setup/get_it_setup.dart';
import '../collection_method.dart';
import '../collection_method_controller.dart';

class CollectionMethodDropdownField extends StatelessWidget {
  final Function(CollectionMethod?) onChanged;
  final CollectionMethod? initialValue;
  final bool enabled;

  CollectionMethodDropdownField({
    super.key,
    required this.onChanged,
    this.initialValue,
    this.enabled = true,
  });

  final _controller = getIt<CollectionMethodController>();

  @override
  Widget build(BuildContext context) {
    return AppDropdownField(
      onChanged: onChanged,
      initialValue: initialValue,
      stream: _controller.$collectionMethods,
      getDisplayName: (a) => a.name,
      label: 'Metodo',
    );
  }
}
