import '../config/app_config.dart';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:path_provider/path_provider.dart';

import './upload_video_with_python.dart';
import './extract_frames.dart';
import './process_frames.dart';

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
    print('uploadVideoLocally--begin');
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final Directory extractedFramesDir =
        Directory('${appDocDir.path}/outputs/extracted_frames_dir');
    final Directory processedFramesDir =
        Directory('${appDocDir.path}/outputs/processed_frames');
    const int frameRate = 12;
    await extractFrames(filePath, extractedFramesDir, frameRate);
    await processFrames(extractedFramesDir, processedFramesDir, 'YOLO');

    return;
  }
}
