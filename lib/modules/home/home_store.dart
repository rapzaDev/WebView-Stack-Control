import 'package:empilhamento/utils/utils.dart';
import 'package:flutter/material.dart';

class HomeStore {
  /// Vai salvar a ultima url acessada.
  ValueNotifier<String> lastSelectedUrl = ValueNotifier<String>("");

  void update(String url) {
    lastSelectedUrl.value = url;
  }

  int itemCount() {
    return webviewURLs.values.length;
  }

  String optionImage(int index) {
    return webviewURLs.values[index].img;
  }

  String optionName(int index) {
    return webviewURLs.values[index].name;
  }

  String optionUrl(int index) {
    return webviewURLs.values[index].url;
  }
}
