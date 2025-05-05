// ignore_for_file: library_private_types_in_public_api

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:task01/presentation/theme/app_colors.dart';
import 'package:task01/presentation/theme/app_text_style.dart';
import 'package:task01/routes/app_routes.dart';
import 'package:task01/domain/controller/auth_controller.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});
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
            child: Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'SIGN UP',
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
                  TextFormField(
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
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: authController.confirmPasswordController,
                    obscureText: authController.obscureConfPass.value,
                    validator: authController.validateConfirmPassword,
                    decoration: InputDecoration(
                      labelText: 'Password Again',
                      border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                      suffixIcon: InkWell(
                        onTap: () => authController.obscureConfPass.value = !authController.obscureConfPass.value,
                        child: Icon(authController.obscureConfPass.value ? Icons.visibility_off : Icons.visibility),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      if (authController.formKey.currentState!.validate()) {
                        authController.signUp(
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
                    child: Text('Sign Up', style: AppTextStyle.black16.copyWith(color: AppColors.white)),
                  ),
                  const SizedBox(height: 24),
                  const Row(
                    children: [
                      Expanded(child: Divider()),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 8.0), child: Text('Or')),
                      Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("You have an account?"),
                      TextButton(
                        onPressed: () => Get.offNamed(AppRoutes.signin),
                        child: const Text('Login'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
