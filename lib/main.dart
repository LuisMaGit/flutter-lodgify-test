import 'package:flutter/material.dart';
import 'package:lodgify/di/locator.dart';
import 'package:lodgify/ui/resources/app_strings.dart';
import 'package:lodgify/ui/views/home/home.dart';
import 'package:lodgify/ui/views/theme_builder/theme_builder.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      builder: (context, theme) => MaterialApp(
        title: AppStrings.title,
        debugShowCheckedModeBanner: false,
        theme: theme,
        home: const Home(),
      ),
    );
  }
}
