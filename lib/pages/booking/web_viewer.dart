import 'package:flutter/material.dart';
import 'package:toyota/utils/utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewer extends StatefulWidget {
  const WebViewer({super.key});

  static const String routeName = '/web-viewer';
  @override
  State<WebViewer> createState() => _WebViewerState();
}

class _WebViewerState extends State<WebViewer> {
  WebViewController? controller;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final url = ModalRoute.of(context)!.settings.arguments as String?;
      controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(const Color(0x00000000))
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress) {
              // Update loading bar.
            },
            onPageStarted: (String url) {
              showLoader();
            },
            onPageFinished: (String url) {
              dismissLoader();
            },
          ),
        )
        ..loadRequest(Uri.parse(url ?? ""));
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Завсарын түүх'),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: controller != null ? WebViewWidget(controller: controller!) : SizedBox(),
    );
  }
}
