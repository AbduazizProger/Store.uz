import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shop_project/functions/basic_url.dart';

Future<Map<String, dynamic>?> getUser() async {
  final request = http.Request('GET', Uri.parse('$basic/users'));
  final response = await request.send();
  final result = jsonDecode(await response.stream.bytesToString());
  if (response.statusCode == 200) {
    return result[0];
  }
  return null;
}
