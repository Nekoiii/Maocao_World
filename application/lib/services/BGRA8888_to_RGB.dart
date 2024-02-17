import 'package:image/image.dart' as img;
import 'package:camera/camera.dart';

img.Image BGRA8888toRGB(CameraImage imgCamera) {
  print('BGRA8888toRGB--');
  final width = imgCamera.width;
  final height = imgCamera.height;
  final imgRGB = img.Image(width: width, height: height);

  final bgra = imgCamera.planes[0].bytes;

  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      final index = (x + y * width) * 4; // BGRA格式每个像素4个字节
      final B = bgra[index];
      final G = bgra[index + 1];
      final R = bgra[index + 2];

      imgRGB.setPixelRgb(x, y, R, G, B);
    }
  }

  return imgRGB;
}
