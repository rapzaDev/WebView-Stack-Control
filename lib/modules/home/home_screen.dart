import 'package:empilhamento/modules/core/presenters/store/core_store.dart';
import 'package:empilhamento/modules/home/home_store.dart';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final CoreStore coreStore;

  const HomeScreen({super.key, required this.coreStore});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    HomeStore store = HomeStore(coreStore: widget.coreStore);

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: store.itemCount(),
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  leading: Image.asset(
                    store.optionImage(index),
                    width: 50,
                    height: 50,
                    fit: BoxFit.contain,
                  ),
                  title: Text(store.optionName(index)),
                  onTap: () => store.goToWebView(context, index),
                ),
              );
            },
          ),
        ),
        if (store.goBackToWebViewVerification())
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton.icon(
              onPressed: () => store.goBackToWebView(context),
              icon: const Icon(Icons.web),
              label: const Text('Return to WebView'),
            ),
          ),
      ],
    );
  }
}
