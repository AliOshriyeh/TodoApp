import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task01/routes/app_routes.dart';

class AuthController extends GetxController {
  SupabaseClient supabase = Supabase.instance.client;

  // --- Supabase & User Management ---
  final Rx<User?> _user = Rx<User?>(null);
  User? get user => _user.value; // Current authenticated user

  // --- Form Controllers ---
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  // --- Form State ---
  final formKey = GlobalKey<FormState>();
  RxBool obscurePass = true.obs; // Toggle password visibility
  RxBool obscureConfPass = true.obs; // Toggle confirm password visibility
  RxBool doesPassMatch = true.obs; // Password matching state

  @override
  void onInit() {
    // Listen to auth state changes
    supabase.auth.onAuthStateChange.listen((AuthState data) {
      final AuthChangeEvent event = data.event;
      final Session? session = data.session;

      if (event == AuthChangeEvent.signedIn && session != null) {
        _user.value = session.user;
      } else if (event == AuthChangeEvent.signedOut) {
        _user.value = null;
      }
    });

    // Get initial user if already logged in
    _user.value = supabase.auth.currentUser;
    super.onInit();
  }

  // --- Auth Methods ---
  Future<void> signUp(String email, String password) async {
    try {
      final AuthResponse response = await supabase.auth.signUp(
        email: email,
        password: password,
      );
      _user.value = response.user;
    } on AuthException catch (error) {
      Get.snackbar('Sign Up Error', error.message);
    } catch (error) {
      Get.snackbar('Error', 'Unexpected error occurred');
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      final AuthResponse response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      _user.value = response.user;
      Get.snackbar("Welcome", "You are logged in!");
      Get.offNamed(AppRoutes.tasklist);
    } on AuthException catch (error) {
      Get.snackbar('Sign In Error', error.message);
    } catch (error) {
      Get.snackbar('Error', 'Unexpected error occurred');
    }
  }

  Future<void> signOut() async {
    try {
      await supabase.auth.signOut();
      _user.value = null;
      Get.offNamed(AppRoutes.signin);
    } catch (error) {
      Get.snackbar('Error', 'Error signing out');
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await supabase.auth.resetPasswordForEmail(email);
      Get.snackbar('Success', 'Password reset email sent');
    } on AuthException catch (error) {
      Get.snackbar('Error', error.message);
    } catch (error) {
      Get.snackbar('Error', 'Unexpected error occurred');
    }
  }

  // --- Form Validators ---
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!value.isEmail) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  // For testing only
  @visibleForTesting
  void setSupabaseClient(SupabaseClient client) {
    supabase = client;
  }
}
