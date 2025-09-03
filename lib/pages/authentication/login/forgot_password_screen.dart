import 'package:e_learning_platform/blocs/auth/auth_bloc.dart';
import 'package:e_learning_platform/blocs/auth/auth_event.dart';
import 'package:e_learning_platform/blocs/auth/auth_state.dart';
import 'package:e_learning_platform/utilities/constants/colors_constant.dart';
import 'package:e_learning_platform/utilities/formvalidation/form_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
            size: 14.sp,
          ),
        ),
        backgroundColor: AppColors.primaryColor,
        title: Text(
          "Forgot Password",
          style: TextStyle(
            color: Colors.white,
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            if (state.emailError != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.emailError.toString())),
              );
            }
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Column(
              children: [
                SizedBox(height: 10.h),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "We will sent you password reset link to your email",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(14.w),
                  child: TextField(
                    controller: FormValidations.forgotPasswordController,
                    decoration: InputDecoration(
                      hintText: "Enter your email",
                      prefixIcon: Icon(Icons.email_outlined),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(8.r),
                    ),

                    fixedSize: Size(
                      MediaQuery.of(context).size.width - 200.w,
                      40.h,
                    ),
                  ),
                  onPressed: () {
                    context.read<AuthBloc>().add(
                      ForgotPasswordRequested(
                        context: context,
                        email: FormValidations.forgotPasswordController.text,
                      ),
                    );
                  },
                  child: Text("Send", style: TextStyle(color: Colors.white)),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
