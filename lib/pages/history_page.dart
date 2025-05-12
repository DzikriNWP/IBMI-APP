import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class HistoryPage extends StatefulWidget {
  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<Map<String, dynamic>> _history = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  void _loadHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> rawList = prefs.getStringList('bmi_history') ?? [];
    setState(() {
      _history = rawList
          .map((item) => jsonDecode(item) as Map<String, dynamic>)
          .toList()
          .reversed
          .toList(); // tampilkan yang terbaru di atas
    });
  }

  void _clearHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('bmi_history');
    setState(() {
      _history.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("BMI History"),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _history.isEmpty
                  ? Center(child: Text("No history found."))
                  : ListView.builder(
                      itemCount: _history.length,
                      itemBuilder: (context, index) {
                        final item = _history[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 6.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: CupertinoColors.systemGrey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Date: ${item['date']}",
                                    style: TextStyle(fontSize: 12)),
                                SizedBox(height: 4),
                                Text("BMI: ${item['bmi']}",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                Text(
                                    "Age: ${item['age']}, Gender: ${item['gender']}"),
                                Text(
                                    "Height: ${item['height']} cm, Weight: ${item['weight']} kg"),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
            if (_history.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: CupertinoButton.filled(
                  child: Text("Clear History"),
                  onPressed: _clearHistory,
                ),
              ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
