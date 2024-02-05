import 'package:flutter/material.dart';
import '../config/app_config.dart';

class ImageDisplayWidget extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;

  ImageDisplayWidget({
    required this.imageUrl,
    this.width = 100.0,
    this.height = 100.0,
  });

  @override
  Widget build(BuildContext context) {
    print("Flask Server URL: ${AppConfig.flaskServerUrl}");
    return Container(
      width: width,
      height: height,
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
