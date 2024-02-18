import 'dart:io';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';

Future<void> extractFrames(
    String videoPath, String framesOutputDir, int frameRate) async {
  final FlutterFFmpeg _flutterFFmpeg = FlutterFFmpeg();

  final directory = Directory(framesOutputDir);
  if (!await directory.exists()) {
    await directory.create(recursive: true);
  }

  int quality = 31; //[2 , 31]。larger number -> worse quality
  String command =
      "-i $videoPath -r $frameRate -q:v $quality $framesOutputDir/frame_%04d.jpg";

  await _flutterFFmpeg.execute(command).then((returnCode) {
    if (returnCode == 0) {
      print("Frames extracted successfully to $framesOutputDir");
    } else {
      print("Error occurred during frame extraction. Return code: $returnCode");
    }
  });
}
