import 'dart:io';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';

Future<void> extractFrames(
    String videoPath, Directory extractedFramesDir, int frameRate) async {
  print('extractFrames--begin');
  if (!await extractedFramesDir.exists()) {
    await extractedFramesDir.create(recursive: true);
  }

  final FlutterFFmpeg _flutterFFmpeg = FlutterFFmpeg();
  int quality = 31; //[2 ~ 31]。larger number -> worse quality
  String command =
      "-i $videoPath -r $frameRate -q:v $quality ${extractedFramesDir.path}/frame_%04d.jpg";

  // final FlutterFFmpegConfig _flutterFFmpegConfig = FlutterFFmpegConfig();
  // _flutterFFmpegConfig.enableLogs();
  // _flutterFFmpegConfig.enableLogCallback((log) {
  //   print('xxxx--log: ${log.message}');
  // });
  await _flutterFFmpeg.execute(command).then((returnCode) {
    if (returnCode == 0) {
      print(
          "extractFrames-- Frames extracted successfully to $extractedFramesDir");
    } else {
      print(
          "extractFrames-- Error occurred during frame extraction. Return code: $returnCode");
    }
  });
}
