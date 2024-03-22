import 'package:flutter/material.dart';

class ShopList extends ChangeNotifier {
  Map<String, Product> productMap = {
    // '1234567654213456': Product(
    //   name: 'Pen',
    //   image: Image.asset('assets/images/pen.jpg', width: 70),
    //   price: '1500',
    //   numProduct: 150,
    // ),
  };

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
}

class Product {
  final String name;
  final Image image;
  final String price;
  int numOrdered = 1;
  final int numProduct;

  Product({
    required this.name,
    required this.image,
    required this.price,
    required this.numProduct,
  });
}
