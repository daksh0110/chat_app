import 'package:chat_app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class PrimaryInput extends StatelessWidget {
  const PrimaryInput({
    super.key,
    required this.placeholderText,
    this.maxlines = 1,
    this.readOnly = false,
    this.controller,
    this.validator,
  });
  final String placeholderText;
  final int maxlines;
  final bool readOnly;
  final TextEditingController? controller;
  final FormFieldValidator? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      readOnly: readOnly,
      maxLines: maxlines,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.inputBoxColor,
        hintText: placeholderText,
        hintStyle: TextStyle(color: AppColors.placeholderTextColor),
        contentPadding: EdgeInsets.fromLTRB(8, 8, 8, 8),
        errorStyle: TextStyle(color: AppColors.dangerColor),

        border: OutlineInputBorder(borderSide: BorderSide.none),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
