import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_api_project/widgets/drawer_address.dart';

class MenuScreenController extends GetxController {
/* <---- Logout button tap ----> */
  void onLogOutButtonTap() async {}
}

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: MenuScreenController(),
        builder: (MenuScreenController controller) {
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /* <---- Profile function in the drawer menu ----> */
                DrawerMenuSvgWidget(text: 'Profile', onTap: () async {}),

                /* <---- Logout function in the drawer menu ----> */
                DrawerMenuSvgWidget(
                    text: 'About Us', onTap: controller.onLogOutButtonTap),

                // Bottom extra spaces
              ],
            ),
          );
        });
  }
}
