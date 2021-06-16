import 'package:flutter/cupertino.dart';

import 'home/home_page.dart';
import 'video_trimmer/video_trimmer_page.dart';

class AppRoute {
  static String home = '/';

  static String videoTrimmer = '/video-trimmer';

  static Map<String, WidgetBuilder> routes = {
    home: (_) => HomePage(),
    videoTrimmer: (_) => VideoTrimmerPage()
  };
}
