import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';
import '../config/app_config.dart';

class VideoUploader {
  Future<void> uploadVideo(
      String filePath, Function(double) onUploadProgress) async {
    var controller = StreamController<List<int>>();
    var uri = Uri.parse('${AppConfig.flaskServerUrl}/upload_video');
    var request = http.MultipartRequest('POST', uri);

    var file = File(filePath);
    var length = await file.length();
    var totalByteSent = 0;

    // 将文件数据添加到控制器
    file.openRead().listen(
          (data) => controller.add(data),
          onDone: () => controller.close(),
          onError: (e) => controller.addError(e),
        );

    // 监听文件流，每次发送数据时都更新 totalByteSent 和上传进度
    request.files.add(http.MultipartFile(
      'video',
      controller.stream.transform<List<int>>(StreamTransformer.fromHandlers(
        handleData: (data, sink) {
          totalByteSent += data.length;
          onUploadProgress(totalByteSent / length);
          sink.add(data);
        },
        handleError: (error, stackTrace, sink) {
          sink.addError(error);
        },
        handleDone: (sink) {
          sink.close();
        },
      )),
      length,
      filename: filePath.split("/").last,
    ));

    var response = await request.send();

    if (response.statusCode == 200) {
      print('Video upload successfully');
    } else {
      print('Video upload failed');
    }

    await controller.close();
  }
}
