import 'package:flutter/material.dart';
import 'package:fundus_app/screens/login/login.dart';
import 'package:fundus_app/screens/verification/user_verification.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../constants/controllers.dart';
import '../../utils/utils.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController emirateIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    emirateIdController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          SizedBox(height: MediaQuery.sizeOf(context).height / 8),
          const Text(
            'Register',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          CustomTextField(
            controller: nameController,
            label: 'Name',
          ),
          const SizedBox(height: 15),
          CustomTextField(
            controller: emailController,
            label: 'Email',
          ),
          const SizedBox(height: 15),
          CustomTextField(
            controller: emirateIdController,
            label: 'Emirate ID',
          ),
          const SizedBox(height: 15),
          Obx(
            () => CustomTextField(
              maxLines: 1,
              keyboardType: TextInputType.visiblePassword,
              controller: passwordController,
              obscure: !signupController.passwordVisible.value,
              label: 'Password',
              suffixIcon: IconButton(
                onPressed: () {
                  signupController.toggleLoginPasswordVisibility();
                },
                style: IconButton.styleFrom(
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                ),
                icon: Icon(
                  signupController.passwordVisible.value == true
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
                color: primary,
              ),
            ),
          ),
          const SizedBox(height: 15),
          Obx(
            () => CustomTextField(
              maxLines: 1,
              controller: confirmPasswordController,
              keyboardType: TextInputType.visiblePassword,
              obscure: !signupController.confirmPasswordVisible.value,
              label: 'Confirm Password',
              suffixIcon: IconButton(
                onPressed: () {
                  signupController.toggleLoginConfirmPasswordVisibility();
                },
                style: IconButton.styleFrom(
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                ),
                icon: Icon(
                  signupController.confirmPasswordVisible.value == true
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
                color: primary,
              ),
            ),
          ),
          const SizedBox(height: 15),
          CustomButton(
            onTap: () async {
              showLoading(context);
              final bool success = await signupController.signup(
                nameController.text.trim(),
                emailController.text.trim(),
                emirateIdController.text.trim(),
                confirmPasswordController.text.trim(),
              );
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
              if (success) {
                Get.off(() => const VerificationScreen());
              }
            },
            text: 'Signup',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Already have an account? "),
              TextButton(
                onPressed: () {
                  Get.off(() => const LoginPage());
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                ),
                child: const Text(
                  "login",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
