import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop_project/models/shop_list.dart';
import 'package:shop_project/ui/widgets/change_number.dart';

class SaleItem extends StatelessWidget {
  const SaleItem({super.key, required this.index, required this.basket});

  final int index;
  final ShopList basket;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 98,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              basket.productMap.values.elementAt(index).image,
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      basket.productMap.values.elementAt(index).name,
                      style: const TextStyle(fontSize: 18),
                    ),
                    Text(
                      '${basket.productMap.values.elementAt(index).price} sum',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          CupertinoIcons.cube_box_fill,
                          color: Colors.grey,
                        ),
                        Text(
                          '${basket.productMap.values.elementAt(index).numProduct}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          ChangeNumber(index: index),
        ],
      ),
    );
  }
}
