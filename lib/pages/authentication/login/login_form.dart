import 'package:e_learning_platform/blocs/auth/auth_event.dart';
import 'package:e_learning_platform/blocs/auth/auth_state.dart';
import 'package:e_learning_platform/blocs/biometric/biometric_auth_event.dart';
import 'package:e_learning_platform/blocs/biometric/biometric_auth_state.dart';
import 'package:e_learning_platform/pages/authentication/login/login_custom_textfield.dart';
import 'package:e_learning_platform/pages/authentication/login/login_label_text.dart';
import 'package:e_learning_platform/utilities/formvalidation/form_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../blocs/auth/auth_bloc.dart';
import '../../../blocs/biometric/biometric_auth_bloc.dart';
import '../../../utilities/constants/colors_constant.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is Authenticated) {
                context.goNamed('homepage');
              }

              if (state is AuthError && state.generalError != null) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.generalError!)));
              }
            },
          ),

          BlocListener<BiometricAuthBloc, BiometricAuthState>(
            listener: (context, state) {
              if (state is BiometricError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
          ),
        ],
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Please enter your email and password",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                LoginLabelText(label: "Email"),
                Padding(
                  padding: EdgeInsets.only(left: 14.w, right: 14.w, top: 2.h),
                  child: LoginCustomTextfield(
                    tc: FormValidations.loginEmailController,
                    hintText: "Email",
                    prefixIcon: Icon(Icons.email_outlined, size: 22.sp),
                  ),
                ),
                //Password
                SizedBox(height: 12.h),
                LoginLabelText(label: "Password"),
                Padding(
                  padding: EdgeInsets.only(left: 14.w, right: 14.w, top: 2.h),
                  child: LoginCustomTextfield(
                    tc: FormValidations.loginPasswordController,
                    obscureText: state.obscurePassword ? true : false,
                    hintText: "Password",
                    prefixIcon: Icon(Icons.lock_outline, size: 22.sp),
                    suffixIcon: IconButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(
                          TogglePasswordVisibility(),
                        );
                      },
                      icon: Icon(
                        state.obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.black,
                        size: 16.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 14.r),
                      child: TextButton(
                        onPressed: () {
                          context.pushNamed('forgotpassword');
                        },
                        child: Text(
                          "Forgot Password",
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                //
                SizedBox(height: 1.h),
                Padding(
                  padding: EdgeInsets.all(18.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 42.h,
                          width: 50.h,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(
                                  8.r,
                                ),
                              ),
                            ),
                            onPressed: () {
                              context.read<AuthBloc>().add(
                                LoginRequested(
                                  FormValidations.loginEmailController.text,
                                  FormValidations.loginPasswordController.text,
                                ),
                              );
                            },
                            child: state is AuthLoading
                                ? Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(
                                    "Sign In",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: SizedBox(
                          width: 50.w,
                          height: 42.h,
                          child: BlocBuilder<BiometricAuthBloc, BiometricAuthState>(
                            builder: (context, state) {
                              bool isEnabled = false;

                              if (state is BiometricSettingLoaded) {
                                isEnabled = state.enabled;
                              }

                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1,
                                      color: AppColors.primaryColor,
                                    ),
                                    borderRadius: BorderRadiusGeometry.circular(
                                      8.r,
                                    ),
                                  ),
                                ),
                                onPressed: isEnabled
                                    ? () {
                                        context.read<BiometricAuthBloc>().add(
                                          AuthenticateWithBiometric(),
                                        );
                                      }
                                    : () {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              "You must at first either perform signup/login with email and then enable biometric through profile ",
                                            ),
                                          ),
                                        );
                                      },
                                child: Text(
                                  "BIOMETRIC",
                                  style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
