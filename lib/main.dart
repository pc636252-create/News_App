import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/route_manager.dart';
import 'package:news_app/Routes/App_Page.dart';
import 'package:news_app/Routes/App_Routes.dart';

import 'SharedPrefrence/sharedPrefrence.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync<SharedPrefService>(() async => await SharedPrefService().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splashScreen,
      getPages: AppPage.screens,
    );
  }
}
