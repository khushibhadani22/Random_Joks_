import 'dart:convert';
import 'package:http/http.dart' as http;

import 'Model.dart';

class APIHelper {
  APIHelper._();
  static final APIHelper apiHelper = APIHelper._();

  Future<RanDom?> fetchData() async {
    String api = "https://api.chucknorris.io/jokes/random";

    http.Response res = await http.get(Uri.parse(api));

    if (res.statusCode == 200) {
      Map decodedData = jsonDecode(res.body);

      RanDom random = RanDom.fromJson(json: decodedData);
      return random;
    }
    return null;
  }
}
