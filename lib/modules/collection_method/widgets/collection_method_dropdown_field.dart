import 'package:fin_del_mundo_management/widgets/app_dropdown_field.dart';
import 'package:flutter/material.dart';
import '../../../setup/get_it_setup.dart';
import '../collection_method.dart';
import '../collection_method_controller.dart';

class CollectionMethodDropdownField extends StatefulWidget {
  final Function(CollectionMethod?) onChanged;
  final CollectionMethod? initialValue;
  final bool enabled;

  const CollectionMethodDropdownField({
    super.key,
    required this.onChanged,
    required this.initialValue,
    this.enabled = true,
  });

  @override
  _CollectionMethodDropdownFieldState createState() =>
      _CollectionMethodDropdownFieldState();
}

class _CollectionMethodDropdownFieldState
    extends State<CollectionMethodDropdownField> {
  final _controller = getIt<CollectionMethodController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppDropdownField(
      onChanged: widget.onChanged,
      initialValue: widget.initialValue,
      stream: _controller.collectionMethods,
      getDisplayName: (a) => a.name,
      label: 'Metodo de cobor',
    );
  }
}
