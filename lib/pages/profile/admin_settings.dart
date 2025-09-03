import 'package:e_learning_platform/blocs/user/user_bloc.dart';
import 'package:e_learning_platform/blocs/user/user_states.dart';
import 'package:e_learning_platform/utilities/widgets/profile_menu_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

class AdminSettings extends StatelessWidget {
  const AdminSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserStates>(
      builder: (context, state) {
        if (state is UserLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (state.user.role == 'admin') ...[
                Padding(
                  padding: EdgeInsets.only(left: 10.w, top: 10.h),
                  child: Text(
                    "Admin Settings",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                ProfileMenuCard(
                  icon: Iconsax.user,
                  title: 'Admin Access',
                  subtitle: 'Only admin can acccess this features',

                  onTap: () {
                    context.pushNamed('adminpage');
                  },
                ),
              ],
            ],
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
