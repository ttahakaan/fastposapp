import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:wakelock/wakelock.dart';
import 'package:cool_alert/cool_alert.dart';

class FastPosWebview extends StatefulWidget {
  const FastPosWebview({Key? key}) : super(key: key);

  @override
  State<FastPosWebview> createState() => _FastPosWebviewState();
}

class _FastPosWebviewState extends State<FastPosWebview> {
  @override
  void initState() {
    super.initState();

    // Ekran kapanmasını engelleyen kod
    Wakelock.enable();
  }

  @override
  void dispose() {
    // Ekran kilidini kaldırmaya yarayan kod
    Wakelock.disable();
    super.dispose();
  }

  InAppWebViewController? _webViewController;
  final String _url = 'https://www.fastpos.ai/';

  Future<bool> _onBackPressed() async {
    if (await _webViewController?.canGoBack() ?? false) {
      _webViewController?.goBack();
      return false;
    } else {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          content: Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Positioned(
                top: -50,
                left: 0,
                right: 0,
                child: CircleAvatar(
                  backgroundColor: Colors.indigo.shade800,
                  radius: 30,
                  child: Icon(
                    Icons.warning_rounded,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 50),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Are you sure you want to close the application?',
                      style: TextStyle(
                        color: Colors.indigo,
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        TextButton(
                          child: Text(
                            'No',
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () => Navigator.pop(context, false),
                        ),
                        TextButton(
                          child: Text(
                            'Yes',
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            Navigator.pop(context, true);
                            SystemNavigator.pop(); // uygulamayı kapat
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ).then((value) => value ?? false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: InAppWebView(
            initialUrlRequest: URLRequest(url: Uri.parse(_url)),
            onWebViewCreated: (controller) {
              _webViewController = controller;
            },
            onLoadStart: (controller, url) {},
            onLoadStop: (controller, url) {},
            onProgressChanged: (controller, progress) {},
            shouldOverrideUrlLoading: (controller, navigationAction) async {
              if (navigationAction.request.url!.host == 'www.fastpos.ai') {
                return NavigationActionPolicy.ALLOW;
              }
              return NavigationActionPolicy.CANCEL;
            },
          ),
        ),
      ),
    );
  }
}
