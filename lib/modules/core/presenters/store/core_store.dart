import 'package:flutter/material.dart';

class CoreStore extends ChangeNotifier {
  /// Screen Pagination index
  ValueNotifier<int> screenIndex = ValueNotifier<int>(0);

  ValueNotifier<String> lastSelectedUrl = ValueNotifier<String>("");

  /// whenever the user chooses an option from the initial list
  /// or go back to home screen,
  /// this variable will be set.
  ValueNotifier<bool> isLoading = ValueNotifier<bool>(true);

  void isLoadingChange() {
    isLoading.value = !isLoading.value;

    notifyListeners();
  }

  void navigate() {
    switch (screenIndex.value) {
      case 0:
        ++screenIndex.value;

        break;
      case 1:
        --screenIndex.value;

        isLoadingChange();

        break;
    }

    notifyListeners();

    return;
  }

  void urlUpdate(String url) async {
    lastSelectedUrl.value = url;
  }
}
