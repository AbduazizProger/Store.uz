import 'package:gsheets/gsheets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_project/models/shop_list.dart';
import 'package:shop_project/functions/get_item.dart';
import 'package:shop_project/functions/open_sheet.dart';
import 'package:shop_project/ui/widgets/no_internet.dart';
import 'package:shop_project/ui/widgets/main_content.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Future<void> scanBarcodeNormal(
    Worksheet sheet,
    List<String> barcodes,
    ShopList shopList,
  ) async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.BARCODE,
      );
      final product = await getItem(
        sheet,
        barcodes,
        barcodeScanRes,
      );
      shopList.addProduct(barcodeScanRes, product);
    } catch (e) {
      print(e);
    }
  }

  void scanThensend() {
    scanBarcodeNormal(
      context.read<Worksheet>(),
      context.read<List<String>>(),
      context.read<ShopList>(),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool hasInternet = false;
    return Consumer<ShopList>(builder: (context, basket, widget) {
      return FutureBuilder<dynamic>(
          future: openSheet(),
          builder: (context, snapshot) {
            hasInternet = snapshot.hasData;
            return Scaffold(
              appBar: AppBar(
                title: const Text(
                  'Store.uz',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                centerTitle: true,
                backgroundColor: hasInternet ? Colors.grey[200] : Colors.white,
              ),
              backgroundColor: hasInternet ? Colors.grey[200] : Colors.white,
              // floatingActionButtonLocation:
              //     FloatingActionButtonLocation.centerDocked,
              body: Builder(builder: (context) {
                if (snapshot.hasData) {
                  return MultiProvider(
                    providers: [
                      Provider(create: (context) => snapshot.data[0]),
                      Provider(create: (context) => snapshot.data[1]),
                    ],
                    child: MainContent(basket: basket),
                  );
                } else if (snapshot.hasError) {
                  return const NoInternet();
                }
                return const Center(child: CircularProgressIndicator());
              }),
              floatingActionButton: hasInternet
                  ? Padding(
                      padding: const EdgeInsets.all(20),
                      child: FloatingActionButton(
                        onPressed: scanThensend,
                        child: const Icon(Icons.barcode_reader),
                      ),
                    )
                  : null,
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: 0,
                onTap: (index) {},
                items: const [
                  BottomNavigationBarItem(
                    label: 'Bosh sahifa',
                    icon: Icon(Icons.home),
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
    });
  }
}
