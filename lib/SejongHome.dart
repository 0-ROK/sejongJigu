import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:path/path.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'dart:async';
import 'crud.dart';
// import 'package:intl/intl.dart';
import 'dart:io';


class SejongHome extends StatefulWidget {
  @override
  _SejongHomeState createState() => _SejongHomeState();
}

class _SejongHomeState extends State<SejongHome> {
  var _progress = Progress();
  @override
  void initState() {
    super.initState();
    read().then((value) {
      setState(() {
        _progress = value;
      });
    });
  }

  // 파일 읽기
  Future read() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      return Progress.fromJson(jsonDecode(await File(dir.path + '/progress.txt').readAsString()));
    } catch (e) {
      return Progress(date: DateTime.now(), howManyFailed: 0, daily: 0.0, weekly: 0.0, qt: false, word: false, pray: false, association: false, evangelize: false);
    }
  }
  // 파일 쓰기
  Future write(var _progress) async {
    final dir = await getApplicationDocumentsDirectory();
    return File(dir.path + '/progress.txt')
        .writeAsString(jsonEncode(_progress().toJson()));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 5,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Neumorphic(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Neumorphic(
                  style: NeumorphicStyle(
                    boxShape: NeumorphicBoxShape.circle(),
                    shape: NeumorphicShape.concave,
                    depth: 20,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //벌금
                        NeumorphicText(
                          'Pay',
                          style: NeumorphicStyle(
                            color: Colors.indigo,
                          ),
                          textStyle: NeumorphicTextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(5.0),
                              child: NeumorphicText(
                                (_progress.howManyFailed * 500).toString(),
                                style: NeumorphicStyle(
                                  color: Colors.blue,
                                ),
                                textStyle: NeumorphicTextStyle(
                                  fontSize: 80,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5.0),
                              child: NeumorphicText(
                                '₩',
                                style: NeumorphicStyle(
                                  color: Colors.indigo,
                                ),
                                textStyle: NeumorphicTextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ),
          ),
          Expanded(
            flex: 1,
            child: Neumorphic(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('Daily'),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child:  NeumorphicProgress(
                            style: ProgressStyle(
                              accent: Colors.indigo,
                              variant: Colors.blue,
                            ),
                            percent: _progress.daily,
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('Weekly'),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child:  NeumorphicProgress(
                            style: ProgressStyle(
                              accent: Colors.purple,
                              variant: Colors.pinkAccent,
                            ),
                            percent: _progress.weekly,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              flex: 2,
              child: Neumorphic(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // 말씀, 교제, 전도
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: NeumorphicCheckbox(
                                    value: _progress.word,
                                    style: NeumorphicCheckboxStyle(
                                      selectedColor: Colors.red,
                                    ),
                                    onChanged: (value) {:
                                      setState(() {
                                        _progress.word = value;
                                        if (value == true) {
                                          _progress.daily += 0.2;
                                          _progress.weekly += 0.0285;
                                          _progress.howManyFailed -= 1;
                                        }
                                        else {
                                          _progress.daily-= 0.2;
                                          _progress.weekly -= 0.0285;
                                          _progress.howManyFailed += 1;
                                        }
                                        write(_progress);
                                      });
                                    }),
                              ),
                              Text('말씀'),
                            ],
                          ),
                        ),

                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: NeumorphicCheckbox(
                                    value: _progress.association,
                                    style: NeumorphicCheckboxStyle(
                                      selectedColor: Colors.green,
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        _progress.association = value;
                                        if (value == true) {
                                          _progress.daily += 0.2;
                                          _progress.weekly += 0.0285;
                                          _progress.howManyFailed -= 1;
                                        }
                                        else {
                                          _progress.daily-= 0.2;
                                          _progress.weekly -= 0.0285;
                                          _progress.howManyFailed += 1;
                                        }
                                        write(_progress);
                                      });
                                    }),
                              ),
                              Text('교제'),
                            ],
                          ),
                        ),

                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: NeumorphicCheckbox(
                                    value: _progress.evangelize,
                                    style: NeumorphicCheckboxStyle(
                                      selectedColor: Colors.orange,
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        _progress.evangelize = value;
                                        if (value == true) {
                                          _progress.daily += 0.2;
                                          _progress.weekly += 0.0285;
                                          _progress.howManyFailed -= 1;
                                        }
                                        else {
                                          _progress.daily-= 0.2;
                                          _progress.weekly -= 0.0285;
                                          _progress.howManyFailed += 1;
                                        }
                                        write(_progress);
                                      });
                                    }),
                              ),
                              Text('전도'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // 큐티, 기도
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: NeumorphicCheckbox(
                                    value: _progress.qt,
                                    style: NeumorphicCheckboxStyle(
                                      selectedColor: Colors.purple,
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        _progress.qt = value;
                                        if (value == true) {
                                          _progress.daily += 0.2;
                                          _progress.weekly += 0.0285;
                                          _progress.howManyFailed -= 1;
                                        }
                                        else {
                                          _progress.daily-= 0.2;
                                          _progress.weekly -= 0.0285;
                                          _progress.howManyFailed += 1;
                                        }
                                        write(_progress);
                                      });
                                    }),
                              ),
                              Text('QT'),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: NeumorphicCheckbox(
                                    value: _progress.pray,
                                    style: NeumorphicCheckboxStyle(
                                      selectedColor: Colors.deepPurpleAccent,
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        _progress.pray = value;
                                        if (value == true) {
                                          _progress.daily += 0.2;
                                          _progress.weekly += 0.0285;
                                          _progress.howManyFailed -= 1;
                                        }
                                        else {
                                          _progress.daily-= 0.2;
                                          _progress.weekly -= 0.0285;
                                          _progress.howManyFailed += 1;
                                        }
                                        write(_progress);
                                      });
                                    }),
                              ),
                              Text('🙏'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
          ),
        ],
      ),
    );
  }
}
s
