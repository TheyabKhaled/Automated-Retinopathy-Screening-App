import 'package:get/get.dart';

class ReportController extends GetxController {
  static final ReportController instance = Get.find();

  RxBool isPdfSaved = false.obs;
  void setIsPdfSaved(bool flag) {
    isPdfSaved.value = flag;
    update();
  }
}
