import 'package:image/image.dart' as img;
import 'package:camera/camera.dart';

img.Image YUV420toRGB(CameraImage imgCamera) {
  print('YUV420toRGB--');
  final width = imgCamera.width;
  final height = imgCamera.height;

  final uvRowStride = imgCamera.planes[1].bytesPerRow;
  final uvPixelStride = imgCamera.planes[1].bytesPerPixel;

  final yBuffer = imgCamera.planes[0].bytes;
  final uBuffer = imgCamera.planes[1].bytes;
  final vBuffer = imgCamera.planes[2].bytes;

  final imgRGB = img.Image(width: width, height: height);

  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      final uvIndex =
          uvPixelStride! * (x / 2).floor() + uvRowStride * (y / 2).floor();
      final index = y * width + x;

      final Y = yBuffer[index];
      final U = uBuffer[uvIndex] - 128;
      final V = vBuffer[uvIndex] - 128;

      var R = (Y + V * 1.370705).round();
      var G = (Y - (U * 0.337633 + V * 0.698001)).round();
      var B = (Y + U * 1.732446).round();

      R = R.clamp(0, 255);
      G = G.clamp(0, 255);
      B = B.clamp(0, 255);

      imgRGB.setPixelRgb(x, y, R, G, B);
    }
  }

  return imgRGB;
}
