import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_api_project/screens/home.dart';
import 'package:image_api_project/screens/routes.dart';
import 'package:image_api_project/widgets/raw_button.dart';

class ImagePreview extends StatelessWidget {
  const ImagePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HomePageController(),
      builder: (HomePageController controller) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromARGB(255, 252, 222, 231),
              title: Text('Image Preview'),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Icon(Icons.notification_add),
                )
              ],
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Are You Want to know about more of the Image?',
                        style: TextStyle(
                            color: const Color.fromARGB(255, 61, 59, 59),
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 40,
                      ),

                      Obx(() {
                        if (controller.selectedImagePath.value.isNotEmpty) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.file(
                                  File(controller.selectedImagePath.value)),
                              SizedBox(height: 20),
                            ],
                          );
                        } else {
                          return Text('No image to display');
                        }
                      }),
                      // Obx(() {
                      //   return controller.selectedImagePath.value.isNotEmpty
                      //       ? Center(
                      //           child: Container(
                      //             height: 200,
                      //             width: 150,
                      //             child: Image.file(
                      //                 File(controller.selectedImagePath.value)),
                      //           ),
                      //         )
                      //       : Text('No image to display');
                      // }),
                      // SizedBox(
                      //   height: 40,
                      // ),
                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 252, 222, 231),
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Center(
                            child: RawButtonWidget(
                              onTap: () {
                                controller
                                    .uploadImageToServer(); // Trigger the upload
                                Get.toNamed(AppRoutes.imageOutput);
                              },
                              child: Text(
                                'Generate Photo',
                                style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 61, 59, 59),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
