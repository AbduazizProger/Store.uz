import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_project/ui/pages/main_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_project/functions/requests/login_request.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = TextEditingController();
    final pswController = TextEditingController();
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
        backgroundColor: Colors.grey[100],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 353,
            child: Column(
              children: [
                const Text(
                  'Store.uz ga xush kelibsiz',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 20),
                TextField(
                  autofocus: true,
                  controller: userController,
                  style: const TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    filled: true,
                    hintText: 'Foydalanuvchi nomi',
                    fillColor: Colors.grey[300],
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    contentPadding: const EdgeInsets.all(20),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  obscureText: true,
                  controller: pswController,
                  style: const TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    filled: true,
                    hintText: 'Parol',
                    fillColor: Colors.grey[300],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(20),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  if (userController.text.isNotEmpty &&
                      pswController.text.isNotEmpty) {
                    loginRequest(userController.text, pswController.text).then(
                      (value) {
                        context.read<SharedPreferences>().setString(
                              'user-psw',
                              '${userController.text};${pswController.text}',
                            );
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) {
                            return const MainPage();
                          }),
                        );
                      },
                      onError: (error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              error.message == "To'g'ri qiymat kiriting !"
                                  ? error.message
                                  : "Iltimos internetingizni tekshiring !",
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
                child: Container(
                  width: 353,
                  height: 62,
                  decoration: BoxDecoration(
                    color: Colors.blue[900],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Text(
                      'Kirish',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.grey[100],
    );
  }
}
