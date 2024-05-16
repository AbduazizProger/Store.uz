import 'package:http/http.dart' as http;

Future<bool> checkInternet() async {
  try {
    await http.Request('GET', Uri.http('example.com')).send();
    return true;
  } catch (e) {
    return false;
  }
}
