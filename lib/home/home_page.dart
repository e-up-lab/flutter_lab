import 'package:flutter/material.dart';
import 'package:flutter_lab/app_route.dart';
import 'package:styled_widget/styled_widget.dart';

class HomePage extends StatelessWidget {
  static Map<String, String> menus = {'Video Trimmer': AppRoute.videoTrimmer};

  @override
  Widget build(BuildContext context) {
    var children = menus.keys
        .map((e) => ElevatedButton(
              child: Text(e),
              onPressed: () => Navigator.of(context).pushNamed(menus[e]),
            ))
        .toList();
    return Scaffold(
      body: Wrap(
        children: children,
      ).center().parent(({child}) => SafeArea(
            child: child,
          )),
    );
  }
}
