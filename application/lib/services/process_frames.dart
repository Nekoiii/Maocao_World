import 'dart:io';
import 'package:image/image.dart' as img;

import './detect_wires_with_yolo.dart';

Future<void> processFrames(Directory framesDir, Directory processedFramesDir,
    String processWithModel) async {
  print('processFrames--begin');
  if (!processedFramesDir.existsSync()) {
    processedFramesDir.createSync();
  }

  final DetectWiresWithYolo wiresDetector = DetectWiresWithYolo();
  final List<FileSystemEntity> entities = framesDir.listSync();
  for (var entity in entities) {
    if (entity is File && entity.path.endsWith('.jpg')) {
      final framePath = entity.path;
      final fileName = framePath.split('/').last;
      final outputFramePath = '${processedFramesDir.path}/$fileName';
      final img.Image? image = img.decodeImage(entity.readAsBytesSync());

      if (image == null) {
        print('processFrames-- image is null !');
        return;
      }
      if (processWithModel == 'YOLO') {
        await wiresDetector.detectWires(image, outputFilePath: outputFramePath);
      }
    }
  }

  wiresDetector.dispose();
}
