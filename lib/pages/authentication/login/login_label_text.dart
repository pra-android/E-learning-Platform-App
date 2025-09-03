import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utilities/constants/colors_constant.dart';

class LoginLabelText extends StatelessWidget {
  final String label;
  const LoginLabelText({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 14.w),
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 12.sp,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }
}
