import 'package:flutter/material.dart';
import 'package:marvel/styles/colors.dart';
import 'package:marvel/ui/commons/custom_appbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({Key? key, required this.url}) : super(key: key);

  static const String routeName = 'web-view';

  final String url;

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController _controller;
  bool _isLoading = true;

  void _showProgress({bool loading = true}) {
    setState(() {
      _isLoading = loading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await _controller.canGoBack()) {
          await _controller.goBack();
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: Stack(
          children: [
            WebView(
              initialUrl: widget.url,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (controller) => _controller = controller,
              onProgress: (int progress) {
                _showProgress(loading: !(progress == 100));
              },
            ),
            Visibility(
              visible: _isLoading,
              child: const Center(
                child: CircularProgressIndicator(
                  color: red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
