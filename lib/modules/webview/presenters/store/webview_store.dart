import 'package:empilhamento/modules/core/presenters/store/core_store.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebviewStore extends ChangeNotifier {
  final CoreStore core;

  WebviewStore({required this.core});

  // VALUE NOTIFIER

  ValueNotifier<String> currentUrl = ValueNotifier<String>("");

  ValueNotifier<double> progress = ValueNotifier<double>(0);

  late ValueNotifier<InAppWebViewController> controller;

  ValueNotifier<PullToRefreshController> pullToRefreshController =
      ValueNotifier<PullToRefreshController>(PullToRefreshController());

  // WEBVIEW SETTINGS
  InAppWebViewSettings settings = InAppWebViewSettings(
    isInspectable: kDebugMode,
    mediaPlaybackRequiresUserGesture: false,
    allowsInlineMediaPlayback: true,
    iframeAllow: "camera; microphone",
    iframeAllowFullscreen: true,
  );

  // STORE FUNCTIONS

  void didUpdate() async {
    String newUrl = core.lastSelectedUrl.value;

    if (newUrl != currentUrl.value) {
      _updateUrl(newUrl);

      await controller.value.loadUrl(
        urlRequest: URLRequest(
          url: WebUri(
            currentUrl.value,
          ),
        ),
      );
    }
  }

  @override
  dispose() async {
    super.dispose();

    controller.value.dispose();
    pullToRefreshController.value.dispose();
  }

  void init() async {
    _initUrl();

    _pullToRefreshControllerInit();
  }

  void _initUrl() {
    currentUrl.value = "init";

    notifyListeners();
  }

  void _updateUrl(String value) {
    currentUrl.value = value;

    core.urlUpdate(value);
  }

  // INAPPWEBVEW FUNCTIONS

  void _pullToRefreshControllerInit() async {
    pullToRefreshController.value = (kIsWeb ||
            ![TargetPlatform.iOS, TargetPlatform.android]
                .contains(defaultTargetPlatform)
        ? null
        : PullToRefreshController(
            settings: PullToRefreshSettings(
              color: Colors.blue,
            ),
            onRefresh: () async {
              if (defaultTargetPlatform == TargetPlatform.android) {
                await controller.value.reload();
              } else if (defaultTargetPlatform == TargetPlatform.iOS) {
                await controller.value.loadUrl(
                    urlRequest:
                        URLRequest(url: await controller.value.getUrl()));
              }
            },
          ))!;
  }

  void onWebViewCreated(InAppWebViewController webViewController) {
    controller = ValueNotifier<InAppWebViewController>(webViewController);
  }

  void onProgressChanged(InAppWebViewController controller, int progress) {
    if (progress == 100) {
      pullToRefreshController.value.endRefreshing();

      return;
    }
    this.progress.value = progress / 100;
  }

  void onLoadStop(
      InAppWebViewController controller, WebUri? url, bool mounted) async {
    var newUrl = url != null ? url.path : '';

    core.isLoadingChange();

    _updateUrl(newUrl);
  }

  void onPopInvokedWithResult(bool onPop, Object? _) async {
    var url = await controller.value.getUrl();
    var inicio = WebUri('init');

    bool homeVerify = url == inicio;

    if (homeVerify) {
    } else {
      await controller.value.goBack();
    }
    return;
  }

  // GETTERS

  String url() {
    return currentUrl.value;
  }

  bool isLoading() {
    return core.isLoading.value;
  }
}
