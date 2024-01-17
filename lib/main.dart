import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fastposapp/splash_screen/splash_screen.dart';
import 'package:fastposapp/view/fastpos_webview.dart';
import 'package:wakelock/wakelock.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Wakelock.enable;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fast POS',
      home: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.landscape) {
            return SplashScreen();
          } else {
            return Scaffold(
              body: Center(
                child: Text('The app can only be used in landscape mode.'),
              ),
            );
          }
        },
      ),
    );
  }
}
