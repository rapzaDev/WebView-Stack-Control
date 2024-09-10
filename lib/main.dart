import 'package:flutter/material.dart';
import 'webview/inappwebview.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WebView App',
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/webview': (context) => WebViewScreen(
              url: ModalRoute.of(context)!.settings.arguments as String,
            ),
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? lastSelectedUrl;

  final List<Map<String, String>> sites = [
    {
      'name': 'Construtor de Vendas CRM',
      'url': 'https://cvcrm.com.br',
      'image': 'assets/images/cvcrm_logo.png'
    },
    {
      'name': 'Google',
      'url': 'https://www.google.com',
      'image': 'assets/images/google_logo.png'
    },
    {
      'name': 'YouTube',
      'url': 'https://www.youtube.com',
      'image': 'assets/images/youtube_logo.png'
    },
    {
      'name': 'Spotify',
      'url': 'https://www.spotify.com',
      'image': 'assets/images/spotify_logo.png'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Sites'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: sites.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    leading: Image.asset(
                      sites[index]['image']!,
                      width: 50,
                      height: 50,
                      fit: BoxFit.contain,
                    ),
                    title: Text(sites[index]['name']!),
                    onTap: () {
                      if ((lastSelectedUrl != null) &&
                          lastSelectedUrl != sites[index]['url']) {
                        setState(() {
                          lastSelectedUrl = sites[index]['url'];
                        });

                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => WebViewScreen(
                              url: sites[index]['url']!,
                            ),
                          ),
                          (Route<dynamic> route) => true,
                        );
                      } else {
                        setState(() {
                          lastSelectedUrl = sites[index]['url'];
                        });

                        Navigator.pushNamed(
                          context,
                          '/webview',
                          arguments: sites[index]['url'],
                        );
                      }
                    },
                  ),
                );
              },
            ),
          ),
          if (lastSelectedUrl != null)
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/webview',
                    arguments: lastSelectedUrl!,
                  );
                },
                icon: Icon(Icons.web),
                label: Text('Return to WebView'),
              ),
            ),
        ],
      ),
    );
  }
}
