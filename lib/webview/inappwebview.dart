import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

final keepAlive = InAppWebViewKeepAlive();

class WebViewScreen extends StatefulWidget {
  final String url;

  WebViewScreen({required this.url});

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen>
    with AutomaticKeepAliveClientMixin {
  InAppWebViewController? webViewController;
  String? currentUrl;

  @override
  void initState() {
    super.initState();
    currentUrl = widget.url;
  }

  @override
  void didUpdateWidget(covariant WebViewScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.url != oldWidget.url) {
      setState(() {
        currentUrl = widget.url;
      });
      webViewController?.loadUrl(
          urlRequest: URLRequest(url: WebUri(currentUrl!)));
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(
        context); // Chama super.build() para garantir o comportamento do KeepAlive

    return Scaffold(
      appBar: AppBar(
        title: Text('InAppWebView'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.popUntil(context, ModalRoute.withName('/'));
          },
        ),
      ),
      body: InAppWebView(
        keepAlive: keepAlive,
        initialUrlRequest: URLRequest(url: WebUri(currentUrl ?? widget.url)),
        onWebViewCreated: (controller) {
          webViewController = controller;
        },
        onLoadStop: (controller, url) async {
          if (mounted) {
            setState(() {
              currentUrl = url.toString();
            });
          }
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true; // Ativa a preservação do estado com KeepAlive
}
