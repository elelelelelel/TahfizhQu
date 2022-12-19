import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tahfizh_qu_app/features/hafalan_feature/pages/home/homepage.dart';
import 'package:tahfizh_qu_app/features/home_feature/screens/home.dart';

class ControllrerLogin extends GetxController {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  RxBool isLoading = false.obs;

  Future<dynamic> loginWithGoogle() async {
    try {
      isLoading(true);
      var result = await _googleSignIn.signIn();
      isLoading(false);

      print("cek : " + result.toString());
      if (result!.displayName != null) {
        Get.offAll(() => HomeScreen());
      }

      return;
    } catch (e) {
      isLoading(false);

      rethrow;
    }
  }
}
