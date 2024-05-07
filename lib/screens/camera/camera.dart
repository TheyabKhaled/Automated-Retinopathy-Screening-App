import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fundus_app/constants/controllers.dart';
import 'package:get/get.dart';

enum Eye { left, right }

class CameraScreen extends StatefulWidget {
  final Eye eye;
  const CameraScreen({super.key, required this.eye});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController camController;

  Future<void> initializeCamera() async {
    List<CameraDescription> cameras = await availableCameras();
    camController = CameraController(
      cameras[1],
      ResolutionPreset.medium,
      imageFormatGroup: ImageFormatGroup.yuv420,
    );
    await camController.initialize();
  }

  Future<void> takePicture() async {
    XFile file = await camController.takePicture();
    widget.eye == Eye.right
        ? cameraStateController.setRightEyeImageFile(file)
        : cameraStateController.setLeftEyeImageFile(file);
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: initializeCamera(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return Stack(
              children: [
                Positioned.fill(child: CameraPreview(camController)),
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/overlay.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () => takePicture(),
                          child: const CircleAvatar(
                            radius: 30,
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
