import 'package:flutter/material.dart';

import 'app_route.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AppRoute.home,
      routes: AppRoute.routes,
    );
  }
}
