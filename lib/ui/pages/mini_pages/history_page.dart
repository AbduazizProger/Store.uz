import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_project/ui/widgets/day_history_item.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final history =
        context.read<SharedPreferences>().getStringList('history') ?? [];
    final historyList = history.map((e) => jsonDecode(e)).toList();
    final historyDay = {};
    for (var i = 0; i < historyList.length; i++) {
      if (historyDay.containsKey(historyList[i][0].split('__')[0])) {
        historyDay[historyList[i][0].split('__')[0]].add(
          historyList[i]..removeAt(0),
        );
      } else {
        historyDay[historyList[i][0].split('__')[0]] = [];
        historyDay[historyList[i][0].split('__')[0]].add(
          historyList[i]..removeAt(0),
        );
      }
    }
    return ListView.builder(
      itemCount: historyDay.keys.length,
      itemBuilder: (context, index) {
        return DayHistoryItem(
          date: historyDay.keys.elementAt(index),
          historyItem: historyDay[historyDay.keys.elementAt(index)],
        );
      },
    );
  }
}
