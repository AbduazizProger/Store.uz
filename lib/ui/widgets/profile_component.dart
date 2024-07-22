import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:latin_crillic/latin_crillic.dart';
import 'package:shop_project/models/language_model.dart';
import 'package:shop_project/ui/pages/about_page.dart';
import 'package:shop_project/ui/pages/language_page.dart';
import 'package:shop_project/ui/pages/wallet_page.dart';

class ProfileComponent extends StatelessWidget {
  const ProfileComponent({
    super.key,
    this.color,
    required this.name,
    required this.image,
  });

  final String name;
  final String image;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final language = context.watch<LanguageModel>();
    return GestureDetector(
      onTap: () {
        if (name == 'Chiqish') {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  language.selected == 0
                      ? 'Chiqish'
                      : LatinCrillic.toCrillic('Chiqish'),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                content: Text(
                  language.selected == 0
                      ? 'Rostan chiqishni hoxlaysizmi'
                      : LatinCrillic.toCrillic('Rostan chiqishni hoxlaysizmi'),
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 18),
                ),
                actionsAlignment: MainAxisAlignment.spaceBetween,
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(
                        Colors.green,
                      ),
                    ),
                    child: Text(
                      language.selected == 0
                          ? "Yo'q"
                          : LatinCrillic.toCrillic("Йоq"),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      exit(0);
                    },
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(
                        Colors.red,
                      ),
                    ),
                    child: Text(
                      language.selected == 0
                          ? 'Ha'
                          : LatinCrillic.toCrillic('Ha'),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              );
            },
          );
        } else if (name == 'Hamyon') {
          Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
            return const WalletPage();
          }));
        } else if (name == 'Biz haqimizda') {
          Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
            return const AboutPage();
          }));
        } else if (name == 'Dastur tili') {
          Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
            return const LanguagePage();
          }));
        }
      },
      child: Container(
        padding: const EdgeInsets.all(13),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Image.asset(image, height: 45),
            const SizedBox(width: 13),
            Text(
              language.selected == 0 ? name : LatinCrillic.toCrillic(name),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
                fontSize: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}
