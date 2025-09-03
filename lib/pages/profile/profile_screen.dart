import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_learning_platform/pages/profile/additionalfeatures/additional_features_list.dart';
import 'package:e_learning_platform/pages/profile/additionalfeatures/additional_features_title.dart';
import 'package:e_learning_platform/pages/profile/admin_settings.dart';
import 'package:e_learning_platform/pages/profile/profile_image.dart';
import 'package:e_learning_platform/pages/profile/user_personal_information.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../blocs/profilepicture/profile_picture_bloc.dart';
import '../../blocs/profilepicture/profile_picture_event.dart';
import '../../blocs/user/user_bloc.dart';
import '../../blocs/user/user_event.dart';
import '../../services/user_services.dart';
import '../../utilities/constants/colors_constant.dart';
import '../../utilities/widgets/curver_clipper.dart';
import '../../utilities/widgets/u_circular_container.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (context) =>
              UserBloc(UserServices(FirebaseFirestore.instance))
                ..add(LoadUserEvent(FirebaseAuth.instance.currentUser!.uid)),
        ),
        BlocProvider<ProfilePictureBloc>(
          create: (context) =>
              ProfilePictureBloc(firestore: FirebaseFirestore.instance)..add(
                LoadProfilePictureEvent(
                  uid: FirebaseAuth.instance.currentUser!.uid,
                ),
              ),
        ),
      ],
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                ClipPath(
                  clipper: CurveClipper(),
                  child: Container(
                    height: 130.h,
                    decoration: BoxDecoration(color: AppColors.primaryColor),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          top: -70.h,
                          right: -90.w,
                          child: UCircularContainer(),
                        ),
                        Positioned(
                          top: 50.h,
                          right: -140.w,
                          child: UCircularContainer(),
                        ),
                      ],
                    ),
                  ),
                ),

                Positioned(
                  bottom: -20.h,
                  left: 0,
                  right: 0,
                  child: Center(child: ProfileImage()),
                ),
              ],
            ),

            SizedBox(height: 20.h),

            UserPersonalInformation(),
            AdminSettings(),
            AdditionalFeaturesTitle(),
            AdditionalFeaturesList(),
          ],
        ),
      ),
    );
  }
}
