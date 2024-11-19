import 'package:empilhamento/modules/webview/presenters/store/webview_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:empilhamento/modules/core/presenters/store/core_store.dart';

class WebViewScreen extends StatefulWidget {
  final CoreStore coreStore;

  const WebViewScreen({super.key, required this.coreStore});

  @override
  WebViewScreenState createState() => WebViewScreenState();
}

class WebViewScreenState extends State<WebViewScreen> {
  late WebviewStore store;

  @override
  void initState() {
    super.initState();

    store = WebviewStore(core: widget.coreStore);
    store.init();
  }

  @override
  void didUpdateWidget(covariant WebViewScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    store.didUpdate();
  }

  @override
  void dispose() {
    super.dispose();

    store.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: store.onPopInvokedWithResult,
      child: Stack(
        children: [
          ListenableBuilder(
            listenable: store,
            builder: (context, child) {
              return InAppWebView(
                initialSettings: store.settings,
                initialUrlRequest: URLRequest(url: WebUri(store.url())),
                onWebViewCreated: store.onWebViewCreated,
                onProgressChanged: store.onProgressChanged,
                pullToRefreshController: store.pullToRefreshController.value,
                onLoadStop: (controller, url) =>
                    store.onLoadStop(controller, url, mounted),
              );
            },
          ),
          if (store.isLoading())
            Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
