import 'package:fin_del_mundo_management/utils/app_validators.dart';
import 'package:flutter/material.dart';

class DailyIncomeBranchField extends StatefulWidget {
  final Function(String?) onChanged;
  final String? initialValue;

  const DailyIncomeBranchField({
    Key? key,
    required this.onChanged,
    this.initialValue,
  }) : super(key: key);

  @override
  _DailyIncomeBranchFieldState createState() => _DailyIncomeBranchFieldState();
}

class _DailyIncomeBranchFieldState extends State<DailyIncomeBranchField> {
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
      onChanged: (value) {
        _updateSelectedBranch(value);
        widget.onChanged(value);
      },
      items: _buildDropdownMenuItems(),
      validator: AppValidators.text,
    );
  }

  void _updateSelectedBranch(String? value) {
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
