import '../config/app_config.dart';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';

import 'upload_file_to_service.dart';
import './extract_frames.dart';
import './process_frames.dart';

class FileUploader {
  Future<void> uploadVideo(XFile file, String fileType,
      Function(double) onUploadProgress, bool processWithPython) async {
    try {
      if (processWithPython) {
        await uploadFileToService(file, fileType, onUploadProgress);
        return;
      }
      await uploadFileLocally(file, fileType, onUploadProgress);
    } catch (e) {
      print("uploadVideo-- Error uploading video: $e");
    }
  }

  Future<void> uploadFileLocally(
      XFile file, String fileType, Function(double) onUploadProgress) async {
    print('uploadFileLocally--begin');
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final Directory uploadsDir =
        Directory('${appDocDir.path}/uploads/$fileType');
    if (!await uploadsDir.exists()) {
      await uploadsDir.create(recursive: true);
    }
    final String filePath = '${uploadsDir.path}/${file.path.split('/').last}';
    await file.saveTo(filePath);
    print('uploadFileLocally--end');
  }
}
