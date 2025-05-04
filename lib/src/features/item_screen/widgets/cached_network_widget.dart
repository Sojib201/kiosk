import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kiosk/src/core/constants/const_string.dart';

class ImageShow extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final bool isLocal;

  const ImageShow({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit,
    this.isLocal = false,
  });

  @override
  Widget build(BuildContext context) {
    return isLocal
        ? Image.file(
            fit: fit,
            File(imageUrl),
            width: width,
            height: height,
          )
        : Image.asset(
            ImagerUrl.defaultFoodIcon,
            fit: BoxFit.contain,
            height: height,
            width: width,
          );

  }
}
