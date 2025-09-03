import 'package:e_learning_platform/blocs/auth/auth_bloc.dart';
import 'package:e_learning_platform/blocs/auth/auth_event.dart';
import 'package:e_learning_platform/blocs/auth/auth_state.dart';
import 'package:e_learning_platform/utilities/formvalidation/form_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'signup_footer.dart'; // keep if you want extra footer UI

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          // Clear fields on success
          FormValidations.fullNameController.clear();
          FormValidations.signUpEmailController.clear();
          FormValidations.signUpPasswordController.clear();

          // Navigate to homepage
          context.goNamed('homepage');
        }
      },
      child: SignUpForm(),
    );
  }
}

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 25.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: customsignupTextField(
                  tc: FormValidations.fullNameController,
                  context: context,
                  hintText: "Full Name (Required)",
                  errorText: (state is AuthError) ? state.fullNameError : null,
                ),
              ),
              SizedBox(height: 12.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: customsignupTextField(
                  tc: FormValidations.signUpEmailController,
                  hintText: "Email (Required)",
                  context: context,
                  errorText: (state is AuthError) ? state.emailError : null,
                ),
              ),
              SizedBox(height: 12.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: customsignupTextField(
                  context: context,
                  obscureText: state.obscurePassword,
                  tc: FormValidations.signUpPasswordController,
                  hintText: "Password (Required)",
                  icon: state.obscurePassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  errorText: (state is AuthError) ? state.passwordError : null,
                ),
              ),

              SizedBox(height: 16.h),
              const SignUpFooter(),
            ],
          ),
        );
      },
    );
  }

  Widget customsignupTextField({
    required String hintText,
    IconData? icon,
    required TextEditingController tc,
    String? errorText,
    bool? obscureText,
    required BuildContext context,
  }) {
    return TextField(
      controller: tc,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        suffixIcon: icon != null
            ? IconButton(
                onPressed: () {
                  context.read<AuthBloc>().add(TogglePasswordVisibility());
                },
                icon: Icon(icon),
              )
            : null,
        errorText: errorText,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.r),
          borderSide: BorderSide(width: 1, color: Colors.grey.shade600),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.r),
          borderSide: BorderSide(width: 1, color: Colors.grey.shade600),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.r),
          borderSide: BorderSide(width: 1, color: Colors.grey.shade600),
        ),
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 14.sp),
      ),
    );
  }
}
