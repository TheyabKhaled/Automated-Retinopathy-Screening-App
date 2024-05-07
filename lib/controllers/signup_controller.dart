import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fundus_app/constants/hive_boxes.dart';
import 'package:fundus_app/models/user.dart' as model;
import 'package:fundus_app/utils/utils.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  static final SignupController instance = Get.find();

  final formkey = GlobalKey<FormState>();
  RxBool passwordVisible = false.obs;
  RxBool confirmPasswordVisible = false.obs;

  toggleLoginPasswordVisibility() {
    passwordVisible.value = !passwordVisible.value;
  }

  toggleLoginConfirmPasswordVisibility() {
    confirmPasswordVisible.value = !confirmPasswordVisible.value;
  }

  Future<bool> signup(
      String name, String email, String emirateId, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user == null) {
        showSnackbar('Something Went Wrong', "Couldn't Register");
        return false;
      }

      String? userId = userCredential.user?.uid;

      final model.User user = model.User(
          id: userId, email: email, name: name, emirateId: emirateId);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user?.uid)
          .set(user.toJson());

      await userBox.add(user);

      await userCredential.user?.sendEmailVerification();

      return true;
    } catch (e) {
      showSnackbar('Error signing up', '$e');
      return false;
    }
  }
}
