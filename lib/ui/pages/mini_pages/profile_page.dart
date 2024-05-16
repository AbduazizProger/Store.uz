import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:latin_crillic/latin_crillic.dart';
import 'package:shop_project/models/language_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_project/ui/widgets/profile_component.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final prefs = context.read<SharedPreferences>();
    return Consumer<LanguageModel>(builder: (context, language, widget) {
      return Column(
        children: [
          Container(
            margin: const EdgeInsets.all(15),
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.account_circle,
                      color: Colors.grey,
                      size: 73,
                    ),
                    const SizedBox(width: 7),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          language.selected == 0
                              ? prefs.getString('user-psw')!.split(';')[0]
                              : LatinCrillic.toCrillic(
                                  prefs.getString('user-psw') != null
                                      ? prefs
                                          .getString('user-psw')!
                                          .split(';')[0]
                                      : 'Login qilinmagan',
                                ),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          language.selected == 0
                              ? "Profil ma'lumotlari"
                              : LatinCrillic.toCrillic("Profil ma'lumotlari"),
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 17),
                        ),
                      ],
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.keyboard_arrow_right, size: 32),
                ),
              ],
            ),
          ),
          const ProfileComponent(
            name: 'Dastur tili',
            image: 'assets/images/language.png',
          ),
          const ProfileComponent(
            name: 'Biz haqimizda',
            image: 'assets/images/about_us.png',
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: ProfileComponent(
              name: 'Chiqish',
              color: Colors.red,
              image: 'assets/images/exit.png',
            ),
          ),
        ],
      );
    });
  }
}
