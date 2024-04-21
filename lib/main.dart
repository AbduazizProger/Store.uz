import 'package:gsheets/gsheets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_project/models/language_model.dart';
import 'package:shop_project/models/shop_list.dart';
import 'package:shop_project/ui/pages/main_page.dart';
import 'package:shop_project/functions/open_sheet.dart';
import 'package:shop_project/ui/widgets/no_internet.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
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
      home: FutureBuilder<dynamic>(
        future: openSheet(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MultiProvider(
              providers: [
                Provider(create: (context) => snapshot.data[0] as Worksheet),
                Provider(create: (context) => snapshot.data[1] as List<String>),
              ],
              child: const MainPage(),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/logo.png', height: 33),
                    const Text(
                      ' Store.uz',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
                    ),
                  ],
                ),
                centerTitle: true,
              ),
              backgroundColor: Colors.white,
              body: Builder(
                builder: (context) {
                  if (snapshot.hasError) {
                    return const NoInternet();
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            );
          }
        },
      ),
    );
  }
}
