import 'package:flutter/material.dart';

import 'app_background.dart';
import 'app_stream_builder.dart';

class AppDropdownButton<T> extends StatelessWidget {
  final List<T> items;
  final Stream<T> streamDataSelected;
  final void Function(T?)? onChanged;

  const AppDropdownButton({
    Key? key,
    required this.streamDataSelected,
    required this.onChanged,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBackgound(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      margin: const EdgeInsets.only(left: 25, top: 25),
      child: AppStreamBuilder<T>(
        stream: streamDataSelected,
        onData: (value) => _buildDropdownButton(value),
      ),
    );
  }

  DropdownButton<T> _buildDropdownButton(T value) {
    return DropdownButton<T>(
      value: value,
      onChanged: onChanged,
      underline: const SizedBox.shrink(),
      items: items
          .map<DropdownMenuItem<T>>((value) => _buildDropdownMenuItem(value))
          .toList(),
    );
  }

  DropdownMenuItem<T> _buildDropdownMenuItem(T value) {
    return DropdownMenuItem<T>(value: value, child: Text(value.toString()));
  }
}
