import 'package:http/http.dart' as http;

class InternetHelper {
  static String url = "http://www.mocky.io/v2/5d565297300000680030a986";

  static Future<String> getEmploy() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        print(response.body);
        return response.body;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
