import 'dart:io';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';

Future<void> createVideoFromFrames(
    String framesDir, String outputVideoPath, int frameRate) async {
  final FlutterFFmpeg _flutterFFmpeg = FlutterFFmpeg();
  final command =
      "-framerate $frameRate -i $framesDir/frame_%04d.jpg -c:v libx264 -pix_fmt yuv420p $outputVideoPath";
  await _flutterFFmpeg.execute(command).then((returnCode) {
    if (returnCode == 0) {
      print("Video created successfully at $outputVideoPath");
    } else {
      print("Failed to create video. Return code: $returnCode");
    }
  });
}
