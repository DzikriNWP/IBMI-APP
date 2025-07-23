import 'package:flutter/cupertino.dart';
import 'package:ibmi/theme_provider.dart';
import 'package:provider/provider.dart';

import 'pages/main_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Gunakan Consumer untuk mendengarkan perubahan tema
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return CupertinoApp(
          title: "IMBI",
          // Atur tema berdasarkan state dari provider
          theme: CupertinoThemeData(
            brightness:
                themeProvider.isDarkMode ? Brightness.dark : Brightness.light,
          ),
          routes: {
            '/': (BuildContext _context) => MainPage(),
          },
          initialRoute: '/',
        );
      },
    );
  }
}
