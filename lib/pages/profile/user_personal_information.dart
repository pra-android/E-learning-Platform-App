import 'dart:io';
import 'package:e_learning_platform/blocs/profilepicture/profile_picture_event.dart';
import 'package:e_learning_platform/blocs/user/user_states.dart';
import 'package:e_learning_platform/utilities/constants/colors_constant.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import '../../blocs/profilepicture/profile_picture_bloc.dart';
import '../../blocs/profilepicture/profile_picture_state.dart';
import '../../blocs/user/user_bloc.dart';

class UserPersonalInformation extends StatelessWidget {
  const UserPersonalInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserStates>(
      builder: (context, state) {
        if (state is UserLoading) {
          return Column(
            children: [
              Center(
                child: CircularProgressIndicator(color: AppColors.primaryColor),
              ),
            ],
          );
        } else if (state is UserLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocListener<ProfilePictureBloc, ProfilePictureState>(
                listener: (context, picState) {
                  if (picState is ProfileLoaded) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Profile picture updated!")),
                    );
                    // Refresh user data after upload
                  } else if (picState is ProfileError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Error: ${picState.message}")),
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(
                      state.user.username,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    subtitle: Text(
                      state.user.email,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 12.sp,
                      ),
                    ),
                    trailing: InkWell(
                      onTap: () async {
                        late FilePicker filePicker;
                        filePicker = FilePicker.platform;
                        final picked = await filePicker.pickFiles();
                        if (picked != null) {
                          // ignore: use_build_context_synchronously
                          context.read<ProfilePictureBloc>().add(
                            UploadProfilePictureEvent(
                              uid: FirebaseAuth.instance.currentUser!.uid,
                              imageFile: File(picked.files.first.path!),
                            ),
                          );
                        }
                      },
                      child: Icon(Iconsax.edit),
                    ),
                  ),
                ),
              ),
            ],
          );
        } else if (state is UserError) {
          return Center(
            child: Text(
              'Unable to load data..Please Check your internet connection',
              style: TextStyle(color: Colors.red),
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
