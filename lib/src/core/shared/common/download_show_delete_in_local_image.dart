import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class DownloadShowDeleteInLocalImage {
  Future downloadAndSaveImage(String url, String fileName) async {
    try {
      final response = await http.get(Uri.parse(url));
      final bytes = response.bodyBytes;

      final appDir = await getApplicationDocumentsDirectory();
      final file = File('${appDir.path}/$fileName.png');
      if (await file.exists()) {
        await file.delete(); // if file is already exsist this time delete thant add
      }
      await file.writeAsBytes(bytes);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void deleteImage(String fileName) async {
    final appDir = await getApplicationDocumentsDirectory();
    final file = File('${appDir.path}/$fileName.png');
    if (await file.exists()) {
      await file.delete();
    }
  }

  Future<bool> isExisImage(String path) async {
    final file = File(path);
    if (await file.exists()) {
      return true;
    } else {
      return false;
    }
  }

  Future<String> getImageFile(String fileName) async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      log('${appDir.path}/$fileName.png', name: "Image Path");

      return '${appDir.path}/$fileName.png';
    } catch (e) {
      final appDir = await getApplicationDocumentsDirectory();
      return '${appDir.path}/$fileName.png';
    }
  }
}
