import 'package:gsheets/gsheets.dart';

Future<List<String>> getBarcodes(Worksheet sheet) async {
  return sheet.values.column(1);
}
