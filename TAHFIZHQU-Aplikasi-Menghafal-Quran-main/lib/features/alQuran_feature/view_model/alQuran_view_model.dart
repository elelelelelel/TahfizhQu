import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:tahfizh_qu_app/data/response/api_response.dart';
import 'package:tahfizh_qu_app/features/alQuran_feature/models/surah_model.dart';
import 'package:tahfizh_qu_app/features/alQuran_feature/repository/alQuran_repository.dart';
import 'package:tahfizh_qu_app/utils/utils.dart';

class AlQuranViewModel with ChangeNotifier {
  final _aLQuranRepository = ALQuranRepository();

  ApiResponse<SurahModel> listOfSurah = ApiResponse.loading();

  setListOfSurah(ApiResponse<SurahModel> response) {
    listOfSurah = response;
    notifyListeners();
  }

  Future<void> fetchListOfSurahApi(BuildContext context) async {
    setListOfSurah(ApiResponse.loading());

    _aLQuranRepository.getListOfSurah().then((value) {
      setListOfSurah(ApiResponse.completed(value));
      //
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print("error catalog: $error");
      }
      setListOfSurah(ApiResponse.error(error.toString()));
      Utils.flushBarErrorMessage(error.toString(), context);
    });
  }
}
