import 'dart:io';

import 'package:cloudinary_api/uploader/cloudinary_uploader.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:cloudinary_api/src/request/model/uploader_params.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';

class CloudinaryService {
  static final String cloudName = dotenv.env['CLOUDINARY_NAME'] ?? '';
  static final String apiKey = dotenv.env['CLOUDINARY_API_KEY'] ?? '';
  static final String apiSecret = dotenv.env['CLOUDINARY_API_SECRET'] ?? '';

  static final Cloudinary _cloudinary = Cloudinary.fromStringUrl(
    'cloudinary://$apiKey:$apiSecret@$cloudName',
  );

  static Future<void> uploadImage(XFile image) async {
    try {
      final File file = File(image.path);
      final response = await _cloudinary.uploader().upload(
        file,
        params: UploadParams(type: "image"),
      );

      print('Upload success: ${response?.error?.message}');
    } catch (e) {
      print('Upload failed: $e');
    }
  }
}
