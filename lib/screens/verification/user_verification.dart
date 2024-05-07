import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fundus_app/screens/dashboard/dashboard.dart';
import 'package:fundus_app/widgets/custom_button.dart';
import 'package:get/get.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  @override
  void initState() {
    super.initState();
    if (FirebaseAuth.instance.currentUser?.emailVerified ?? false) {
      Get.off(() => const DashboardPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "You Need To Verify Your Account Before Logging In",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Didn't Recieve Verification Email?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 15),
              CustomButton(
                width: 250,
                onTap: () async {
                  try {
                    await FirebaseAuth.instance.currentUser
                        ?.sendEmailVerification();
                    Get.snackbar('Email Sent',
                        'please check your email for verification email');
                  } catch (e) {
                    Get.snackbar("Coudn't Send Email",
                        'There was some problem sending verification email: $e');
                  }
                },
                text: 'Send Email Again',
              ),
              const SizedBox(height: 15),
              const Text(
                "Already Verified?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 15),
              CustomButton(
                width: 250,
                onTap: () async {
                  await FirebaseAuth.instance.currentUser?.reload();
                  if (FirebaseAuth.instance.currentUser?.emailVerified ??
                      false) {
                    Get.off(() => const DashboardPage());
                  } else {
                    Get.snackbar('Not Verified',
                        'please check your email for verification email');
                  }
                },
                text: 'Reload',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
