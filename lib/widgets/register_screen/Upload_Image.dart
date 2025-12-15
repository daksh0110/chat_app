import 'dart:io';

import 'package:chat_app/theme/app_colors.dart';
import 'package:chat_app/widgets/app_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  Future<void> _pickImageFromGallery() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    if (image != null) {
      setState(() {
        _image = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: _pickImageFromGallery,
          child: _image == null
              ? DottedBorder(
                  options: RectDottedBorderOptions(
                    dashPattern: const [5, 5],
                    borderPadding: const EdgeInsets.all(64),
                    padding: const EdgeInsets.all(16),
                    color: AppColors.secondaryColor,
                  ),
                  child: const Icon(Icons.add, color: AppColors.secondaryColor),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    File(_image!.path),
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
        ),
        const SizedBox(height: 20),
        AppText(
          "Upload a Picture",
          color: AppColors.textMediumColor,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
        const SizedBox(height: 2),
        const AppText(
          "(Automatically created as an NFT asset)",
          color: AppColors.textSmallColor,
          fontSize: 12,
        ),
      ],
    );
  }
}
