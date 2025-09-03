import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'utilities/constants/colors_constant.dart';
import 'utilities/constants/image_constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3), () {
      if (!mounted) return;

      // ignore: use_build_context_synchronously
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // ignore: use_build_context_synchronously
        context.goNamed('homepage');
      } else {
        // ignore: use_build_context_synchronously
        context.goNamed('login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Image.asset(ImageConstant.appSplashScreenLogo)),
          const SizedBox(height: 20),
          CircularProgressIndicator(color: AppColors.primaryColor),
        ],
      ),
    );
  }
}
