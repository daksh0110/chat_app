import 'package:chat_app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatefulWidget {
  const PrimaryButton({
    super.key,
    required this.text,
    this.fullWidth = true,
    this.onCick,
    this.backgroundColor = AppColors.primaryColor,
    this.textColor = Colors.white,
    this.borderColor = Colors.transparent,
  });
  final String text;
  final bool fullWidth;
  final VoidCallback? onCick;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  @override
  State<PrimaryButton> createState() {
    return _PrimaryButtonState();
  }
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    String buttonTitle = widget.text;

    return SizedBox(
      width: widget.fullWidth ? double.infinity : null,
      child: TextButton(
        onPressed: widget.onCick,
        style: ButtonStyle(
          padding: WidgetStateProperty.all(
            EdgeInsets.symmetric(horizontal: 16),
          ),
          backgroundColor: WidgetStateProperty.all(widget.backgroundColor),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(6),
              side: BorderSide(color: widget.borderColor),
            ),
          ),
        ),
        child: Text(
          buttonTitle,
          style: TextStyle(
            color: widget.textColor,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
