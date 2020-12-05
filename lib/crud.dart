import 'package:sejongjigu/SejongHome.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Progress {

  DateTime date;
  int howManyFailed;
  double daily;
  double weekly;
  bool qt;
  bool word;
  bool pray;
  bool association;
  bool evangelize;

  Progress({this.date, this.howManyFailed, this.daily, this.weekly, this.qt, this.word, this.pray, this.association, this.evangelize});

  Progress.fromJson(Map<String, dynamic> json)
      : date = json['date'],
        howManyFailed = json['howManyFailed'],
        daily = json['daily'],
        weekly = json['weekly'],
        qt = json['qt'],
        word = json['word'],
        pray = json['pray'],
        association = json['association'],
        evangelize = json['evangelize'];



  Map<String, dynamic> toJson() {
    return {
      'date' : date,
      'howManyFailed' : howManyFailed,
      'daily' : daily,
      'weekly' : weekly,
      'qt' : qt,
      'word' : word,
      'pray' : pray,
      'association' : association,
      'evangelize' : evangelize,
    };
  }
}
