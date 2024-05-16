import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shop_project/functions/basic_url.dart';

Future<bool> loginRequest(String username, String password) async {
  final request = http.Request('GET', Uri.parse('$basic/user'));
  request.headers['Content-Type'] = 'application/x-www-form-urlencoded';
  request.bodyFields = {"username": username, "psw": password};
  final response = await request.send();
  if (response.statusCode != 200) {
    throw const HttpException("To'g'ri qiymat kiriting !");
  }
  return true;
}
