import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset(
                    'assets/image/Frame 427320120.png',
                    width: double.infinity,
                    height: 450.h,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 16.h,
                    right: 16.w,
                    child: TextButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          Text(
                            'Skip',
                            style: GoogleFonts.getFont(
                              'Lufga',
                              fontSize: 16.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 16.sp,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Login',
                      style: GoogleFonts.getFont(
                        'Lufga',
                        fontSize: 32.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 32.h),
                    Text(
                      'Email Address',
                      style: GoogleFonts.getFont(
                        'Lufga',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    TextField(
                      controller: controller.emailController,
                      decoration: InputDecoration(
                        hintText: 'Johndoe@Gmail.Com',
                        hintStyle: GoogleFonts.getFont(
                          'Lufga',
                          fontSize: 16.sp,
                          color: Colors.black87,
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF5F5F5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 18.h,
                        ),
                      ),
                      style: GoogleFonts.getFont(
                        'Lufga',
                        fontSize: 16.sp,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      'Password',
                      style: GoogleFonts.getFont(
                        'Lufga',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Obx(
                      () => TextField(
                        controller: controller.passwordController,
                        obscureText: !controller.isPasswordVisible.value,
                        decoration: InputDecoration(
                          hintText: '********',
                          hintStyle: GoogleFonts.getFont(
                            'Lufga',
                            fontSize: 16.sp,
                            color: Colors.black87,
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF5F5F5),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 18.h,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.isPasswordVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                              size: 22.sp,
                            ),
                            onPressed: controller.togglePasswordVisibility,
                          ),
                        ),
                        style: GoogleFonts.getFont(
                          'Lufga',
                          fontSize: 16.sp,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: controller.forgotPassword,
                        child: Text(
                          'Forgot password?',
                          style: GoogleFonts.getFont(
                            'Lufga',
                            fontSize: 14.sp,
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Obx(
                      () => SizedBox(
                        width: double.infinity,
                        height: 56.h,
                        child: ElevatedButton(
                          onPressed: controller.isLoading.value
                              ? null
                              : controller.login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF8B4513),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            elevation: 0,
                          ),
                          child: controller.isLoading.value
                              ? SizedBox(
                                  width: 24.w,
                                  height: 24.h,
                                  child: const CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(
                                  'Login',
                                  style: GoogleFonts.getFont(
                                    'Lufga',
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't Have an account? ",
                            style: GoogleFonts.getFont(
                              'Lufga',
                              fontSize: 14.sp,
                              color: Colors.black,
                            ),
                          ),
                          GestureDetector(
                            onTap: controller.signUp,
                            child: Text(
                              'Sign Up',
                              style: GoogleFonts.getFont(
                                'Lufga',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
