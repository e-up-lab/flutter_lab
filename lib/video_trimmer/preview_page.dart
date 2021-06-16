import 'dart:io';

import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:video_player/video_player.dart';

class PreviewPage extends StatefulWidget {
  final String path;

  PreviewPage({@required this.path});

  @override
  State<StatefulWidget> createState() => PreviewPageState();
}

class PreviewPageState extends State<PreviewPage> {
  VideoPlayerController _controller;

  bool loaded = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(this.widget.path));
    _controller.initialize().then((value) {
      setState(() {
        loaded = true;
        _controller.play();
      });
    });
  }

  Widget _loaded() {
    return VideoPlayer(_controller);
  }

  Widget _unloaded() {
    return Text("loading ${this.widget.path}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (loaded ? _loaded() : _unloaded()),
    );
  }
}
