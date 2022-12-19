abstract class BaseApiServices {
  Future<dynamic> getApiResoponse(String url, Map<String, String>? headers);
  Future<dynamic> postApiResponse(
      String url, Object? body, Map<String, String>? headers);
}
