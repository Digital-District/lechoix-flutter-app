import 'package:flutter/material.dart';

import '../util/utils/consts/ui_constants.dart';

class DropDownWidget<T> extends StatelessWidget {
  final List<T> items;
  final T? selectedItem;
  final String hint;
  final Function(T?) onItemSelected;

  const DropDownWidget({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.hint,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      alignedDropdown: true,
      child: DropdownButton<T>(
        hint: Text(
          hint,
          style: const TextStyle(color: UIConstants.gray4Color),
        ),
        isDense: true,
        value: selectedItem,
        isExpanded: true,
        borderRadius: BorderRadius.circular(UIConstants.radius),
        underline: Container(),
        icon: const Icon(Icons.keyboard_arrow_down),
        onChanged: (newValue) => onItemSelected(newValue),
        items: items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item.toString()),
          );
        }).toList(),
      ),
    );
  }
}
