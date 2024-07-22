import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_project/models/shop_list.dart';
import 'package:shop_project/ui/pages/main_page.dart';
import 'package:shop_project/ui/pages/login_page.dart';
import 'package:shop_project/models/language_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  // prefs.clear();
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => prefs),
        ChangeNotifierProvider(create: (context) => ShopList()),
        ChangeNotifierProvider(create: (context) => LanguageModel(selected: 0)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: Builder(builder: (context) {
        if (context.read<SharedPreferences>().getString('user-psw') != null) {
          return const MainPage();
        }
        return const LoginPage();
      }),
    );
  }
}
