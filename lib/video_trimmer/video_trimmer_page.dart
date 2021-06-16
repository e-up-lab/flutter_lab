import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lab/video_trimmer/preview_page.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:video_player/video_player.dart';
import 'package:video_trimmer/video_trimmer.dart';

class VideoTrimmerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => VideoTrimmerPageState();
}

class VideoTrimmerPageState extends State<VideoTrimmerPage> {
  final Trimmer _trimmer = Trimmer();

  bool loaded = false;

  double _startValue = 0.0;

  double _endValue = 0.0;

  void _openFile() async {
    FilePickerResult result =
        await FilePicker.platform.pickFiles(type: FileType.video);
    if (result == null) return;

    await _trimmer.loadVideo(videoFile: File(result.files.single.path));
    setState(() {
      loaded = true;
    });
  }

  void _onChangeStart(value) {
    print("onChangeStart $value");
    _startValue = value;
  }

  void _onChangeEnd(value) {
    print("onChangeEnd $value");
    _endValue = value;
  }

  void _onChangePlaybackState(value) {
    print("onChangePlayback $value");
    setState(() {});
  }

  Widget _loadedWidget() {
    return LayoutBuilder(
      builder: (context, size) {
        return Flex(
          direction: Axis.vertical,
          children: [
            VideoViewer(),
            TrimEditor(
              viewerWidth: size.maxWidth,
              viewerHeight: 50,
              onChangeStart: _onChangeStart,
              onChangeEnd: _onChangeEnd,
              onChangePlaybackState: _onChangePlaybackState,
              // showDuration: true,
            ),
            Wrap(
              spacing: 16,
              children: [
                ElevatedButton(
                  child: Text("GO"),
                  onPressed: () async {
                    bool state = await _trimmer.videPlaybackControl(
                        startValue: _startValue, endValue: _endValue);
                    print("================$state");
                  },
                ),
                ElevatedButton(
                  child: Text("Save"),
                  onPressed: () async {
                    final value = await _trimmer.saveTrimmedVideo(
                        ffmpegCommand: '-vf "fps=30,scale=720:-1"',
                        customVideoFormat: ".mp4",
                        startValue: _startValue,
                        endValue: _endValue);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => PreviewPage(path: value)));
                  },
                )
              ],
            )
          ],
        );
      },
    );
  }

  Widget _unloadedWidget() {
    return ElevatedButton(
      child: Text("打开视频文件"),
      onPressed: _openFile,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: (loaded ? _loadedWidget() : _unloadedWidget()).center(),
      ),
    );
  }
}
