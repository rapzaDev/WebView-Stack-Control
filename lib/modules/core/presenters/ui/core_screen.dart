import 'package:empilhamento/modules/core/components/core_components.dart';
import 'package:empilhamento/modules/core/presenters/store/core_store.dart';
import 'package:empilhamento/modules/home/home_screen.dart';
import 'package:empilhamento/modules/webview/presenters/ui/inappwebview.dart';
import 'package:flutter/material.dart';

class CoreScreen extends StatefulWidget {
  const CoreScreen({super.key});

  @override
  State<CoreScreen> createState() => _CoreScreenState();
}

class _CoreScreenState extends State<CoreScreen> {
  CoreStore store = CoreStore();

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: store,
      builder: (context, child) => Scaffold(
        appBar: CoreComponents().appBar(
          context: context,
          screenIndex: store.screenIndex.value,
          navigate: store.navigate,
        ),
        body: IndexedStack(
          index: store.screenIndex.value,
          children: [
            HomeScreen(coreStore: store),
            WebViewScreen(coreStore: store),
          ],
        ),
      ),
    );
  }
}
