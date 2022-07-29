import 'package:flutter/material.dart';
import 'package:marvel/common/widget/widget.dart';
import 'package:marvel/styles/colors.dart';
import 'package:webviewx/webviewx.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key, required this.url});

  static const String routeName = 'web-view';
  static PageRoute page(String url) => MaterialPageRoute<void>(
        builder: (_) => WebViewPage(
          url: url,
        ),
      );

  final String url;

  @override
  WebViewPageState createState() => WebViewPageState();
}

class WebViewPageState extends State<WebViewPage> {
  late WebViewXController _controller;
  bool _isLoading = true;

  Size get screenSize => MediaQuery.of(context).size;

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
        appBar: const HeroesAppBar(
          withActions: false,
        ),
        body: Stack(
          children: [
            WebViewX(
              height: screenSize.height,
              width: screenSize.width,
              initialContent: widget.url,
              onWebViewCreated: (controller) => _controller = controller,
              onPageStarted: (src) => _showProgress(),
              onPageFinished: (src) => _showProgress(loading: false),
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
