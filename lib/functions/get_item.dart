import 'package:gsheets/gsheets.dart';
import 'package:flutter/material.dart';
import 'package:shop_project/models/shop_list.dart';

Future<Product> getItem(
    Worksheet sheet, List<String> barcodes, String code) async {
  final row = await sheet.values.row(barcodes.indexOf(code) + 1);
  return Product(
    name: row[1],
    image: row[1] == '18 plus'
        ? Image.asset('assets/images/18.png', width: 70, height: 70)
        : Image.asset('assets/images/pen.png', width: 70, height: 70),
    price: row[3],
    numProduct: int.parse(row[2]),
  );
}