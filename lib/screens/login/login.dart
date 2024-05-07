import 'package:flutter/material.dart';
import 'package:fundus_app/screens/signup/signup.dart';
import 'package:fundus_app/widgets/custom_button.dart';
import 'package:fundus_app/widgets/custom_textfield.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../constants/controllers.dart';
import '../../utils/utils.dart';
import '../dashboard/dashboard.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          SizedBox(height: MediaQuery.sizeOf(context).height / 6),
          const Text(
            'Login',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          CustomTextField(
            controller: emailController,
            label: 'Email',
          ),
          const SizedBox(height: 15),
          Obx(
            () => CustomTextField(
              controller: passwordController,
              maxLines: 1,
              keyboardType: TextInputType.visiblePassword,
              obscure: !loginController.passwordVisible.value,
              label: 'Password',
              suffixIcon: IconButton(
                onPressed: () {
                  loginController.toggleLoginPasswordVisibility();
                },
                style: IconButton.styleFrom(
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                ),
                icon: Icon(
                  loginController.passwordVisible.value == true
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
              final bool success = await loginController.signin(
                emailController.text.trim(),
                passwordController.text.trim(),
              );
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
              if (success) {
                Get.off(() => const DashboardPage());
              }
            },
            text: 'Login',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have an account? "),
              TextButton(
                onPressed: () {
                  Get.off(() => const RegisterPage());
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                ),
                child: const Text(
                  "register",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
