import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';

class VideoUploader {
  Future<void> uploadVideo(
      String filePath, Function(double) onUploadProgress) async {
    var uri = Uri.parse('http://localhost:8000/upload');
    var request = http.MultipartRequest('POST', uri);

    var file = File(filePath);
    var length = await file.length();

    var controller = StreamController<List<int>>();
    var totalByteSent = 0;

    // 监听文件流，每次发送数据时都更新 totalByteSent 和上传进度
    controller.stream
        .transform<List<int>>(StreamTransformer.fromHandlers(
          handleData: (data, sink) {
            sink.add(data);
            totalByteSent += data.length;
            onUploadProgress(totalByteSent / length);
          },
          handleError: (error, stackTrace, sink) {
            sink.addError(error);
          },
          handleDone: (sink) {
            sink.close();
          },
        ))
        .pipe(file.openWrite());

    request.files.add(http.MultipartFile(
      'video',
      file.openRead().cast(),
      length,
      filename: filePath.split("/").last,
    ));

    var response = await request.send();

    if (response.statusCode == 200) {
      print('Video uploaded successfully');
    } else {
      print('Video upload failed');
    }

    await controller.close();
  }
}
