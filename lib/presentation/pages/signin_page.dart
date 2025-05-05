// ignore_for_file: library_private_types_in_public_api

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:task01/domain/controller/auth_controller.dart';
import 'package:task01/presentation/theme/app_assets.dart';
import 'package:task01/presentation/theme/app_colors.dart';
import 'package:task01/presentation/theme/app_text_style.dart';
import 'package:task01/routes/app_routes.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Authentication'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: authController.formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Welcome',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                TextFormField(
                  controller: authController.emailController,
                  validator: authController.validateEmail,
                  decoration: const InputDecoration(
                    labelText: 'Your email address',
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                const SizedBox(height: 16),
                Obx(
                  () => TextFormField(
                    controller: authController.passwordController,
                    obscureText: authController.obscurePass.value,
                    validator: authController.validatePassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                      suffixIcon: InkWell(
                        onTap: () => authController.obscurePass.value = !authController.obscurePass.value,
                        child: Icon(authController.obscurePass.value ? Icons.visibility_off : Icons.visibility),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Get.toNamed(AppRoutes.forgotPassword);
                    },
                    child: const Text('Forgot your password?'),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (authController.formKey.currentState!.validate()) {
                      authController.signIn(
                        authController.emailController.text,
                        authController.passwordController.text,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text('Login', style: AppTextStyle.black16.copyWith(color: AppColors.white)),
                ),
                const SizedBox(height: 24),
                const Row(
                  children: [
                    Expanded(child: Divider()),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 8.0), child: Text('Or')),
                    Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 24),
                OutlinedButton.icon(
                  onPressed: () {
                    // Handle Google login
                  },
                  icon: Image.asset(AppAssets.google_logo, height: 24),
                  label: const Text('Login with Google'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () => Get.offNamed(AppRoutes.signup),
                      child: const Text('Create account'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
