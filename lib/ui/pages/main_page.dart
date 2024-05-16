import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_project/models/shop_list.dart';
import 'package:shop_project/ui/pages/login_page.dart';
import 'package:shop_project/ui/widgets/no_internet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_project/functions/requests/get_item.dart';
import 'package:shop_project/functions/requests/login_request.dart';
import 'package:shop_project/ui/pages/mini_pages/history_page.dart';
import 'package:shop_project/ui/pages/mini_pages/main_content.dart';
import 'package:shop_project/ui/pages/mini_pages/profile_page.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool? hasInternet;

  @override
  void initState() {
    super.initState();
    _checkUser().then((value) => setState(() {}));
  }

  Future<void> _checkUser() async {
    final usrPsw =
        context.read<SharedPreferences>().getString('user-psw')!.split(';');
    loginRequest(usrPsw[0], usrPsw[1]).then((value) {
      hasInternet = true;
      setState(() {});
    }, onError: (e) {
      if (e.message == "To'g'ri qiymat kiriting !") {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("To'g'ri qiymat kiriting !")),
        );
      } else {
        hasInternet = false;
        setState(() {});
      }
    });
  }

  int currentBar = 0;
  Future<void> scanBarcodeNormal(ShopList shopList) async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.BARCODE,
      );
      final product = await getItem(barcodeScanRes);
      if (product != null) {
        shopList.addProduct(barcodeScanRes, product);
      }
    } catch (e) {
      // print(e);
    }
  }

  void scanThensend(ShopList shopList) {
    scanBarcodeNormal(shopList);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ShopList>(builder: (context, basket, widget) {
      return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png', height: 33),
              const Text(
                ' Store.uz',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
              ),
            ],
          ),
          backgroundColor:
              hasInternet ?? false ? Colors.grey[100] : Colors.white,
        ),
        backgroundColor: hasInternet ?? false ? Colors.grey[100] : Colors.white,
        body: Builder(
          builder: (context) {
            if (hasInternet ?? false) {
              if (currentBar == 0) {
                return Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    MainContent(basket: basket),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: basket.productMap.isNotEmpty
                          ? InkWell(
                              onTap: () {
                                basket
                                    .buyAll(context.read<SharedPreferences>());
                                setState(() {});
                              },
                              child: Container(
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: Colors.blue[900],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text(
                                  'Sotib olish',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(),
                    ),
                  ],
                );
              } else if (currentBar == 2) {
                return const HistoryPage();
              } else {
                return const ProfilePage();
              }
            } else if (!(hasInternet ?? true)) {
              return const NoInternet();
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentBar,
          onTap: (index) {
            if (index == 1) {
              scanThensend(basket);
            } else {
              currentBar = index;
              setState(() {});
            }
          },
          selectedItemColor: Colors.blue[900],
          unselectedItemColor: Colors.grey[600],
          items: const [
            BottomNavigationBarItem(
              label: 'Bosh sahifa',
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: 'Skaner',
              icon: Icon(Icons.barcode_reader),
            ),
            BottomNavigationBarItem(
              label: 'Tarix',
              icon: Icon(Icons.history_toggle_off),
            ),
            BottomNavigationBarItem(
              label: 'Profil',
              icon: Icon(Icons.person),
            ),
          ],
        ),
      );
    });
  }
}
