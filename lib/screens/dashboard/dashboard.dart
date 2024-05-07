import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:fundus_app/constants/controllers.dart';
import 'package:fundus_app/constants/hive_boxes.dart';
import 'package:fundus_app/controllers/glaucoma_controller.dart';
import 'package:fundus_app/controllers/model_controller.dart';
import 'package:fundus_app/models/result.dart';
import 'package:fundus_app/screens/report/report.dart';
import 'package:fundus_app/widgets/drawer_contents.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:fundus_app/controllers/camera_controller.dart';
import 'package:fundus_app/screens/camera/camera.dart';
import 'package:fundus_app/widgets/custom_button.dart';
import 'package:get/get.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();

    ModelController.loadModel().then((value) {
      setState(() {
        ModelController.modelLoaded = true;
      });
    });
  }

  Future<void> captureImage(BuildContext context, Eye eye) async {
    final ImageSource? source = await showDialog<ImageSource>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Image Source'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: const ListTile(
                    leading: Icon(Icons.camera_alt_outlined),
                    title: Text('Camera'),
                  ),
                  onTap: () {
                    Navigator.of(context).pop(ImageSource.camera);
                  },
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                GestureDetector(
                  child: const ListTile(
                    leading: Icon(Icons.image),
                    title: Text('Gallery'),
                  ),
                  onTap: () {
                    Navigator.of(context).pop(ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );

    if (source == null) return;

    if (source == ImageSource.gallery) {
      final pickedFile = await ImagePicker().pickImage(source: source);
      eye == Eye.left
          ? cameraStateController.setLeftEyeImageFile(pickedFile)
          : cameraStateController.setRightEyeImageFile(pickedFile);
    } else {
      Get.to(() => CameraScreen(eye: eye));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
        child: DrawerContents(),
      ),
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 30),
          Container(
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height / 6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(),
            ),
            child: GetBuilder<CameraStateController>(
              builder: (controller) {
                return Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: InkWell(
                          onTap: () => captureImage(context, Eye.left),
                          borderRadius: BorderRadius.circular(5),
                          child: controller.leftEyeImageFile == null
                              ? Container(
                                  width: double.maxFinite,
                                  height: double.maxFinite,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(),
                                  ),
                                  child: const Center(
                                    child: Text("Left Eye"),
                                  ),
                                )
                              : Image.file(
                                  File(controller.leftEyeImageFile!.path),
                                  fit: BoxFit.fitWidth,
                                ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: InkWell(
                          onTap: () => captureImage(context, Eye.right),
                          borderRadius: BorderRadius.circular(5),
                          child: controller.rightEyeImageFile == null
                              ? Container(
                                  width: double.maxFinite,
                                  height: double.maxFinite,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(),
                                  ),
                                  child: const Center(
                                    child: Text("Right Eye"),
                                  ),
                                )
                              : Image.file(
                                  File(controller.rightEyeImageFile!.path),
                                  fit: BoxFit.fitWidth,
                                ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 30),
          CustomButton(
            onTap: () async {
              if (cameraStateController.leftEyeImageFile != null &&
                  cameraStateController.rightEyeImageFile != null &&
                  ModelController.modelLoaded) {
                Result? drResult = await ModelController.classifyImage(
                  cameraStateController.leftEyeImageFile!,
                );
                Uint8List? leftEyeImg =
                    await cameraStateController.leftEyeImageFile?.readAsBytes();
                Uint8List? rightEyeImg = await cameraStateController
                    .rightEyeImageFile
                    ?.readAsBytes();
                drResult?.leftEyeImg = leftEyeImg;
                drResult?.rightEyeImg = rightEyeImg;
                drResult?.uid = currentUser.id;

                Result? glaucomaResult = await getGlaucomaResult(
                    cameraStateController.leftEyeImageFile!);

                Get.to(() => ReportScreen(
                    drResult: drResult!,
                    glaucomaResult: glaucomaResult!))?.then((value) {
                  cameraStateController.setLeftEyeImageFile(null);
                  cameraStateController.setRightEyeImageFile(null);
                  reportController.setIsPdfSaved(false);
                });
              } else {
                Get.snackbar(
                  "Could'nt Generate Report",
                  "Please make sure you have added images of both the eyes",
                );
              }
            },
            text: 'Generate Report',
          ),
        ],
      ),
    );
  }
}
