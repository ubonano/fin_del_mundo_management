import 'package:flutter/material.dart';

class _AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool enabled;
  final FormFieldValidator<String>? validator;
  final void Function(String)? onFieldSubmitted;

  const _AppTextField({
    required this.controller,
    required this.labelText,
    this.keyboardType,
    this.obscureText = false,
    this.enabled = true,
    this.validator,
    this.onFieldSubmitted,
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
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}

class AppFormFields {
  static Widget text({
    required TextEditingController controller,
    required String labelText,
    String? Function(String?)? validator,
    void Function(String)? onFieldSubmitted,
    bool obscureText = false,
  }) {
    return _AppTextField(
      controller: controller,
      onFieldSubmitted: onFieldSubmitted,
      labelText: labelText,
      obscureText: obscureText,
      validator: validator,
    );
  }

  static Widget number(
      {required TextEditingController controller,
      required String labelText,
      String? Function(String?)? validator,
      void Function(String)? onFieldSubmitted}) {
    return _AppTextField(
      controller: controller,
      onFieldSubmitted: onFieldSubmitted,
      labelText: labelText,
      keyboardType: TextInputType.number,
      validator: validator,
    );
  }

  static Widget date({
    required TextEditingController controller,
    required String labelText,
    bool enabled = true,
    void Function(String)? onFieldSubmitted,
    String? Function(String?)? validator,
  }) {
    return _AppTextField(
      controller: controller,
      onFieldSubmitted: onFieldSubmitted,
      labelText: labelText,
      keyboardType: TextInputType.datetime,
      enabled: enabled,
      validator: validator,
      // validator: AppValidators.date,
    );
  }
}
