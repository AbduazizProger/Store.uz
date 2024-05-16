import 'package:flutter/material.dart';
import 'package:shop_project/models/shop_list.dart';
import 'package:shop_project/ui/widgets/sale_item.dart';

class MainContent extends StatelessWidget {
  const MainContent({super.key, required this.basket});

  final ShopList basket;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: basket.productMap.length,
      itemBuilder: (context, index) => SaleItem(index: index, basket: basket),
    );
  }
}
