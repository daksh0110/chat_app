import 'package:chat_app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class PrimaryDropdown extends StatelessWidget {
  const PrimaryDropdown({
    super.key,
    required this.entries,
    required this.onSelected,
    this.initialValue,
    this.validator,
  });

  final List<DropdownMenuEntry<String>> entries;
  final ValueChanged<String?> onSelected;
  final String? initialValue;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: initialValue,
      validator: validator,
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;

                return DropdownMenu<String>(
                  initialSelection: state.value,
                  dropdownMenuEntries: entries,
                  width: width,
                  onSelected: (value) {
                    state.didChange(value); // 🔑 link to Form
                    onSelected(value);
                  },
                  menuStyle: MenuStyle(
                    minimumSize: WidgetStatePropertyAll(Size(width, 0)),
                    maximumSize: WidgetStatePropertyAll(Size(width, 300)),
                    backgroundColor: WidgetStatePropertyAll(
                      AppColors.inputBoxColor,
                    ),
                  ),
                  hintText: "Unspecified",
                  trailingIcon: const Icon(
                    Icons.arrow_drop_down_rounded,
                    color: AppColors.placeholderTextColor,
                    size: 30,
                  ),
                  inputDecorationTheme: const InputDecorationTheme(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 0,
                    ),
                    filled: true,
                    fillColor: AppColors.inputBoxColor,
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                );
              },
            ),

            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 12),
                child: Text(
                  state.errorText!,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
          ],
        );
      },
    );
  }
}
