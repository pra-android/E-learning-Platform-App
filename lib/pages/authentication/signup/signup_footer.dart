import 'package:e_learning_platform/blocs/auth/auth_bloc.dart';
import 'package:e_learning_platform/blocs/auth/auth_event.dart';
import 'package:e_learning_platform/blocs/auth/auth_state.dart';
import 'package:e_learning_platform/utilities/formvalidation/form_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utilities/constants/colors_constant.dart';

class SignUpFooter extends StatelessWidget {
  const SignUpFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(height: 20.h),
            Row(
              children: [
                Checkbox(
                  value:
                      (state is AuthInitial && state.agreed) ||
                      (state is AuthError && state.agreed),
                  onChanged: (val) {
                    context.read<AuthBloc>().add(ToggleAgreement(val!));
                  },
                ),
                Expanded(
                  child: Text(
                    "By creating an account.I accept Skill Booster terms of use and privacy policy",
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            SizedBox(
              width: double.infinity,
              height: 70.h,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(4.r),
                    ),
                  ),
                  onPressed:
                      (state is AuthInitial && state.agreed) ||
                          (state is AuthError && state.agreed)
                      ? () {
                          final fullname = FormValidations
                              .fullNameController
                              .text
                              .trim();
                          final email = FormValidations
                              .signUpEmailController
                              .text
                              .trim();
                          final password =
                              FormValidations.signUpPasswordController.text;

                          context.read<AuthBloc>().add(
                            SignupRequested(
                              email: email,
                              password: password,
                              fullname: fullname,
                              context: context,
                            ),
                          );
                        }
                      : null,
                  child: Text(
                    "Create Account",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
