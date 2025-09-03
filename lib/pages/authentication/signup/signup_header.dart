import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../utilities/constants/colors_constant.dart';

class SignUpHeader extends StatelessWidget {
  const SignUpHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.h),
        Padding(
          padding: EdgeInsets.all(8.w),
          child: TextButton(
            onPressed: () {
              context.pop();
            },
            child: Text(
              "Back to Login",
              style: TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w700,
                fontSize: 12.sp,
              ),
            ),
          ),
        ),
        SizedBox(height: 25.h),
        Center(
          child: Text(
            "Skill Booster",
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 30.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Center(
          child: Text(
            "Sign Up",
            style: TextStyle(
              color: Colors.black,
              fontSize: 15.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}
