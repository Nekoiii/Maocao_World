import 'dart:io';
import './detect_wires_with_yolo.dart';

Future<void> processFrames(String framesDir, String processWith) async {
  final DetectWiresWithYolo wiresDetector = DetectWiresWithYolo();

  final outputDir = Directory('$framesDir/processed_frames');
  if (!outputDir.existsSync()) {
    outputDir.createSync();
  }

  final dir = Directory(framesDir);
  final List<FileSystemEntity> entities = dir.listSync();
  for (var entity in entities) {
    if (entity is File && entity.path.endsWith('.jpg')) {
      final framePath = entity.path;
      final fileName = framePath.split('/').last;
      final outputFramePath = '${outputDir.path}/$fileName';
      if (processWith == 'YOLO') {
        await wiresDetector.detectWires(entity,
            outputFilePath: outputFramePath);
      }
    }
  }

  wiresDetector.dispose();
}
