import 'package:empilhamento/modules/core/presenters/ui/core_screen.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const CoreScreen(),
      },
    ),
  );
}
