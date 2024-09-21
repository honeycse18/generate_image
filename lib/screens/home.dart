import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_api_project/api_response/image_response/image_response.dart';
import 'package:image_api_project/screens/image_preview.dart';
import 'package:image_api_project/screens/routes.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import '../widgets/raw_button.dart';

class HomePageController extends GetxController {
  var selectedImagePath = ''.obs;
  final ImagePicker _picker = ImagePicker();

  var imageResponse =
      ImageResponse.empty().obs; // Observable to hold API response data

  // Function to pick an image from the gallery
  Future<void> pickImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImagePath.value = image.path;
    } else {
      Get.snackbar('Error', 'No image selected');
    }
  }

  // Function to take a photo using the camera
  Future<void> takePhoto() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      selectedImagePath.value = image.path;
    } else {
      Get.snackbar('Error', 'No image captured');
    }
  }

  // Function to upload the image to the server and parse response
  Future<void> uploadImageToServer() async {
    if (selectedImagePath.value.isEmpty) {
      Get.snackbar('Error', 'No image selected');
      return;
    }

    var url =
        Uri.parse('https://cbl264xg-5000.asse.devtunnels.ms/upload?image');
    var request = http.MultipartRequest('POST', url);

    try {
      // Add the file to the request
      var file = await http.MultipartFile.fromPath(
          'image', selectedImagePath.value,
          filename: basename(selectedImagePath.value));

      request.files.add(file);

      // Send the request
      var response = await request.send();

      if (response.statusCode == 200) {
        // Parse the response as a string
        var responseBody = await response.stream.bytesToString();

        // Parse the JSON response into your model
        Map<String, dynamic> jsonResponse = jsonDecode(responseBody);

        imageResponse.value = ImageResponse.fromJson(jsonResponse);

        Get.snackbar('Success', 'Image uploaded successfully');
      } else {
        Get.snackbar('Error', 'Image upload failed');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload image');
      print(e.toString());
    }
  }
}

/*...............<API for uploading the image into the server>....................... */
//Other APi
final _connect = GetConnect();
void _sendGetRequest() async {
  final response =
      await _connect.get('https://jsonplaceholder.typicode.com/posts/1');
  if (kDebugMode) {
    print(response.body);
  }
}

void _sendPostRequest() async {
  final response = await _connect.post(
    'https://jsonplaceholder.typicode.com/posts',
    {
      'title': 'One two three',
      'body': 'Four Five six',
      'userId': 1,
    },
  );
  if (kDebugMode) {
    print(response.body);
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HomePageController(),
      builder: (HomePageController controller) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromARGB(255, 252, 222, 231),
              title: Text('Gallery'),
              leading: Center(
                /* <---- Menu icon in home navigator screen ----> */
                child: RawButtonWidget(
                    onTap: () {
                      if (ZoomDrawer.of(context)?.isOpen() ?? false) {
                        ZoomDrawer.of(context)?.close();
                      } else {
                        ZoomDrawer.of(context)?.open();
                      }
                    },
                    child: Icon(Icons.menu)),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Icon(Icons.notification_add),
                )
              ],
            ),
            body: SingleChildScrollView(
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
                    Image.asset('assets/android.png'),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      'Are You Want to Upload Images?',
                      style: TextStyle(
                          color: const Color.fromARGB(255, 61, 59, 59),
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: DottedBorder(
                              color: Colors.grey,
                              borderType: BorderType.RRect,
                              strokeWidth: 1,
                              dashPattern: [4, 4],
                              radius: Radius.circular(20.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: RawButtonWidget(
                                  onTap: () => controller.takePhoto(),
                                  child: Container(
                                    height: 200,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(Icons.camera_alt_sharp),
                                          Text(
                                            'Take Photo',
                                            style: TextStyle(
                                                color: const Color.fromARGB(
                                                    255, 61, 59, 59),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: DottedBorder(
                              color: Colors.grey,
                              borderType: BorderType.RRect,
                              strokeWidth: 1,
                              dashPattern: [4, 4],
                              radius: Radius.circular(20.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: RawButtonWidget(
                                  onTap: () =>
                                      controller.pickImageFromGallery(),
                                  child: Container(
                                    height: 200,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(Icons.add),
                                          Text(
                                            'Choose photo ',
                                            style: TextStyle(
                                                color: const Color.fromARGB(
                                                    255, 61, 59, 59),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 50,
                            width: 180,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 252, 222, 231),
                                borderRadius: BorderRadius.circular(25.0)),
                            child: RawButtonWidget(
                              onTap: () {
                                if (controller
                                    .selectedImagePath.value.isNotEmpty) {
                                  Get.toNamed(
                                      '/preview'); // Use named route '/preview'
                                } else {
                                  Get.snackbar('Error', 'No image selected');
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    'Go to Next Screen',
                                    style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 61, 59, 59),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            height: 50,
                            width: 180,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 252, 222, 231),
                                borderRadius: BorderRadius.circular(25.0)),
                            child: RawButtonWidget(
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    'Edit Photo',
                                    style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 61, 59, 59),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Container(
                            height: 50,
                            width: 180,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 252, 222, 231),
                                borderRadius: BorderRadius.circular(25.0)),
                            child: RawButtonWidget(
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    'Remove Photo',
                                    style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 61, 59, 59),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
