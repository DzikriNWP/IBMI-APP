import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ibmi/widgets/info_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class BmiPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BmiPageState();
  }
}

class _BmiPageState extends State<BmiPage> {
  double? _deviceHeight, _deviceWidth;

  int _age = 21, _weight = 70, _height = 170, _gender = 0;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Center(
      child: CupertinoPageScaffold(
        child: Container(
            height: _deviceHeight! * 0.8,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _ageSelectionContainer(),
                    _weightSelectionContainer(),
                  ],
                ),
                _heightSelectionContainer(),
                _genderSelectionContainer(),
                _calculateBMIbutton(),
              ],
            )),
      ),
    );
  }

  Widget _ageSelectionContainer() {
    return InfoCard(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "age",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              _age.toString(),
              style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.w700,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  width: 50,
                  child: CupertinoDialogAction(
                    child: Icon(CupertinoIcons.minus),
                    onPressed: () {
                      setState(() {
                        _age--;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: CupertinoDialogAction(
                    child: Icon(CupertinoIcons.plus),
                    onPressed: () {
                      setState(() {
                        _age++;
                      });
                    },
                  ),
                ),
              ],
            )
          ],
        ),
        width: _deviceWidth! * 0.45,
        height: _deviceHeight! * 0.2);
  }

  Widget _weightSelectionContainer() {
    return InfoCard(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Weight (kg)",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              _weight.toString(),
              style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.w700,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  width: 50,
                  child: CupertinoDialogAction(
                    child: Icon(CupertinoIcons.minus),
                    onPressed: () {
                      setState(() {
                        _weight--;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: CupertinoDialogAction(
                    child: Icon(CupertinoIcons.plus),
                    onPressed: () {
                      setState(() {
                        _weight++;
                      });
                    },
                  ),
                ),
              ],
            )
          ],
        ),
        width: _deviceWidth! * 0.45,
        height: _deviceHeight! * 0.2);
  }

  Widget _heightSelectionContainer() {
    return InfoCard(
        child: Column(
          children: [
            const Text(
              "Height (cm)",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              _height.toString(),
              style: const TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              width: _deviceWidth! * 0.8,
              child: CupertinoSlider(
                  min: 100,
                  max: 250,
                  divisions: 250,
                  value: _height.toDouble(),
                  onChanged: (_value) {
                    setState(() {
                      _height = _value.toInt();
                    });
                  }),
            )
          ],
        ),
        width: _deviceWidth! * 0.85,
        height: _deviceHeight! * 0.15);
  }

  Widget _genderSelectionContainer() {
    return InfoCard(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Gender",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
            CupertinoSlidingSegmentedControl(
                groupValue: _gender,
                children: const {
                  0: Text("Male"),
                  1: Text("Female"),
                },
                onValueChanged: (_value) {
                  setState(() {
                    _gender = _value as int;
                  });
                })
          ],
        ),
        width: _deviceWidth! * 0.9,
        height: _deviceHeight! * 0.11);
  }

  Widget _calculateBMIbutton() {
    return Container(
      height: _deviceHeight! * 0.07,
      child: CupertinoButton.filled(
          child: const Text("Calculate"),
          onPressed: () {
            //calculate it with if else
            if (_height > 0 && _weight > 0) {
              double bmi = _weight / ((_height / 100) * (_height / 100));
              String result = "";
              if (bmi < 18.5) {
                result = "Underweight";
              } else if (bmi >= 18.5 && bmi < 24.9) {
                result = "Normal weight";
              } else if (bmi >= 25 && bmi < 29.9) {
                result = "Overweight";
              } else {
                result = "Obesity";
              }
              showCupertinoDialog(
                  context: context,
                  builder: (context) {
                    return CupertinoAlertDialog(
                      title: Text("Your BMI is ${bmi.toStringAsFixed(2)}"),
                      content: Text(result),
                      actions: [
                        CupertinoDialogAction(
                          child: Text("OK"),
                          onPressed: () {
                            _saveResults();
                            Navigator.pop(context);
                          },
                        )
                      ],
                    );
                  });
            } else {
              showCupertinoDialog(
                  context: context,
                  builder: (context) {
                    return CupertinoAlertDialog(
                      title: Text("Please enter valid values"),
                      actions: [
                        CupertinoDialogAction(
                          child: Text("OK"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    );
                  });
            }
          }),
    );
  }

  void _saveResults() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> history = prefs.getStringList('bmi_history') ?? [];

    Map<String, dynamic> entry = {
      'age': _age,
      'weight': _weight,
      'height': _height,
      'gender': _gender == 0 ? 'Male' : 'Female',
      'bmi': (_weight / ((_height / 100) * (_height / 100))).toStringAsFixed(2),
      'date': DateTime.now().toIso8601String(),
    };

    history.add(jsonEncode(entry));
    await prefs.setStringList('bmi_history', history);
  }
}
