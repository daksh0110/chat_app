import 'package:chat_app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SecondaryButton extends StatefulWidget {
  const SecondaryButton({super.key, required this.text});
  final String text;
  @override
  State<SecondaryButton> createState() {
    return _SecondaryButtonState();
  }
}

class _SecondaryButtonState extends State<SecondaryButton> {
  @override
  Widget build(BuildContext context) {
    String buttonTitle = widget.text;
    return SizedBox(
      width: double.infinity,

      child: TextButton(
        onPressed: () {},
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.transparent),
        ),
        child: Text(
          buttonTitle,
          style: TextStyle(
            color: AppColors.secondaryColor,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
