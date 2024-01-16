import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:fastposapp/view/fastpos_webview.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(170, 35, 49, 100),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          AnimatedSplashScreen(
            splash: Image.asset(
              "assets/takenow.png",
            ),
            duration: 3000,
            splashIconSize: 200,
            nextScreen: FastPosWebview(),
            splashTransition: SplashTransition.fadeTransition,
            backgroundColor: const Color.fromRGBO(170, 35, 49, 100),
          ),
          StreamBuilder(
            stream: Future.delayed(Duration(seconds: 3)).asStream(),
            builder: (context, snapshot) {
              return snapshot.connectionState == ConnectionState.waiting
                  ? Container()
                  : FastPosWebview();
            },
          ),
        ],
      ),
    );
  }
}
