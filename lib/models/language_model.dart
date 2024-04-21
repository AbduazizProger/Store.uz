import 'package:flutter/material.dart';

class LanguageModel extends ChangeNotifier {
  int selected;

  LanguageModel({required this.selected});

  void changeLanguage(int index) {
    selected = index;
    notifyListeners();
  }
}
