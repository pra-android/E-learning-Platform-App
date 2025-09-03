import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_learning_platform/blocs/comment/comment_bloc.dart';
import 'package:e_learning_platform/blocs/comment/comment_event.dart';
import 'package:e_learning_platform/blocs/comment/comment_state.dart';
import 'package:e_learning_platform/blocs/course/course_states.dart';
import 'package:e_learning_platform/blocs/rating/rating_bloc.dart'
    show RatingBloc;
import 'package:e_learning_platform/services/comment_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../blocs/course/course_bloc.dart';
import '../../../blocs/course/course_event.dart';
import '../../../blocs/rating/rating_event.dart';
import '../../../blocs/rating/rating_state.dart';
import '../../../services/rating_services.dart';
import '../../../utilities/constants/colors_constant.dart';

class FreeUnpaidCourses extends StatelessWidget {
  const FreeUnpaidCourses({super.key});

  @override
  Widget build(BuildContext context) {
    final marketingBloc = CourseBloc(FirebaseFirestore.instance)
      ..add(LoadCoursesbyCategory("📈Marketing"));
    return BlocProvider.value(
      value: marketingBloc,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 7.w, top: 7.h),
            child: Text(
              "Free Unpaid Courses",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 13.sp,
              ),
            ),
          ),
          BlocBuilder<CourseBloc, CourseStates>(
            bloc: marketingBloc,
            builder: (context, state) {
              if (state is CourseLoading) {
                return SizedBox(
                  height: 220.h,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  ),
                );
              } else if (state is CourseLoaded) {
                if (state.courses.isEmpty) {
                  return const Center(child: Text("No courses found."));
                }
                return SizedBox(
                  height: 220.h,
                  child: Padding(
                    padding: EdgeInsets.all(4.w),
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: state.courses.length,
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      itemBuilder: (context, index) {
                        final course = state.courses[index];
                        print("Courses are $course");
                        return Padding(
                          padding: EdgeInsets.only(right: 12.w),
                          child: InkWell(
                            onTap: () {
                              context.pushNamed('coursedetails', extra: course);
                            },
                            child: Container(
                              width: 160.w,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade50,
                                borderRadius: BorderRadius.circular(12.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade200,
                                    blurRadius: 4,
                                    offset: Offset(2, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(12.r),
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: course['imageUrl'],
                                      height: 90.h,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator(
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Container(
                                            height: 90.h,
                                            width: 90.w,
                                            child: Column(
                                              children: [
                                                Text("Unable to load Images"),
                                                Icon(
                                                  Icons.error_outline,
                                                  size: 45.sp,
                                                ),
                                              ],
                                            ),
                                          ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          course['title'],
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(height: 4.h),
                                        Text(
                                          course['description'],
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 11.sp,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                        SizedBox(height: 6.h),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                              size: 14.sp,
                                            ),
                                            SizedBox(width: 2.w),

                                            //Rating
                                            BlocProvider(
                                              create: (_) =>
                                                  RatingBloc(
                                                    RatingServices(
                                                      FirebaseFirestore
                                                          .instance,
                                                    ),
                                                  )..add(
                                                    FetchRating(
                                                      course['courseId'],
                                                    ),
                                                  ), // <-- pass courseId here
                                              child:
                                                  BlocBuilder<
                                                    RatingBloc,
                                                    RatingState
                                                  >(
                                                    builder: (context, state) {
                                                      if (state
                                                          is RatingLoaded) {
                                                        return Row(
                                                          children: [
                                                            SizedBox(width: 4),
                                                            Text(
                                                              state
                                                                  .averageRating
                                                                  .toString(),
                                                            ),
                                                          ],
                                                        );
                                                      }
                                                      return SizedBox.shrink();
                                                    },
                                                  ),
                                            ),
                                            //comments
                                            BlocProvider(
                                              create: (_) =>
                                                  CommentBloc(
                                                    CommentServices(
                                                      FirebaseFirestore
                                                          .instance,
                                                    ),
                                                  )..add(
                                                    LoadComment(
                                                      course['courseId'],
                                                    ),
                                                  ),

                                              child:
                                                  BlocBuilder<
                                                    CommentBloc,
                                                    CommentState
                                                  >(
                                                    builder: (context, state) {
                                                      if (state
                                                          is CommentLoaded) {
                                                        return Row(
                                                          children: [
                                                            SizedBox(width: 4),
                                                            Text(
                                                              "💬 ${state.commentModel.length}",
                                                            ),
                                                          ],
                                                        );
                                                      }
                                                      return SizedBox.shrink();
                                                    },
                                                  ),
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
                      },
                    ),
                  ),
                );
              }
              return SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
