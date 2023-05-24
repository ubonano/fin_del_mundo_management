import 'package:fin_del_mundo_management/utils/app_validators.dart';
import 'package:flutter/material.dart';

class AppBranchField extends StatefulWidget {
  final Function(String?) onChanged;
  final String? initialValue;

  const AppBranchField({
    Key? key,
    required this.onChanged,
    this.initialValue,
  }) : super(key: key);

  @override
  _AppBranchFieldState createState() => _AppBranchFieldState();
}

class _AppBranchFieldState extends State<AppBranchField> {
  final List<String> _branches = ['Restaurante', 'Discoteca'];
  String? _selectedBranch;

  @override
  void initState() {
    super.initState();

    if (widget.initialValue != null &&
        _branches.contains(widget.initialValue!)) {
      _selectedBranch = widget.initialValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: _buildDropdownButtonFormField(),
    );
  }

  DropdownButtonFormField<String> _buildDropdownButtonFormField() {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        labelText: 'Sucursal',
        filled: true,
        isDense: true,
      ),
      value: _selectedBranch,
      validator: AppValidators.text,
      items: _buildDropdownMenuItems(),
      onChanged: _onChanged,
    );
  }

  void _onChanged(String? value) {
    widget.onChanged(value);
    setState(() {
      _selectedBranch = value;
    });
  }

  List<DropdownMenuItem<String>> _buildDropdownMenuItems() {
    return _branches.map((branch) {
      return DropdownMenuItem<String>(
        value: branch,
        child: Text(branch),
      );
    }).toList();
  }
}
