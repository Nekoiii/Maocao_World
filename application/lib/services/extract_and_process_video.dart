import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import './extract_frames.dart';
import './process_frames.dart';

void extractAndProcessVideo(String filePath) async {
  print('extractAndProcessVideo--begin');
  final Directory appDocDir = await getApplicationDocumentsDirectory();
  final Directory extractedFramesDir =
      Directory('${appDocDir.path}/outputs/extracted_frames_dir');
  final Directory processedFramesDir =
      Directory('${appDocDir.path}/outputs/processed_frames');
  const int frameRate = 12;
  await extractFrames(filePath, extractedFramesDir, frameRate);
  await processFrames(extractedFramesDir, processedFramesDir, 'YOLO');
  print('extractAndProcessVideo--end');
}
