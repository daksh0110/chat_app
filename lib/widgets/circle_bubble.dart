import 'package:flutter/material.dart';

class CircleBubble extends StatelessWidget {
  const CircleBubble({
    super.key,
    this.height = 32,
    this.image,
    this.imageProvider,
  });

  final double height;

  final Image? image;
  final ImageProvider? imageProvider;

  @override
  Widget build(BuildContext context) {
    final Image? resolvedImage =
        image ??
        (imageProvider != null
            ? Image(image: imageProvider!, fit: BoxFit.cover)
            : null);

    return InkWell(
      child: Container(
        height: height,
        decoration: const BoxDecoration(
          color: Colors.amber,
          shape: BoxShape.circle,
        ),
        clipBehavior: Clip.hardEdge,

        child: resolvedImage,
      ),
    );
  }
}
