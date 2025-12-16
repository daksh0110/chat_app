import 'dart:io';

import 'package:chat_app/theme/app_colors.dart';
import 'package:chat_app/widgets/app_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({
    super.key,
    required this.selectedImage,
    required this.onImageSelected,
  });

  final XFile? selectedImage;
  final ValueChanged<XFile?> onImageSelected;

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImageFromGallery(FormFieldState<XFile?> field) async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    if (image != null) {
      widget.onImageSelected(image);
      field.didChange(image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormField<XFile?>(
      initialValue: widget.selectedImage,
      validator: (value) {
        if (value == null) {
          return 'Please upload an image';
        }
        return null;
      },
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => _pickImageFromGallery(field),
              child: widget.selectedImage == null
                  ? DottedBorder(
                      options: RectDottedBorderOptions(
                        dashPattern: const [5, 5],
                        borderPadding: const EdgeInsets.all(64),
                        padding: const EdgeInsets.all(16),
                        color: AppColors.secondaryColor,
                      ),
                      child: const Icon(
                        Icons.add,
                        color: AppColors.secondaryColor,
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        File(widget.selectedImage!.path),
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),

            const SizedBox(height: 12),

            if (widget.selectedImage == null)
              const AppText(
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

            if (field.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  field.errorText!,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
          ],
        );
      },
    );
  }
}
