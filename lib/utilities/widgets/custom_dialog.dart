import 'package:e_learning_platform/blocs/auth/auth_bloc.dart';
import 'package:e_learning_platform/blocs/auth/auth_state.dart';
import 'package:e_learning_platform/blocs/biometric/biometric_auth_bloc.dart';
import 'package:e_learning_platform/blocs/biometric/biometric_auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CustomDialog extends StatelessWidget {
  final String descriptions;
  final VoidCallback onPressed;
  const CustomDialog({
    super.key,
    required this.descriptions,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthInitial) {
              Navigator.of(context).pop();
              context.goNamed('login');
            }
          },
        ),
        BlocListener<BiometricAuthBloc, BiometricAuthState>(
          listener: (context, state) {
            if (state is BiometricSettingLoaded) {
              if (state.enabled) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Biometrics enabled. You can now login with biometrics after logout.',
                    ),
                    backgroundColor: Colors.green,
                  ),
                );
              } else {}
            }
          },
        ),
      ],
      child: Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(65.r),
            bottomLeft: Radius.circular(65.r),
            topRight: Radius.circular(10.r),
            bottomRight: Radius.circular(10.r),
          ),
        ),
        child: Container(
          height: 160.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(65.r),
              bottomLeft: Radius.circular(65.r),
              topRight: Radius.circular(10.r),
              bottomRight: Radius.circular(10.r),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: CircleAvatar(
                  backgroundColor: Colors.blueGrey.shade100,
                  radius: 40.r,
                  child: Icon(
                    Icons.error_outline,
                    size: 40,
                    color: Colors.pink,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: Text(
                            "Alert!",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.sp,
                            ),
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  descriptions,
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "No",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            SizedBox(width: 10),

                            BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, state) {
                                return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                  ),
                                  onPressed: onPressed,
                                  child: const Text(
                                    "Yes",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
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

class CustomDialogs {
  static void showCustomDialog(
    BuildContext context,
    String descriptions,
    VoidCallback onPressed,
  ) {
    showDialog(
      context: context,
      builder: (context) =>
          CustomDialog(descriptions: descriptions, onPressed: onPressed),
    );
  }
}
