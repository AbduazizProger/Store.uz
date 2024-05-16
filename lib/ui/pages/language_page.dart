import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:latin_crillic/latin_crillic.dart';
import 'package:shop_project/models/language_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final language = context.watch<LanguageModel>();
    final prefs = context.watch<SharedPreferences>();
    return Consumer<LanguageModel>(builder: (context, model, widget) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            language.selected == 0
                ? 'Dastur tili'
                : LatinCrillic.toCrillic('Dastur tili'),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
        ),
        backgroundColor: Colors.grey[200],
        body: Column(
          children: [
            InkWell(
              onTap: () {
                model.changeLanguage(0);
                prefs.setString('lang', 'lat');
              },
              child: Container(
                padding: const EdgeInsets.all(14),
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset('assets/images/uzb.png', height: 40),
                        const SizedBox(width: 10),
                        const Text('Lotin', style: TextStyle(fontSize: 18)),
                      ],
                    ),
                    model.selected == 0
                        ? Icon(Icons.radio_button_checked,
                            color: Colors.blue[900])
                        : const Icon(Icons.radio_button_off,
                            color: Colors.grey),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                model.changeLanguage(1);
                prefs.setString('lang', 'cry');
              },
              child: Container(
                padding: const EdgeInsets.all(14),
                margin: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset('assets/images/uzb.png', height: 40),
                        const SizedBox(width: 10),
                        const Text('Крилл', style: TextStyle(fontSize: 18)),
                      ],
                    ),
                    model.selected == 1
                        ? Icon(Icons.radio_button_checked,
                            color: Colors.blue[900])
                        : const Icon(Icons.radio_button_off,
                            color: Colors.grey),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
