//flutter+YOLOv5+リアルタイムで物体検出: https://qiita.com/syu-kwsk/items/e3126f55895444aa408b
import 'dart:io';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;

import './YUV420_to_RGB.dart';
import './BGRA8888_to_RGB.dart';

// const modelPath = 'assets/models/yolov8_wires_dect_best_int8.tflite';
// const modelPath = 'assets/models/yolov8_wires_dect_best_full_integer_quant.tflite';
const modelPath = 'assets/models/yolov8_wires_dect_best_float16.tflite';
const classes = ['cable', 'tower_wooden'];

class DetectionResult {
  final Rect boundingBox;
  final double confidence;
  final int classId;
  DetectionResult(this.boundingBox, this.confidence, this.classId);
}

class DetectWiresWithYolo {
  Interpreter? _interpreter;

  DetectWiresWithYolo() {
    _loadModel(modelPath);
  }

  void _loadModel(String modelPath) async {
    try {
      _interpreter = await Interpreter.fromAsset(modelPath);
      print("_loadModel-- Model loaded successfully");
    } catch (e) {
      print("_loadModel-- Failed to load model: $e");
    }
  }

  List<DetectionResult> parseOutput(List<dynamic> output, int batchSize,
      int elementsPerDetection, int totalDetections) {
    print('parseOutput--begin ');
    List<DetectionResult> results = [];

    for (int b = 0; b < batchSize; b++) {
      var batch = output[b];
      // print('parseOutput--batch $b : ${batch}');
      // print('parseOutput--batch.length $b : ${batch.length}');
      // print('parseOutput--batch.length[0] $b : ${batch[0].length}');
      for (int i = 0; i < totalDetections; i++) {
        // *unfinished: elements don't seem to match the result I wanted !!!!
        var x = batch[0][i];
        var y = batch[1][i];
        var width = batch[2][i];
        var height = batch[3][i];
        // print(
        //     'parseOutput-- ele: $i -- x: $x, y: $y, width: $width, height: $height');

        // const double confidenceThreshold = 0.5;
        // if (confidence > confidenceThreshold) {
        //   Rect boundingBox = Rect.fromLTWH(x, y, width, height);
        //   results.add(DetectionResult(boundingBox, confidence, classId));
        //   // print('parseOutput-- results $results');
        // }
      }
    }
    return results;
  }

  img.Image convertImgToRGB(image) {
    print('convertImgToRGB--begin');
    print('convertImgToRGB-- image.runtimeType: ${image.runtimeType}');
    if (image is img.Image) {
      // print('qqqq-$image');
      return image;
    }

    if (image is! CameraImage) {
      throw FormatException('Unsupported image type');
    }

    print('convertImgToRGB-- image.format.group-- ${image.format.group}');

    img.Image imgRGB = img.Image(width: image.width, height: image.height);
    if (image.format.group == ImageFormatGroup.yuv420) {
      imgRGB = YUV420toRGB(image);
      return imgRGB;
    }
    if (image.format.group == ImageFormatGroup.bgra8888) {
      imgRGB = BGRA8888toRGB(image);
      return imgRGB;
    }
    throw FormatException('Unsupported image format: ${image.format.group}');
  }

  Future<List<DetectionResult>> detectWires(dynamic image,
      {String? outputFilePath =
          'outputs/detect_wires_with_yolo_output.jpg'}) async {
    print('detectWires--begin');
    const int resizeW = 640;
    const int resizeH = 640;

    img.Image imgRGB = convertImgToRGB(image);
    img.Image imgResized =
        img.copyResize(imgRGB, width: resizeW, height: resizeH);
    List<double> imgNormalized =
        imgResized.getBytes().map((e) => e / 255.0).toList();

    const int batchSize = 1;
    final int elementsPerDetection = 4 + classes.length;
    const int totalDetections = 8400;
    List<dynamic> input =
        imgNormalized.reshape([batchSize, resizeW, resizeH, 3]);

    List<dynamic> output =
        List.filled(batchSize * elementsPerDetection * totalDetections, 0)
            .reshape([batchSize, elementsPerDetection, totalDetections]);

    _interpreter?.run(input, output);

    List<DetectionResult> results =
        parseOutput(output, batchSize, elementsPerDetection, totalDetections);

    return results;
  }

  void dispose() {
    _interpreter?.close();
  }
}
