import 'package:fin_del_mundo_management/utils/app_validators.dart';
import 'package:flutter/material.dart';

class BranchField extends StatefulWidget {
  final Function(String?) onChanged;
  final String? initialValue;

  const BranchField({Key? key, required this.onChanged, this.initialValue})
      : super(key: key);

  @override
  _BranchFieldState createState() => _BranchFieldState();
}

class _BranchFieldState extends State<BranchField> {
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
      child: DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          labelText: 'Sucursal',
          filled: true,
          isDense: true,
        ),
        value: _selectedBranch,
        onChanged: (value) {
          setState(() {
            _selectedBranch = value;
          });
          widget.onChanged(value);
        },
        items: _branches.map((branch) {
          return DropdownMenuItem<String>(
            value: branch,
            child: Text(branch),
          );
        }).toList(),
        validator: AppValidators.text,
      ),
    );
  }
}
