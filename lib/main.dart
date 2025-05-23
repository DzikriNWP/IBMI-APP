import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'pages/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: "IMBI",
      routes: {
        '/': (BuildContext _context) => MainPage(),
      },
      initialRoute: '/',
    );
  }
}
