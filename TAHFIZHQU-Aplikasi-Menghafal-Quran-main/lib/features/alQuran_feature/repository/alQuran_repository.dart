import 'package:tahfizh_qu_app/common/app_url.dart';
import 'package:tahfizh_qu_app/data/network/base_api_service.dart';
import 'package:tahfizh_qu_app/data/network/network_api_service.dart';
import 'package:tahfizh_qu_app/features/alQuran_feature/models/surah_model.dart';

class ALQuranRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> getListOfSurah() async {
    try {
      dynamic response =
          await _apiServices.getApiResoponse('${AppUrl.baseQuranApi}surah', {});
      return response = SurahModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
