import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:flutter_zoom_drawer/src/drawer_controller.dart';
import 'package:image_api_project/screens/home.dart';
import 'package:image_api_project/screens/menu_screen.dart';

class ZoomDrawerScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/

  final zoomDrawerController = ZoomDrawerController();
  Widget nestedScreenWidget = const Scaffold();
  int currentPageIndex = 0;
}

class ZoomDrawerScreen extends StatelessWidget {
  const ZoomDrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: ZoomDrawerScreenController(),
        builder: (ZoomDrawerScreenController controller) {
          return Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            body: ZoomDrawer(
              //zoom drawer on the left side of the screen
              menuBackgroundColor: const Color.fromARGB(255, 245, 196, 212),
              controller: controller.zoomDrawerController,
              menuScreen: const MenuScreen(),
              mainScreen: const HomePage(),
              showShadow: true,
              style: DrawerStyle.defaultStyle,
              angle: 0.0,
              isRtl: false,
              disableDragGesture: true,
              androidCloseOnBackTap: true,
              mainScreenTapClose: true,
              moveMenuScreen: true,
            ),
          );
        });
  }
}
