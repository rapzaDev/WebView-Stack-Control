import 'package:flutter/material.dart';

class CoreComponents {
  appBar({
    required BuildContext context,
    required int screenIndex,
    required void Function() navigate,
  }) {
    return screenIndex == 0
        ? AppBarOption.home.component(context, navigate)
        : AppBarOption.webview.component(context, navigate);
  }
}

enum AppBarOption {
  home,
  webview;

  Widget component(
    BuildContext context,
    void Function() navigate,
  ) =>
      switch (this) {
        home => AppBar(
            title: const Text('List of Sites'),
          ),
        webview => AppBar(
            title: const Text('InAppWebView'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                navigate();
              },
            ),
          ),
      };
}
