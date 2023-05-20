import 'package:flutter/material.dart';

import '../../utils/app_validators.dart';

class AppFormField {
  static Widget text({
    required TextEditingController controller,
    required String labelText,
    void Function(String)? onFieldSubmitted,
    bool obscureText = false,
    bool required = false,
    bool enabled = true,
    Function(String)? onChanged,
  }) {
    return _AppTextField(
      controller: controller,
      onFieldSubmitted: onFieldSubmitted,
      labelText: labelText,
      obscureText: obscureText,
      enabled: enabled,
      validator: (value) => AppValidators.text(value, required: required),
      onChanged: onChanged,
    );
  }

  static Widget number({
    required TextEditingController controller,
    required String labelText,
    void Function(String)? onFieldSubmitted,
    bool obscureText = false,
    bool required = false,
    bool enabled = true,
    Function(String)? onChanged,
  }) {
    return _AppTextField(
      controller: controller,
      onFieldSubmitted: onFieldSubmitted,
      labelText: labelText,
      obscureText: obscureText,
      keyboardType: TextInputType.number,
      enabled: enabled,
      onChanged: onChanged,
      validator: (value) => AppValidators.number(value, required: required),
    );
  }

  static Widget date({
    required TextEditingController controller,
    required String labelText,
    void Function(String)? onFieldSubmitted,
    bool obscureText = false,
    bool enabled = true,
    bool required = false,
  }) {
    return _AppTextField(
      controller: controller,
      labelText: labelText,
      onFieldSubmitted: onFieldSubmitted,
      enabled: enabled,
      obscureText: obscureText,
      keyboardType: TextInputType.datetime,
      validator: (value) => AppValidators.date(value, required: required),
    );
  }
}

class _AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool enabled;
  final FormFieldValidator<String>? validator;
  final void Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;

  const _AppTextField({
    required this.controller,
    required this.labelText,
    this.onFieldSubmitted,
    this.keyboardType,
    this.validator,
    this.obscureText = false,
    this.enabled = true,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
        controller: controller,
        onFieldSubmitted: onFieldSubmitted,
        keyboardType: keyboardType,
        obscureText: obscureText,
        enabled: enabled,
        validator: validator,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
