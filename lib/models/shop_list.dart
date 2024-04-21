import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_project/functions/add_zeros.dart';

class ShopList extends ChangeNotifier {
  Map<String, Product> productMap = {};

  void firstAdd() async {
    productMap['1234567654213456'] = Product(
      name: 'Pen',
      image:
          (await rootBundle.load('assets/images/pen.png')).buffer.asUint8List(),
      price: '1500',
      numProduct: 150,
    );
    notifyListeners();
  }

  ShopList() {
    firstAdd();
  }

  void addProduct(String code, Product product) {
    productMap[code] = product;
    notifyListeners();
  }

  void changeNum(String code, {bool shouldAdd = true}) {
    if (shouldAdd) {
      productMap[code]!.numOrdered++;
    } else if (productMap[code]!.numOrdered > 1) {
      productMap[code]!.numOrdered--;
    }
    notifyListeners();
  }

  void buyAll(SharedPreferences prefs) {
    final date = DateTime.now();
    List<String> buying = [
      """"${addZeros('${date.day}.${date.month}.${date.year}', false)}__${addZeros('${date.hour}:${date.minute}', true)}__${(prefs.getStringList('history') ?? []).length}" """,
    ];
    for (var key in productMap.keys) {
      buying.add(productMap[key]!.toJson(key));
    }
    prefs.setStringList(
      'history',
      (prefs.getStringList('history') ?? [])..add("""$buying"""),
    );
    productMap.clear();
    notifyListeners();
  }
}

class Product {
  final String name;
  final String price;
  int numOrdered = 1;
  final int numProduct;
  final Uint8List image;

  Product({
    required this.name,
    required this.image,
    required this.price,
    required this.numProduct,
  });

  String toJson(String barcode) {
    return """{
      "name": "$name",
      "price": $price,
      "barcode": "$barcode",
      "numOrdered": $numOrdered,
      "numProduct": $numProduct,
      "image": "${base64Encode(image)}"
    }""";
  }
}
