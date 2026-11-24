import 'dart:io' show File;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Muestra una imagen local capturada con la cámara.
/// En web [path] es una URL `blob:` (se usa Image.network); en móvil/escritorio es una ruta de archivo.
class LocalImage extends StatelessWidget {
  final String path;
  final double? height;
  final double? width;
  final BoxFit fit;

  const LocalImage({
    super.key,
    required this.path,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return Image.network(path, height: height, width: width, fit: fit);
    }
    return Image.file(File(path), height: height, width: width, fit: fit);
  }
}
