import 'package:flutter/material.dart';

import 'app_background.dart';
import 'app_stream_builder.dart';

class AppDropdownButton extends StatelessWidget {
  final List<String> items;
  final Stream<String> streamData;

  final void Function(String?)? onChanged;

  const AppDropdownButton({
    Key? key,
    required this.streamData,
    required this.onChanged,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBackgound(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      margin: const EdgeInsets.only(left: 25, top: 25),
      child: AppStreamBuilder<String>(
        stream: streamData,
        onData: (value) => _buildDropdownButton(value),
      ),
    );
  }

  DropdownButton<String> _buildDropdownButton(String month) {
    return DropdownButton<String>(
      value: month,
      onChanged: onChanged,
      underline: const SizedBox.shrink(),
      items: items
          .map<DropdownMenuItem<String>>(
              (value) => _buildDropdownMenuItem(value))
          .toList(),
    );
  }

  DropdownMenuItem<String> _buildDropdownMenuItem(String value) {
    return DropdownMenuItem<String>(value: value, child: Text(value));
  }
}
