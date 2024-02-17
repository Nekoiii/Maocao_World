import '../config/app_config.dart';
import 'package:flutter/material.dart';

import '../widgets/image_display_widget.dart';
import '../screens/upload_video_screen.dart';
import '../screens/play_video_screen.dart';
import '../screens/camera_screen.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Maocao World'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('Welcome to Maocao World !',
                  style: Theme.of(context).textTheme.bodyMedium),
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                child: Image.asset(
                  'assets/images/maocao-logo-1.png',
                  fit: BoxFit.scaleDown,
                ),
                // child:ImageDisplayWidget(
                //     imageUrl:
                //         '${AppConfig.flaskServerUrl}/static/images/maocao-logo-1.png'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UploadVideoScreen()),
                  );
                },
                child: const Text('Go to Upload Video'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PlayVideoScreen()),
                  );
                },
                child: const Text('Play Video'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CameraScreen()),
                  );
                },
                child: const Text('Open Camera'),
              )
            ],
          ),
        ));
  }
}
