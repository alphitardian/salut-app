import 'dart:io';

import 'package:flutter/material.dart';
import 'package:salut_app_flutter/theme.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SalukulScreen extends StatefulWidget {
  static const String id = 'SalukulScreen';
  @override
  _SalukulScreenState createState() => _SalukulScreenState();
}

class _SalukulScreenState extends State<SalukulScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Salukul',
          style: kAppBarrTextStyle,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: <Widget>[
          WebView(
            initialUrl: 'https://salukul.gkjsalut.id/',
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (finish) {
              setState(() {
                isLoading = false;
              });
            },
            navigationDelegate: (NavigationRequest request) {
              if (request.url.startsWith('https://api.whatsapp.com/') ||
                  request.url.startsWith('https://www.whatsapp.com/') ||
                  request.url.startsWith('whatsapp://send/')) {
                launch(request.url);
                print(request.url);
                return NavigationDecision.prevent;
              }
              print('Cannot Navigate ${request.url}');
              return NavigationDecision.prevent;
            },
          ),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    backgroundColor: mainColor,
                  ),
                )
              : Stack(),
        ],
      ),
    );
  }
}
