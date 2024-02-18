import '../config/app_config.dart';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';

import './upload_video_with_python.dart';

class VideoUploader {
  Future<void> uploadVideo(String filePath, Function(double) onUploadProgress,
      bool processWithPython) async {
    if (processWithPython) {
      await uploadVideoWithPython(filePath, onUploadProgress);
      return;
    }
    await uploadVideoLocally(filePath, onUploadProgress);
  }

  Future<void> uploadVideoLocally(
      String filePath, Function(double) onUploadProgress) async {
    final FlutterFFmpeg _flutterFFmpeg = FlutterFFmpeg();
    return;
  }
}
