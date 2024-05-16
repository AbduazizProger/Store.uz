import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shop_project/models/shop_list.dart';
import 'package:shop_project/functions/basic_url.dart';

Future<Product?> getItem(String barcode) async {
  final request = http.Request('GET', Uri.parse('$basic/products/$barcode'));
  final response = await request.send();
  final result = jsonDecode(await response.stream.bytesToString());
  if (response.statusCode == 200) {
    return Product(
      name: result['name'],
      image: (await rootBundle.load('assets/images/product.jpg'))
          .buffer
          .asUint8List(),
      price: result['price'],
      numProduct: int.parse(result['number']),
    );
  }
  return null;
}
