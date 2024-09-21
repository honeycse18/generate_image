import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:image_api_project/screens/image_output.dart';
import 'package:image_api_project/screens/image_preview.dart';
import 'package:image_api_project/screens/routes.dart';
import 'package:image_api_project/screens/zoom_navigator.dart';

class AppPages {
  static var list = [
    GetPage(name: AppRoutes.preview, page: () => const ImagePreview()),
    GetPage(name: AppRoutes.rootScreen, page: () => const ZoomDrawerScreen()),
    GetPage(name: AppRoutes.imageOutput, page: () => const ImageOutput()),
  ];
}
