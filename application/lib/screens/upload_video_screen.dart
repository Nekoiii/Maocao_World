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
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);

    if (pickedFile != null) {
      String filePath = pickedFile.path;

      print('aaa-1');
      try {
        await uploader.uploadVideo(filePath, (progress) {
          setState(() {
            _uploadProgress = progress;
          });
        });
      } catch (e) {
        print("Error uploading video: $e");
      }
      print('aaa-2');
      setState(() {
        _uploadProgress = 0.0;
      });
      print('aaa-3');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Video uploaded successfully')));
        print('SnackBar should be shown');

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PlayVideoScreen()),
        );
      }
    } else {
      print('No video selected.');
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
              child: const Text('Upload Video'),
            ),
          ],
        ),
      ),
    );
  }
}
