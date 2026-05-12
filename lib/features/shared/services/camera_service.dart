import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraService {

  CameraService._();

  static final CameraService instance = CameraService._();

  final ImagePicker _picker = ImagePicker();

  /// Abrir cámara y retornar imagen
  Future<File?> takePhoto(BuildContext context) async {

    try {

      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
        preferredCameraDevice: CameraDevice.rear,
      );

      /// Usuario canceló
      if (photo == null) {
        return null;
      }

      return File(photo.path);

    } catch (e) {

      debugPrint('Error tomando foto: $e');

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.black,
            content: Text(
              'No fue posible abrir la cámara.',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      }

      return null;
    }
  }
}