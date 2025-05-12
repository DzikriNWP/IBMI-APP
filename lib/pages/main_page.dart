import 'package:flutter/cupertino.dart';
import 'package:ibmi/pages/bmi_page.dart';
import 'package:ibmi/pages/history_page.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {
  final List<Widget> _tabs = [
    BmiPage(),
    HistoryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.time),
            label: 'History',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          builder: (context) {
            return CupertinoPageScaffold(
              navigationBar: const CupertinoNavigationBar(
                middle: Text('IBMI'),
              ),
              child: SafeArea(child: _tabs[index]),
            );
          },
        );
      },
    );
  }
}
