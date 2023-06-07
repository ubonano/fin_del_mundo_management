import 'package:fin_del_mundo_management/widgets/app_dropdown_field.dart';
import 'package:flutter/material.dart';
import '../../../setup/get_it_setup.dart';
import '../provider.dart';
import '../provider_controller.dart';

class ProviderDropdownField extends StatefulWidget {
  final Function(Provider?) onChanged;
  final Provider? initialValue;
  final bool enabled;

  const ProviderDropdownField({
    super.key,
    required this.onChanged,
    required this.initialValue,
    this.enabled = true,
  });

  @override
  _ProviderDropdownFieldState createState() => _ProviderDropdownFieldState();
}

class _ProviderDropdownFieldState extends State<ProviderDropdownField> {
  final _controller = getIt<ProviderController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppDropdownField(
      onChanged: widget.onChanged,
      initialValue: widget.initialValue,
      stream: _controller.$providers,
      getDisplayName: (a) => a.name,
      label: 'Proveedor',
    );
  }
}
