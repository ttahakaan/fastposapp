import 'package:fastposapp/splash_screen/splash_screen.dart';
import 'package:fastposapp/view/fastpos_webview.dart';
import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Wakelock.enable;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Fast POS',
        home: SplashScreen());
  }
}
