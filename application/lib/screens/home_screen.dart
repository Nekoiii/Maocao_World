import 'package:flutter/material.dart';
import '../widgets/image_display_widget.dart';
import '../screens/upload_video_screen.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Maocao World'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('Welcome to Maocao World !',
                  style: Theme.of(context).textTheme.bodyText2),
              ImageDisplayWidget(
                  imageUrl:
                      // 'http://localhost:8000/static/images/maocao-logo-1.png'),
                      'http://localhost:5000/static/images/maocao-logo-1.png'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UploadVideoScreen()),
                  );
                },
                child: Text('Go to Upload Video'),
              ),
            ],
          ),
        ));
  }
}
