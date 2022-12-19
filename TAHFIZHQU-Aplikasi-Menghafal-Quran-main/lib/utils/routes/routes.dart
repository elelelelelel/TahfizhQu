import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tahfizh_qu_app/features/alQuran_feature/screens/al_quran.dart';
import 'package:tahfizh_qu_app/features/alQuran_feature/screens/detail_quran.dart';
import 'package:tahfizh_qu_app/features/home_feature/screens/home.dart';
import 'package:tahfizh_qu_app/features/login_feature/screens/login.dart';
import 'package:tahfizh_qu_app/features/sign_up_feature/screens/signup.dart';
import 'package:tahfizh_qu_app/features/splash_feature/screens/splashscreen.dart';
import 'package:tahfizh_qu_app/utils/routes/routes_names.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesNames.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashScreen());

      case RoutesNames.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => const Login());

      case RoutesNames.signUp:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SignUp());

      case RoutesNames.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen());

      case RoutesNames.alQuran:
        return MaterialPageRoute(builder: (BuildContext context) => AlQuran());

      case RoutesNames.detailQuran:
        return MaterialPageRoute(
            builder: (BuildContext context) => DetailQuran());

      default:
        return MaterialPageRoute(
          builder: (_) {
            return const Scaffold(
              body: Center(
                child: Text('No route defined'),
              ),
            );
          },
        );
    }
  }
}
