import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart'; // Package for handling app links
import 'package:webview_flutter/webview_flutter.dart'; // Package for handling webview

void main() {
  runApp(const RpWebPage());
}

class RpWebPage extends StatefulWidget {
  const RpWebPage({
    Key? key,
  }) : super(key: key);
  final String link = 'https://billpay.setu.co/1234';

  @override
  State<RpWebPage> createState() => _RpWebPageState();
}

class _RpWebPageState extends State<RpWebPage> {
  late WebViewController controller;
  bool isButtonClicked = false;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (progress) {},
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onNavigationRequest: ((NavigationRequest request) {
          // Handle UPI app specific intents
          if (isButtonClicked && request.url.contains('upi') ||
              request.url.contains('phonepe')) {
            launchUrlString(request.url, mode: LaunchMode.externalApplication);
            return NavigationDecision
                .prevent; // Prevent the WebView from navigating to the UPI intent
          }
          return NavigationDecision.navigate; // Allow navigation to other URLs
        }),
      ));
  }

  void _loadUrl() {
    setState(() {
      isButtonClicked = true;
    });
    controller.loadRequest(Uri.parse(widget.link));
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bill Payments'),
      ),
      body: Column(
        children: [
          if (!isButtonClicked)
            ElevatedButton(
              onPressed: _loadUrl,
              child: Text('Load app'),
            ),
          Expanded(
            child: isButtonClicked
                ? WebViewWidget(controller: controller)
                : Container(),
          ),
        ],
      ),
    );
  }
}
