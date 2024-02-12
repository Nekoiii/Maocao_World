import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../services/get_video.dart';

class PlayVideoScreen extends StatefulWidget {
  @override
  _PlayVideoScreenState createState() => _PlayVideoScreenState();
}

class _PlayVideoScreenState extends State<PlayVideoScreen> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(GetVideo.getVideoUri())
      ..initialize().then((_) {
        setState(() {});
        _controller.addListener(_updatePlayPauseIcon);
      }).catchError((error) {
        print("Video player initialization error: $error");
      });
    ;
  }

  void _updatePlayPauseIcon() {
    if (!_controller.value.isPlaying &&
        _controller.value.position == _controller.value.duration) {
      setState(() {
        _isPlaying = false;
      });
    } else {
      setState(() {
        _isPlaying = _controller.value.isPlaying;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Play Video'),
      ),
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          });
        },
        child: Icon(
          _isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
