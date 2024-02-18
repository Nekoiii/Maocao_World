import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../services/video_uploader.dart';
import './play_video_screen.dart';

class UploadVideoScreen extends StatefulWidget {
  @override
  _UploadVideoScreenState createState() => _UploadVideoScreenState();
}

class _UploadVideoScreenState extends State<UploadVideoScreen> {
  final VideoUploader uploader = VideoUploader();
  final picker = ImagePicker();
  double _uploadProgress = 0.0;

  void _onUploadButtonPressed(BuildContext context) async {
    final XFile? pickedFile =
        await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile == null) return;

    String filePath = pickedFile.path;
    bool processWithPython = false;
    try {
      await uploader.uploadVideo(filePath, (progress) {
        setState(() {
          _uploadProgress = progress;
        });
      }, processWithPython);
    } catch (e) {
      print("Error uploading video: $e");
    }
    setState(() {
      _uploadProgress = 0.0;
    });
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Video uploaded successfully')));
      print('SnackBar shown');

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PlayVideoScreen()),
      );
    }
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
              onPressed: () => _onUploadButtonPressed(context),
              child: const Text('Upload Video (python)'),
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
