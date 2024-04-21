import 'package:gsheets/gsheets.dart';
import 'package:flutter/services.dart';
import 'package:shop_project/models/shop_list.dart';

Future<Product> getItem(
    Worksheet sheet, List<String> barcodes, String code) async {
  final row = await sheet.values.row(barcodes.indexOf(code) + 1);
  return Product(
    name: row[1],
    image: row[1] == '18 plus'
        ? (await rootBundle.load('assets/images/18.png')).buffer.asUint8List()
        : (await rootBundle.load('assets/images/pen.png')).buffer.asUint8List(),
    price: row[3],
    numProduct: int.parse(row[2]),
  );
}
