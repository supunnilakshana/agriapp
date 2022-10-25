import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:agriapp/constants/constraints.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:webview_flutter/webview_flutter.dart';

class NewsWebView extends StatefulWidget {
  @override
  _NewsWebViewState createState() => _NewsWebViewState();
}

class _NewsWebViewState extends State<NewsWebView> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  late WebViewController controller;
  final Completer<WebViewController> _controllerCompleter =
      Completer<WebViewController>();

  DateTime prebackpress = DateTime.now();
  Future<bool> _onWillPop(BuildContext context) async {
    print("--------------------------------------------------------");

    prebackpress = DateTime.now();

    if (await controller.canGoBack()) {
      print("true");
      controller.goBack();
      return Future.value(false);
    } else {
      print("false");
      // AwesomeDialog(
      //   context: context,
      //   dialogType: DialogType.WARNING,
      //   animType: AnimType.BOTTOMSLIDE,
      //   headerAnimationLoop: false,
      //   title: "Exit",
      //   desc: "Are you sure you want to exit?",
      //   btnCancelText: "No",
      //   btnOkText: "Yes",
      //   btnCancelColor: Color(0xffc5c5c9),
      //   btnCancelOnPress: () {
      //     return;
      //   },
      //   btnOkOnPress: () {

      //   },
      // )..show();
      Navigator.pop(context);
      return Future.value(false);
      // return Future.value(true);
    }
  }

  _launchURL(String url) async {
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(),
          title: Text("News"),
          centerTitle: true,
          backgroundColor: kPrimaryColordark,
          elevation: 0,
        ),
        body: Container(
          width: size.width,
          height: size.height,
          child: WebView(
            initialUrl: "https://araliyarice.com/paddy-cultivation/",
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              controller = webViewController;
            },
            navigationDelegate: (NavigationRequest request) {
              print(request.url);
              if (request.url.contains('whatsapp:') ||
                  (request.url.contains('tel:'))) {
                launch(request.url);
                return NavigationDecision.prevent;
              } else {
                return NavigationDecision.navigate;
              }
            },
          ),
        ),
      ),
    );
  }

  _loadHtmlFromAssets() async {
    controller.clearCache();
    String fileText =
        await rootBundle.loadString('assets/res/vitaminview.html');
    controller.loadUrl(Uri.dataFromString(fileText,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }
}

















































  /*  prebackpress = DateTime.now();
 DateTime prebackpress = DateTime.now();
    final timegap = DateTime.now().difference(prebackpress);

    final cantExit = timegap >= Duration(seconds: 2);
      if (cantExit) {

        //show snackbar
        final snack = SnackBar(
          content: Text('Press Back button again to Exit'),
          duration: Duration(seconds: 2),
        );
        ScaffoldMessenger.of(context).showSnackBar(snack);
        return false;
      } else {
        return true;
      } */

