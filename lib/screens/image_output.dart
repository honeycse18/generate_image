import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_api_project/screens/home.dart';
import 'package:image_api_project/widgets/raw_button.dart';

class ImageOutput extends StatelessWidget {
  const ImageOutput({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HomePageController(),
      builder: (HomePageController controller) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromARGB(255, 252, 222, 231),
              title: Text('Image Characteristics'),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Here is the details about the image',
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
                              Align(
                                alignment: Alignment.center,
                                child: Image.file(
                                    File(controller.selectedImagePath.value)),
                              ),
                              SizedBox(height: 20),
                              Text(
                                  'Caption: ${controller.imageResponse.value.caption}'),
                              Text(
                                  'Emotion: ${controller.imageResponse.value.imageEmotion.emotion}'),
                              Text(
                                  'Emotion Score: ${controller.imageResponse.value.imageEmotion.score}'),
                              Text('Sentiments:'),
                              for (var sentiment
                                  in controller.imageResponse.value.sentiment)
                                Text(
                                    'Label: ${sentiment.label}, Score: ${sentiment.score}'),
                            ],
                          );
                        } else {
                          return Text('No image to display');
                        }
                      }),
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
