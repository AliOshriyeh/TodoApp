// ignore_for_file: library_private_types_in_public_api

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:task01/domain/controller/auth_controller.dart';
import 'package:task01/presentation/theme/app_text_style.dart';
import 'package:task01/presentation/theme/index_theme.dart';
import 'package:task01/routes/app_routes.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final AuthController authController = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Authentication'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(24.0),
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
                    decoration: const InputDecoration(
                      labelText: 'Your email address',
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: authController.passwordController,
                    obscureText: authController.obscurePass.value,
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
                    decoration: InputDecoration(
                      labelText: 'Password Again',
                      border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                      suffixIcon: InkWell(
                        onTap: () => authController.obscurePass.value = !authController.obscurePass.value,
                        child: Icon(authController.obscurePass.value ? Icons.visibility_off : Icons.visibility),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Visibility(
                    visible: !authController.doesPassMatch.value,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Passwords don't match", style: AppTextStyle.bold16.copyWith(color: AppColors.warning)),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      authController.doesPassMatch.value = (authController.passwordController.text == authController.confirmPasswordController.text);
                      if (authController.doesPassMatch.value) {
                        authController.signUp(
                          authController.emailController.text,
                          authController.passwordController.text,
                        );
                      } else {}
                    },
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                    child: const Text('Login', style: TextStyle(fontSize: 16)),
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
            )));
  }

  @override
  void dispose() {
    authController.emailController.dispose();
    authController.passwordController.dispose();
    authController.confirmPasswordController.dispose();
    super.dispose();
  }
}
