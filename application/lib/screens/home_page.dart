import 'package:flutter/material.dart';
import '../widgets/image_display_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('Welcome to Maocao World !',
                  style: Theme.of(context).textTheme.bodyText1),
              ImageDisplayWidget(
                  imageUrl:
                      'http://localhost:8000/static/images/maocao-logo-1.png'),
            ],
          ),
        ));
  }
}
