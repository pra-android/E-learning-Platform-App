import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utilities/constants/colors_constant.dart';
import '../../../utilities/constants/image_constant.dart';
import 'login_footer.dart';
import 'login_form.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: AppColors.primaryColor),
            child: Image.asset(ImageConstant.loginLogo, height: 80.h),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 2 - 110.h,
            left: 2.w,
            right: 2.w,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Card(
                color: Colors.white,
                elevation: 3,
                child: Column(
                  children: [
                    Padding(padding: EdgeInsets.all(8.w), child: LoginForm()),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 4.w,
            right: 4.w,
            top: MediaQuery.of(context).size.height / 2 + 220.h,

            child: LoginFooter(),
          ),
        ],
      ),
    );
  }
}
