import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fundus_app/constants/hive_boxes.dart';
import 'package:fundus_app/models/user.dart' as model;
import 'package:get/get.dart';

import '../utils/utils.dart';

class LoginController extends GetxController {
  static final LoginController instance = Get.find();

  final formkey = GlobalKey<FormState>();
  RxBool passwordVisible = false.obs;

  toggleLoginPasswordVisibility() {
    passwordVisible.value = !passwordVisible.value;
  }

  Future<bool> signin(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final DocumentSnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userCredential.user?.uid)
              .get();
      final Map<String, dynamic>? userData = snapshot.data();
      if (userData != null) {
        model.User user = model.User.fromJson(userData);
        await userBox.add(user);
      }

      return true;
    } on FirebaseAuthException {
      showSnackbar(
          'Error signing in', 'Please Check your credentials and try again');
      return false;
    } catch (e) {
      showSnackbar('Error signing in', '$e');
      return false;
    }
  }
}
