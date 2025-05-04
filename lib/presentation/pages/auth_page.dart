// ignore_for_file: library_private_types_in_public_api

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:task01/domain/controller/auth_controller.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Welcome Back',
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
                Obx(
                  () => TextFormField(
                    controller: authController.passwordController,
                    obscureText: authController.obscurePass.value,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                      suffixIcon: InkWell(
                        onTap: () => authController.obscurePass.value = !authController.obscurePass.value,
                        child: const Icon(Icons.visibility_off),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Handle forgot password
                    },
                    child: const Text('Forgot your password?'),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    authController.signIn(
                      authController.emailController.text,
                      authController.passwordController.text,
                    );
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
                const SizedBox(height: 24),
                OutlinedButton.icon(
                  onPressed: () {
                    // Handle Google login
                  },
                  icon: Image.asset('assets/imgs/google_logo.png', height: 24),
                  label: const Text('Login with Google'),
                  style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        // Navigate to sign up
                      },
                      child: const Text('Create account'),
                    ),
                  ],
                ),
              ],
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
