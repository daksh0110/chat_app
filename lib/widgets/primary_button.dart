import 'package:flutter/material.dart';

class PrimaryButton extends StatefulWidget {
  const PrimaryButton({super.key, required this.text});
  final String text;
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
      width: double.infinity,

      child: TextButton(
        onPressed: () {},
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
            Theme.of(context).colorScheme.primary,
          ),
          shape: WidgetStateProperty.all(LinearBorder.none),
        ),
        child: Text(buttonTitle, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
