import 'package:empilhamento/modules/core/presenters/store/core_store.dart';

import 'package:empilhamento/utils/utils.dart';
import 'package:flutter/material.dart';

class HomeStore {
  final CoreStore coreStore;

  HomeStore({required this.coreStore});

  // --------- GETTERS ---------

  int itemCount() {
    return WebviewURLs.values.length;
  }

  String optionImage(int index) {
    return WebviewURLs.values[index].img;
  }

  String optionName(int index) {
    return WebviewURLs.values[index].name;
  }

  String optionUrl(int index) {
    return WebviewURLs.values[index].url;
  }

  String getLastUrl() {
    return coreStore.lastSelectedUrl.value;
  }

  // --------- NAVIGATION ---------

  Future<void> goToWebView(BuildContext context, int index) async {
    String newUrl = optionUrl(index);

    coreStore.urlUpdate(newUrl);

    coreStore.navigate();
  }

  bool goBackToWebViewVerification() {
    return coreStore.lastSelectedUrl.value.isNotEmpty;
  }

  Future<void> goBackToWebView(BuildContext context) async {
    coreStore.isLoadingChange();
    coreStore.navigate();
  }
}
