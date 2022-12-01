import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samug_project/routes/screen_routes.dart';
import 'package:samug_project/ui/home_screen.dart';
import 'package:samug_project/utills/widget/loader.dart';

void main() {
   WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Loading(
      child: GetMaterialApp(
        // title: AppString.appName,
        // initialBinding: InitialBinding(),
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
        getPages: ScreenRoutes.screens,
        navigatorKey: Get.key,
        navigatorObservers: [GetObserver()],
      ),
    );
  }
}