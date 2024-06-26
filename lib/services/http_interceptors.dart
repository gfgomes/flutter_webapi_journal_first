import 'package:http_interceptor/http_interceptor.dart';
import 'package:logger/logger.dart';

class LoggerInterceptor implements InterceptorContract {
  var logger = Logger();

  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    print("----- Request -----");
    print(data.toString());
    logger.v(
        "Requisição para ${data.baseUrl}\nCabeçalhos: ${data.headers}\nCorpo: ${data.body}");
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    if (data.statusCode ~/ 100 == 2) {
      logger.i(
          "Resposta de ${data.url}\n${data.headers}\n${data.statusCode}\n ${data.body}");
    } else {
      logger.e(
          "Resposta de ${data.url}\n${data.headers}\n${data.statusCode}\n ${data.body}");
    }
    return data;
  }
}
