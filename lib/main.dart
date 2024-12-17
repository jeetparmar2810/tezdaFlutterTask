import 'package:FlutterTask/utils/app_config.dart';
import 'package:FlutterTask/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'utils/app_routes.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appTitle,
      initialRoute: AppRoutes.login,
      routes: AppConfig.appRoutes,
      theme: AppConfig.appTheme,
    );
  }
}
