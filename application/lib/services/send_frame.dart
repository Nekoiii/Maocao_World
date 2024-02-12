import '../config/app_config.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:camera/camera.dart';

Future<void> sendFrame(XFile file) async {
  var uri = Uri.parse('${AppConfig.flaskServerUrl}/process_frame');
  var request = http.MultipartRequest('POST', uri)
    ..files.add(await http.MultipartFile.fromPath('frame', file.path));

  var response = await request.send();

  if (response.statusCode == 200) {
    print('Frame processed successfully');
  } else {
    print('Failed to process frame');
  }
}
