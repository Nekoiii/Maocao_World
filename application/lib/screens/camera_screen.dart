//Flutter使用camera开发相机功能:  https://www.duidaima.com/Group/Topic/Flutter/2209
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:camera/camera.dart';

import '../services/detect_wires_with_yolo.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final DetectWiresWithYolo _wiresDetector = DetectWiresWithYolo();
  CameraController? _cameraController;
  List<CameraDescription> _cameras = [];
  bool showBoundingBoxes = false;
  bool _isProcessingImage = false;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    _cameras = await availableCameras();
    if (_cameras.isEmpty) {
      print('No camera is found!');
      return;
    }
    _cameraController = CameraController(
      _cameras![0], // Select the first camera
      ResolutionPreset.medium,
    );
    await _cameraController!.initialize();
    setState(() {});
  }

  void _startDetection() {
    if (_cameraController!.value.isStreamingImages) return;

    _cameraController?.startImageStream((CameraImage image) async {
      if (_isProcessingImage) return;
      _isProcessingImage = true;

      List<DetectionResult> detections =
          await _wiresDetector.detectWires(image);
      _isProcessingImage = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      appBar: AppBar(title: Text('Detect Wires')),
      body: CameraPreview(_cameraController!),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera),
        onPressed: _startDetection,
      ),
    );
  }

  @override
  void dispose() {
    _cameraController?.stopImageStream();
    _cameraController?.dispose();
    _wiresDetector.dispose();
    super.dispose();
  }
}
