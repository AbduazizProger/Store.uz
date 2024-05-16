// import 'dart:convert';
import 'dart:convert';
// import 'dart:io'; // Import dart:convert to use jsonEncode
import 'package:http/http.dart' as http;
import 'package:shop_project/functions/basic_url.dart';

Future<void> buy(List<String> codes, String user, List<int> numbers) async {
  final url = Uri.parse('$basic/orders');

  final date = DateTime.now().toIso8601String();
  final userid = user;
  final barcodes = codes;
  final allNumbers = numbers;

  final payload = jsonEncode({
    'barcodes': barcodes,
    'date': date,
    'userid': userid,
    'numbers': allNumbers,
  });

  final headers = <String, String>{
    'Content-Type': 'application/json',
  };

  try {
    final response = await http.put(url, headers: headers, body: payload);
    print(response.body);
  } catch (e) {
    print('Error: $e');
  }
}
