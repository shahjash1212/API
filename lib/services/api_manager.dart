import 'dart:async';
import 'dart:convert';

import 'package:api_integration_app/constant/strings.dart';
import 'package:api_integration_app/models/newsinfo.dart';
import 'package:http/http.dart' as http;

class API_MANAGER {
  Future<Welcome> getNews() async {
    var client = http.Client();
    var welcomModel;

    try {
      var response = await client.get(Uri.parse(Strings.news_api));
      print("===================");
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = jsonDecode(jsonString);
        Welcome.fromJson(jsonMap);

        welcomModel = Welcome.fromJson(jsonMap);
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
    return welcomModel;
  }
}
