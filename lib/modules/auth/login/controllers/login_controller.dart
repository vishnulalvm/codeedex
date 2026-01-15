import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../models/login_request_model.dart';
import '../../../../services/auth_service.dart';
import '../../../../services/storage_service.dart';
import '../../../../routes/app_pages.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final RxBool isPasswordVisible = false.obs;
  final RxBool isLoading = false.obs;

  final AuthService _authService = AuthService();
  final StorageService _storageService = StorageService();

  @override
  void onInit() {
    super.onInit();
    emailController.text = 'Johndoe@Gmail.Com';
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> login() async {
    // Validate input fields
    if (emailController.text.trim().isEmpty ||
        passwordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill in all fields',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.1),
        colorText: Colors.red,
      );
      return;
    }

    try {
      isLoading.value = true;

      // Create login request
      final request = LoginRequest(
        emailPhone: emailController.text.trim(),
        password: passwordController.text,
      );

      // Call login API
      final response = await _authService.login(request);

      // Check if login was successful
      if (response.isSuccess && response.id != null && response.token != null) {
        // Store user credentials
        await _storageService.saveUserId(response.id!);
        await _storageService.saveToken(response.token!);

        // Store user data if available
        if (response.userData != null) {
          await _storageService.saveUserData(response.userData!.toJson());
        }

        // Show success message
        Get.snackbar(
          'Success',
          response.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withValues(alpha: 0.1),
          colorText: Colors.green,
        );

        // Navigate to home page
        Get.offAllNamed(Routes.HOME);
      } else {
        // Login failed
        Get.snackbar(
          'Login Failed',
          response.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withValues(alpha: 0.1),
          colorText: Colors.red,
        );
      }
    } catch (e) {
      // Handle errors
      Get.snackbar(
        'Error',
        e.toString().replaceAll('Exception: ', ''),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.1),
        colorText: Colors.red,
        duration: const Duration(seconds: 3),
      );
    } finally {
      isLoading.value = false;
    }
  }

  void forgotPassword() {
    Get.snackbar(
      'Forgot Password',
      'Feature coming soon',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void signUp() {
    Get.snackbar(
      'Sign Up',
      'Feature coming soon',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
