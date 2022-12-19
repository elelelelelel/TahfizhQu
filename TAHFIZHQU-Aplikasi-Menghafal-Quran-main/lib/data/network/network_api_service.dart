import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:tahfizh_qu_app/data/api_execption.dart';
import 'package:tahfizh_qu_app/data/network/base_api_service.dart';

class NetworkApiServices extends BaseApiServices {
  @override
  Future getApiResoponse(String url, Map<String, String>? headers) async {
    dynamic responseJson;
    try {
      final response = await http
          .get(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);

      //
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  @override
  Future postApiResponse(
      String url, Object? body, Map<String, String>? headers) async {
    dynamic responseJson;
    try {
      final response = await http
          .post(Uri.parse(url), body: body, headers: headers)
          .timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);

      //
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 500:
      case 404:
        throw UnauthorisedException(response.body.toString());
      default:
        throw FetchDataException(
            'Error accured while communicating with server' +
                'with status code' +
                response.statusCode.toString());
    }
  }
}
