import 'package:empilhamento/modules/home/home_store.dart';
import 'package:empilhamento/modules/webview/inappwebview.dart';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var store = HomeStore();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Sites'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: store.itemCount(),
              itemBuilder: (context, index) {
                return ValueListenableBuilder<String>(
                    valueListenable: store.lastSelectedUrl,
                    builder: (context, value, child) {
                      debugPrint("value:  $value");

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
                          onTap: () {
                            if (store.lastSelectedUrl.value.isNotEmpty &&
                                store.lastSelectedUrl.value !=
                                    store.optionUrl(index)) {
                              store.update(
                                store.optionUrl(index),
                              );

                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      WebViewScreen(
                                    url: store.optionUrl(index),
                                  ),
                                ),
                                (Route<dynamic> route) => true,
                              );
                            } else {
                              store.update(
                                store.optionUrl(index),
                              );

                              Navigator.pushNamed(
                                context,
                                '/webview',
                                arguments: store.optionUrl(index),
                              );
                            }
                          },
                        ),
                      );
                    });
              },
            ),
          ),
          if (store.lastSelectedUrl.value.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/webview',
                    arguments: store.lastSelectedUrl.value,
                  );
                },
                icon: const Icon(Icons.web),
                label: const Text('Return to WebView'),
              ),
            ),
        ],
      ),
    );
  }
}
