// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showLoading(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    // ignore: deprecated_member_use
    builder: (context) => WillPopScope(
      onWillPop: () async => false,
      child: const AlertDialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Center(child: CircularProgressIndicator()),
      ),
    ),
  );
}

void showSnackbar(String title, String desc) {
  Get.snackbar(
    title,
    desc,
    animationDuration: const Duration(milliseconds: 200),
    snackPosition: SnackPosition.BOTTOM,
    margin: const EdgeInsets.all(20),
    duration: const Duration(milliseconds: 1500),
  );
}
