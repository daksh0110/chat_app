import 'package:flutter/material.dart';

class CircleBubble extends StatelessWidget {
  const CircleBubble({super.key, this.height = 32, this.image});
  final double height;
  final Image? image;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(color: Colors.amber, shape: BoxShape.circle),
        height: height,
        clipBehavior: Clip.hardEdge,
        child: image,
      ),
    );
  }
}
