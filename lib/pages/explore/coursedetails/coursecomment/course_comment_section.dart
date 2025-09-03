import 'package:e_learning_platform/blocs/comment/comment_bloc.dart';
import 'package:e_learning_platform/blocs/comment/comment_event.dart';
import 'package:e_learning_platform/utilities/constants/colors_constant.dart';
import 'package:e_learning_platform/utilities/formvalidation/form_validation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../blocs/comment/comment_state.dart';
import '../../../../models/commentsmodel/comments_model.dart';

class CourseCommentSection extends StatelessWidget {
  final String courseId;
  const CourseCommentSection({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "💬 Feedback about course",
            style: TextStyle(
              color: Colors.black87,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12.h),

          // Comment Input Row
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: FormValidations.courseComment,
                  style: TextStyle(fontSize: 14.sp),
                  decoration: InputDecoration(
                    hintText: "Write a comment...",
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    border: InputBorder.none,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (FormValidations.courseComment.text.trim().isEmpty) {
                    return;
                  } else {
                    final comment = CommentModel(
                      userId: FirebaseAuth.instance.currentUser!.uid,
                      username:
                          FirebaseAuth.instance.currentUser!.displayName ??
                          "No Name",
                      comment: FormValidations.courseComment.text.trim(),
                      createdAt: DateTime.now(),
                    );

                    context.read<CommentBloc>().add(
                      AddComment(courseId, comment),
                    );
                  }
                },
                child: Padding(
                  padding: EdgeInsets.all(8.w),
                  child: Container(
                    width: 40.w,
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.send_rounded,
                      size: 20.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),

          BlocBuilder<CommentBloc, CommentState>(
            builder: (context, state) {
              if (state is CommentLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                );
              } else if (state is CommentLoaded) {
                final comments = state.commentModel;
                if (comments.isEmpty) {
                  return SizedBox(
                    height: 50.h,
                    child: Center(child: Text("No comments yet.")),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: comments.length,
                  itemBuilder: (_, index) {
                    final comment = comments[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      child: Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: Colors
                              .grey[100], // subtle background for each comment
                          borderRadius: BorderRadius.circular(14.r),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primaryColor,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // User Avatar
                            CircleAvatar(
                              radius: 18.r,
                              backgroundColor: AppColors.primaryColor,
                              child: Text(
                                comment.username[0]
                                    .toUpperCase(), // first letter as avatar
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(width: 10.w),
                            // Comment Content
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    comment.username,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.sp,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    comment.comment,
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: Colors.black87,
                                      height: 1.3, // better line spacing
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else if (state is CommentError) {
                return Center(child: Text("Error: ${state.commentError}"));
              } else {
                return Center(child: Text("No comments yet."));
              }
            },
          ),
        ],
      ),
    );
  }
}
