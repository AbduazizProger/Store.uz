import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_project/models/shop_list.dart';

class ChangeNumber extends StatelessWidget {
  const ChangeNumber({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Consumer<ShopList>(builder: (context, basket, widget) {
      return Row(
        children: [
          IconButton(
            onPressed: () {
              basket.changeNum(
                basket.productMap.keys.elementAt(index),
                shouldAdd: false,
              );
            },
            icon: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                color: Colors.blue[900],
              ),
              child: const Icon(
                Icons.remove,
                color: Colors.white,
              ),
            ),
          ),
          Text(
            '${basket.productMap.values.elementAt(index).numOrdered}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          IconButton(
            onPressed: () {
              basket.changeNum(basket.productMap.keys.elementAt(index));
            },
            icon: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                color: Colors.blue[900],
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
    });
  }
}
