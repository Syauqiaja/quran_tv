import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:quran_tv/core/utils/route_wrapper.dart';
import 'package:quran_tv/presentation/components/inputs/app_dropdown_form_field.dart';
import 'package:quran_tv/presentation/components/inputs/option_entry_item_wrapper.dart';
import 'package:quran_tv/presentation/components/layouts/app_scaffold.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final FocusNode _backButtonFocusNode = FocusNode(debugLabel: "Back button");
  final ScrollController _scrollController = ScrollController();
  bool isAutoPlay = false;

  @override
  void dispose() {
    _backButtonFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backButtonFocusNode: _backButtonFocusNode,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            spacing: 12,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTitle("Settings"),

              // Theme setting row
              _buildSettingRow(
                context: context,
                title: "Theme",
                description: "Choose theme mode Light/Dark/Auto",
                child: _buildSettingsDropdown<ThemeMode>(
                  context: context,
                  items: ThemeMode.values,
                  value: ThemeMode.dark,
                  itemBuilder: (theme) => Text(theme.name),
                  onChanged: (value) {
                    // Handle theme change
                  },
                ),
              ),

              // Language setting row
              _buildSettingRow(
                context: context,
                title: "Language",
                description: "Choose language",
                child: _buildSettingsDropdown<String>(
                  context: context,
                  items: ['English', 'Arabic', 'French'], // Example languages
                  value: 'English',
                  itemBuilder: (language) => Text(language),
                  onChanged: (value) {
                    // Handle language change
                  },
                ),
              ),

              // Autoplay setting row
              _buildSettingRow(
                context: context,
                title: "Autoplay",
                description: "Enjoy nonstop listening",
                child: _buildSettingSwitch(
                  value: isAutoPlay,
                  onChanged: (value) => setState(() {
                    isAutoPlay = value;
                  }),
                ),
              ),

              // Highlight mode row
              _buildSettingRow(
                context: context,
                title: "Highlight Mode",
                description:
                    "Lorem ipsum  dolor sit amet Lorem ipsum  dolor sit amet",
                child: _buildSettingSwitch(
                  value: isAutoPlay,
                  onChanged: (value) => setState(() {
                    isAutoPlay = value;
                  }),
                ),
              ),

              // Display mode setting row
              _buildSettingRow(
                context: context,
                title: "Display Mode",
                description:
                    "Lorem ipsum  dolor sit amet Lorem ipsum  dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum  dolor sit amet",
              ),

              Divider(),
              _buildTitle("Storage"),

              _buildSettingRow(
                context: context,
                title: "Download: 3458 MB",
                description:
                    "Lorem ipsum  dolor sit amet Lorem ipsum  dolor sit amet",
                child: OutlinedButton(
                  onPressed: () {},
                  child: Text("Remove all downloads"),
                ),
              ),
              _buildSettingRow(
                context: context,
                title: "Cache: 1233 MB",
                description:
                    "Temporary file that stored for a faster experience",
                child: OutlinedButton(
                  onPressed: () {},
                  child: Text("Clear cache"),
                ),
              ),

              Divider(),

              _buildSettingRow(
                context: context,
                title: "Remove Account",
                description:
                    "Permanently delete your account and all associated data. This action cannot be undone.",
                child: OutlinedButton(
                  onPressed: () {},
                  child: Text("Remove Account"),
                ),
              ),

              Divider(),

              _buildTitle("About"),

              _buildSettingRow(
                context: context,
                title: "App version",
                description: "Version 4.523.4.0",
                child: Focus(
                  child: SizedBox(),
                  onKeyEvent: (node, event) {
                    if (event.logicalKey == LogicalKeyboardKey.arrowDown && event is KeyDownEvent) {
                      _scrollController.jumpTo(_scrollController.offset + 100);
                      return KeyEventResult.handled;
                    } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
                      node.previousFocus();
                    }
                    return KeyEventResult.ignored;
                  },
                ),
              ),
              _buildSettingRow(
                context: context,
                title: "Developer info",
                description: "John Doe, www.conntactus.com",
              ),
              _buildSettingRow(
                context: context,
                title: "License info",
                description: "lorem ipsum dolor sit amet",
              ),
              _buildSettingRow(
                context: context,
                title: "Help & feedback",
                description: "qurantv@info.com, www.qurantv.com",
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable method for creating setting rows with dropdown
  Widget _buildSettingRow({
    required BuildContext context,
    required String title,
    required String description,
    Widget? child,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 500,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.start,
              ),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.color?.withAlpha(150),
                ),
              ),
            ],
          ),
        ),
        Spacer(),
        SizedBox(width: 200, child: child),
      ],
    );
  }

  Widget _buildSettingSwitch({
    required Function(bool value) onChanged,
    required bool value,
  }) {
    return Align(
      alignment: Alignment.centerRight,
      child: Switch(value: value, onChanged: onChanged),
    );
  }

  // Reusable generic dropdown method
  Widget _buildSettingsDropdown<T>({
    required BuildContext context,
    required List<T> items,
    required T? value,
    required Widget Function(T) itemBuilder,
    required ValueChanged<T?>? onChanged,
  }) {
    return DropdownButtonFormField<T>(
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
        focusColor: Colors.white,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
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
        return DropdownMenuItem<T>(
          value: item,
          child: OptionEntryItemWrapper(
            builder: (_, isFocused) {
              return DefaultTextStyle(
                style: TextStyle(color: isFocused ? Colors.black : null),
                child: itemBuilder(item),
              );
            },
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold),
        textAlign: TextAlign.start,
      ),
    );
  }
}

final class SettingsRoute extends RouteWrapper {
  SettingsRoute()
    : super(builder: _builder, name: routeName, path: '/settings');

  static String get routeName => "settings";

  static go(BuildContext context) => context.goNamed(routeName);

  static push(BuildContext context) => context.pushNamed(routeName);

  static Widget _builder(BuildContext context, GoRouterState state) {
    return SettingsScreen();
  }
}
