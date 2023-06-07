import 'package:flutter/material.dart';

import 'app_background.dart';
import 'app_stream_builder.dart';

class AppDropdownButton<T> extends StatelessWidget {
  final Stream<List<T>> itemsStream;
  final Stream<T> itemSelectedStrem;
  final void Function(T?)? onChanged;

  const AppDropdownButton({
    Key? key,
    required this.itemSelectedStrem,
    required this.onChanged,
    required this.itemsStream,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBackgound(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      margin: const EdgeInsets.only(left: 25, top: 25),
      child: AppStreamBuilder<List<T>>(
        stream: itemsStream,
        onData: (items) {
          return AppStreamBuilder<T>(
            stream: itemSelectedStrem,
            onData: (itemSelected) => _buildDropdownButton(items, itemSelected),
          );
        },
      ),
    );
  }

  DropdownButton<T> _buildDropdownButton(List<T> items, T itemSelected) {
    return DropdownButton<T>(
      value: itemSelected,
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
