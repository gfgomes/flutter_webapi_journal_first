import 'dart:convert';

import 'package:flutter_webapi_first_course/services/http_interceptors.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/intercepted_client.dart';

class JournalService {
  static const String url = "http://10.1.9.107:3000/";
  static const resource = "learnhttp/";

  http.Client client =
      InterceptedClient.build(interceptors: [LoggerInterceptor()]);

  String getUrl() {
    print("$url$resource");
    return "$url$resource";
  }

  void register(String content) async {
    var response = await client.post(
      Uri.parse(getUrl()),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'content': content}),
    );
    if (response.statusCode == 200) {
      print('Registro bem-sucedido: ${response.body}');
    } else {
      print('Falha no registro: ${response.statusCode}');
    }
  }

  Future<String> get() async {
    http.Response response = await client.get(Uri.parse(getUrl()));
    print(response.body);
    return response.body;
  }
}
