import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../services/video_uploader.dart';

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

      await uploader.uploadVideo(filePath, (progress) {
        setState(() {
          _uploadProgress = progress;
        });
      });

      setState(() {
        _uploadProgress = 0.0;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Video uploaded successfully')));
    } else {
      print('No video selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Video'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_uploadProgress > 0)
              LinearProgressIndicator(value: _uploadProgress),
            ElevatedButton(
              onPressed: () => _onUploadButtonPressed(context),
              child: Text('Upload Video'),
            ),
          ],
        ),
      ),
    );
  }
}
