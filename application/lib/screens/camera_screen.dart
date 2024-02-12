//Flutter使用camera开发相机功能:  https://www.duidaima.com/Group/Topic/Flutter/2209
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:camera/camera.dart';

import '../services/send_frame.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  bool _isSendingFrames = false;
  Timer? _timer;

  int _selectedCameraIndex = 0;
  bool _cameraExist = true;

  @override
  void initState() {
    super.initState();
    _initCameras();
  }

  Future<void> _initCameras() async {
    _cameras = await availableCameras();
    print('_initCameras---_cameras$_cameras');
    if (_cameras != null && _cameras!.isNotEmpty) {
      _cameraController = CameraController(
        _cameras![_selectedCameraIndex],
        ResolutionPreset.medium,
      );
      _cameraController!.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    } else {
      setState(() {
        _cameraExist = false;
      });
    }
  }

  void _startSendingFrames() {
    print('_startSendingFrames---');
    if (_cameraController != null && _cameraController!.value.isInitialized) {
      const fps = Duration(milliseconds: 1000 ~/ 24); // 24 frames per second
      _timer = Timer.periodic(fps, (timer) async {
        final image = await _takePicture();
        if (image != null) {
          sendFrame(image);
        }
      });
      setState(() => _isSendingFrames = true);
    }
  }

  Future<XFile?> _takePicture() async {
    if (!_cameraController!.value.isInitialized) {
      print('Error: select a camera first.');
      return null;
    }

    try {
      final file = await _cameraController!.takePicture();
      return file;
    } catch (e) {
      print('takePicture error: $e');
      return null;
    }
  }

  void _stopSendingFrames() {
    _timer?.cancel();
    setState(() => _isSendingFrames = false);
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return Scaffold(
        appBar: AppBar(title: Text('Camera View')),
        body: Center(
          child: _cameraExist
              ? const CircularProgressIndicator()
              : const Text('No camera is available'),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Camera View')),
      body: CameraPreview(_cameraController!),
      floatingActionButton: FloatingActionButton(
        onPressed: _isSendingFrames ? _stopSendingFrames : _startSendingFrames,
        child: Icon(
            !_cameraExist && _isSendingFrames ? Icons.stop : Icons.camera_alt),
      ),
    );
  }
}
