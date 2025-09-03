import 'package:e_learning_platform/blocs/profilepicture/profile_picture_bloc.dart';

import 'package:e_learning_platform/utilities/constants/image_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../blocs/profilepicture/profile_picture_state.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfilePictureBloc, ProfilePictureState>(
      builder: (context, state) {
        if (state is ProfileLoaded) {
          return Container(
            height: 95.h,
            width: 95.w,

            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,

              // image: DecorationImage(
              //   image: NetworkImage(state.imageUrl),
              //   fit: BoxFit.cover,
              // ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: ClipOval(
              child: Image.network(
                state.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    ImageConstant.profileImage, // fallback
                    fit: BoxFit.cover,
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  );
                },
              ),
            ),
          );
        }
        if (state is ProfileLoading) {
          return Center(child: SizedBox());
        } else {
          return Container(
            height: 95.h,
            width: 95.w,

            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              image: DecorationImage(
                image: AssetImage(ImageConstant.profileImage),
              ),
            ),
          );
        }
      },
    );
  }
}
