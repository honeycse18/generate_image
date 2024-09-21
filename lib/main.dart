import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:image_api_project/screens/home.dart';
import 'package:image_api_project/screens/image_output.dart';
import 'package:image_api_project/screens/image_preview.dart';
import 'package:image_api_project/screens/zoom_navigator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        // Define the routes here
        GetPage(name: '/', page: () => HomePage()),
        GetPage(name: '/preview', page: () => ImagePreview()),
        GetPage(name: '/imageOutput', page: () => ImageOutput()),
      ],
      home: ZoomDrawerScreen(),
    );
  }
}
