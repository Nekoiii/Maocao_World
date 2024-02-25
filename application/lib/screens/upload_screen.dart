import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:mime/mime.dart';
import 'dart:typed_data';

import '../services/file_uploader.dart';
import '../services/extract_and_process_video.dart';
import '../services/detect_wires_with_yolo.dart';
import './play_video_screen.dart';

class UploadScreen extends StatefulWidget {
  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final FileUploader uploader = FileUploader();
  final picker = ImagePicker();
  double _uploadProgress = 0.0;

  void _uploadVideo(bool isProcessWithPython) async {
    final XFile? pickedFile =
        await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile == null) return;
    await uploader.uploadVideo(pickedFile, 'video', (progress) {
      setState(() {
        _uploadProgress = progress;
      });
    }, isProcessWithPython);

    setState(() {
      _uploadProgress = 0.0;
    });

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Video uploaded successfully')));
      print('SnackBar shown');

      extractAndProcessVideo(pickedFile.path);
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => PlayVideoScreen()),
      // );
    }
  }

  void _uploadImage() async {
    print('_uploadImage--begin');
    final processWithModel = 'YOLO';
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    final mimeType = lookupMimeType(pickedFile.path);
    print("xxxx--- MIME type: $mimeType");

    Uint8List fileBytes = await pickedFile.readAsBytes();
    img.Image? image = img.decodeImage(fileBytes);

    if (processWithModel == 'YOLO') {
      final DetectWiresWithYolo wiresDetector = DetectWiresWithYolo();
      await wiresDetector.detectWires(image,
          outputFilePath: 'outputs/single_photo_with_yolo.jpg');
    }
    print('_uploadImage--end');
  }

  void _onUploadButtonPressed(BuildContext context,
      {bool isVideo = true, bool isProcessWithPython = false}) async {
    isVideo ? _uploadVideo(isProcessWithPython) : _uploadImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Video'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_uploadProgress > 0)
              LinearProgressIndicator(value: _uploadProgress),
            ElevatedButton(
              onPressed: () =>
                  _onUploadButtonPressed(context, isProcessWithPython: true),
              child: const Text('Upload Video (python)'),
            ),
            ElevatedButton(
              onPressed: () =>
                  _onUploadButtonPressed(context, isProcessWithPython: false),
              child: const Text('Upload Video (dart)'),
            ),
            ElevatedButton(
              onPressed: () => _onUploadButtonPressed(context,
                  isVideo: false, isProcessWithPython: false),
              child: const Text('Upload Image (dart)'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PlayVideoScreen()),
                );
              },
              child: const Text('Play Video'),
            ),
          ],
        ),
      ),
    );
  }
}
