import 'package:flutter/material.dart';
import 'package:FlutterTask/utils/app_routes.dart';

class AppConfig {
  static final ThemeData appTheme = ThemeData(
    primarySwatch: Colors.blue,
  );

  static final Map<String, WidgetBuilder> appRoutes = AppRoutes.routes;
}
