import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:latin_crillic/latin_crillic.dart';
import 'package:shop_project/models/language_model.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final language = context.read<LanguageModel>();
    const about = """""";
    return Scaffold(
      appBar: AppBar(
        title: Text(
          language.selected == 0
              ? 'Biz haqimizda'
              : LatinCrillic.toCrillic('Biz haqimizda'),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: ListView(
        children: [
          Container(
            height: 170,
            margin: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Image.asset(
              'assets/images/logo.png',
              height: double.infinity,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(vertical: 13),
            margin: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              children: [
                const Text(
                  'Store.uz',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    language.selected == 0
                        ? about
                        : LatinCrillic.toCrillic(about),
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[900],
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
