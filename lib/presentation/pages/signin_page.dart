import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:task01/domain/controller/auth_controller.dart';
import 'package:task01/presentation/theme/app_assets.dart';
import 'package:task01/presentation/theme/app_text_style.dart';
import 'package:task01/routes/app_routes.dart';

/// Sign in page for user authentication
class SignInPage extends StatelessWidget {
  SignInPage({super.key});
  final AuthController authController = Get.find(); // Auth controller instance

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
                // Header
                const Text(
                  'Welcome',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                // Email field
                TextFormField(
                  controller: authController.emailController,
                  validator: authController.validateEmail,
                  decoration: const InputDecoration(
                    labelText: 'Your email address',
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                const SizedBox(height: 16),

                // Password field with visibility toggle
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

                // Forgot password link
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text('Forgot your password?'),
                  ),
                ),
                const SizedBox(height: 24),

                // Login button
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
                    backgroundColor: Get.theme.unselectedWidgetColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text('Login', style: AppTextStyle.black16.copyWith(color: Get.theme.scaffoldBackgroundColor)),
                ),
                const SizedBox(height: 24),

                // Divider with "Or" text
                const Row(
                  children: [
                    Expanded(child: Divider()),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 8.0), child: Text('Or')),
                    Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 24),

                // Google login button
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: Image.asset(AppAssets.google_logo, height: 24),
                  label: const Text('Login with Google'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
                const SizedBox(height: 20),

                // Sign up redirect
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
