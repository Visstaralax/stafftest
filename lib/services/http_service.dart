import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../login/model/login_response.dart';

class HttpService<T> {
  final String baseUrl;
  final String info;
  Map<String,String> params = {};

  HttpService({required this.baseUrl, required this.info});

  Future fetchData(T Function(dynamic json) fromJson) async {
    //deberia de ser http.post
    final response = await http.get(
      Uri.parse(baseUrl),
      //headers: {'Content-Type': 'application/json'},
      //body: jsonEncode(params),
    );
    var decoded = await rootBundle.loadString('json/data.json');
    final Map<String, dynamic> jsonMap = jsonDecode(decoded);
    if (response.statusCode == 200) {
      print ("OK");
      //final decoded = json.decode(response.body) as Map<String, dynamic>;
      await simulateDelay();
      return fromJson(jsonMap);
    } else {
      throw Exception("HttpService: Error al cargar los datos de $info");
    }
  }
}

Future<void> simulateDelay() async {
  await Future.delayed(Duration(seconds: 3));
}
