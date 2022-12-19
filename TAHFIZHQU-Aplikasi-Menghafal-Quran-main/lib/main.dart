import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tahfizh_qu_app/features/alQuran_feature/view_model/alQuran_view_model.dart';
import 'package:tahfizh_qu_app/res/tahfidzqu_colors.dart';
import 'package:tahfizh_qu_app/utils/routes/routes.dart';
import 'package:tahfizh_qu_app/utils/routes/routes_names.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AlQuranViewModel())],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: TahfidzQuColors.whiteBackground,
        ),
        initialRoute: RoutesNames.splash,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
