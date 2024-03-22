import 'package:gsheets/gsheets.dart';
import 'package:shop_project/functions/credentials.dart';
import 'package:shop_project/functions/get_barcodes.dart';

Future<List<dynamic>> openSheet() async {
  final gsheets = GSheets(credentials);
  final ss = await gsheets.spreadsheet(spreadsheetId);
  final sheet = ss.worksheetByTitle('Store1');
  final barcodes = await getBarcodes(sheet!);
  return [sheet, barcodes];
}
