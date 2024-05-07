import 'package:camera/camera.dart';
import 'package:get/get.dart';

class CameraStateController extends GetxController {
  static final CameraStateController instance = Get.find();

  XFile? leftEyeImageFile;
  XFile? rightEyeImageFile;

  void setLeftEyeImageFile(XFile? file) {
    leftEyeImageFile = file;
    update();
  }

  void setRightEyeImageFile(XFile? file) {
    rightEyeImageFile = file;
    update();
  }
}
