import 'package:flutter/material.dart';
import 'package:quran_tv/presentation/components/inputs/option_entry_item_wrapper.dart';

class AppDropdownFormField<T> extends StatelessWidget {
  final List<AppDropdownItem<T>> items;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final FocusNode? focusNode;

  const AppDropdownFormField({
    super.key,
    required this.items,
    this.value,
    this.onChanged,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      focusNode: focusNode, // 👈 attach focus node
      style: Theme.of(context).textTheme.titleMedium,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(80, 7, 6, 13),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
      icon: OptionEntryItemWrapper(
        builder: (_, isFocused) {
          return Icon(
            Icons.keyboard_arrow_down,
            color: isFocused ? Colors.black : Colors.white,
          );
        },
      ),
      value: value,
      items: items.map((item) {
        return DropdownMenuItem(
          value: item.value,
          onTap: item.onTap,
          alignment: item.alignment,
          enabled: item.enabled,
          child: OptionEntryItemWrapper(
            builder: (_, isFocused) {
              return DefaultTextStyle(
                style: TextStyle(color: isFocused ? Colors.white : null),
                child: item.child,
              );
            },
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}

class AppDropdownItem<T> {
  /// Creates an item for a dropdown menu.
  ///
  /// The [child] argument is required.
  const AppDropdownItem({
    this.onTap,
    this.value,
    this.enabled = true,
    this.alignment = AlignmentDirectional.centerStart,
    required this.child,
  });

  /// Called when the dropdown menu item is tapped.
  final VoidCallback? onTap;

  /// The value to return if the user selects this menu item.
  ///
  /// Eventually returned in a call to [DropdownButton.onChanged].
  final T? value;

  /// Whether or not a user can select this menu item.
  ///
  /// Defaults to `true`.
  final bool enabled;
  final AlignmentGeometry alignment;
  final Widget child;
}
