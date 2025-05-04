import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends GetxController {
  final SupabaseClient _supabase = Supabase.instance.client;
  final Rx<User?> _user = Rx<User?>(null);
  User? get user => _user.value;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  RxBool obscurePass = true.obs;

  @override
  void onInit() {
    _supabase.auth.onAuthStateChange.listen((AuthState data) {
      final AuthChangeEvent event = data.event;
      final Session? session = data.session;

      if (event == AuthChangeEvent.signedIn && session != null) {
        _user.value = session.user;
      } else if (event == AuthChangeEvent.signedOut) {
        _user.value = null;
      }
    });

    // Get initial user if already logged in
    _user.value = _supabase.auth.currentUser;
    super.onInit();
  }

  Future<void> signUp(String email, String password) async {
    try {
      final AuthResponse response = await _supabase.auth.signUp(
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
      final AuthResponse response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      _user.value = response.user;
      Get.snackbar("Welcome", "You are logged in!");
      Get.offNamed('/homepage');
    } on AuthException catch (error) {
      Get.snackbar('Sign In Error', error.message);
    } catch (error) {
      Get.snackbar('Error', 'Unexpected error occurred');
    }
  }

  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
      _user.value = null;
      Get.offNamed("/authPage");
    } catch (error) {
      Get.snackbar('Error', 'Error signing out');
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _supabase.auth.resetPasswordForEmail(email);
      Get.snackbar('Success', 'Password reset email sent');
    } on AuthException catch (error) {
      Get.snackbar('Error', error.message);
    } catch (error) {
      Get.snackbar('Error', 'Unexpected error occurred');
    }
  }
}
