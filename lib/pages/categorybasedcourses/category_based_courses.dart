import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_learning_platform/blocs/comment/comment_bloc.dart';
import 'package:e_learning_platform/blocs/comment/comment_event.dart';
import 'package:e_learning_platform/blocs/comment/comment_state.dart';
import 'package:e_learning_platform/blocs/course/course_bloc.dart';
import 'package:e_learning_platform/blocs/course/course_states.dart';
import 'package:e_learning_platform/blocs/rating/rating_bloc.dart';
import 'package:e_learning_platform/blocs/rating/rating_event.dart';
import 'package:e_learning_platform/blocs/rating/rating_state.dart';
import 'package:e_learning_platform/services/comment_services.dart';
import 'package:e_learning_platform/services/rating_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CategoryBasedCourses extends StatelessWidget {
  const CategoryBasedCourses({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseBloc, CourseStates>(
      builder: (context, state) {
        if (state is CourseLoading) {
          return SizedBox(
            height: 220.h,
            child: const Center(child: CircularProgressIndicator()),
          );
        } else if (state is CourseLoaded) {
          if (state.courses.isEmpty) {
            return SizedBox(
              height: 220.h,
              child: const Center(child: Text("No courses found.")),
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 7.w),
                child: Text(
                  "Category Based Courses",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 13.sp,
                  ),
                ),
              ),

              SizedBox(
                height: 220.h,
                child: Padding(
                  padding: EdgeInsets.all(4.w),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    itemCount: state.courses.length,
                    itemBuilder: (context, index) {
                      final course = state.courses[index];
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
                                  blurRadius: 6,
                                  offset: const Offset(2, 2),
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
                                    errorWidget: (context, url, error) {
                                      return Container(
                                        height: 90.h,
                                        width: 90.w,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Unable to load Images",
                                              style: TextStyle(fontSize: 11.sp),
                                            ),
                                            Icon(
                                              Icons.error_outline,
                                              size: 45.sp,
                                            ),
                                          ],
                                        ),
                                      );
                                    },
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
                                          fontSize: 13.sp,
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
                                      SizedBox(height: 8.h),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: Colors.black,
                                            size: 14.sp,
                                          ),
                                          SizedBox(width: 2.w),

                                          //Rating
                                          BlocProvider(
                                            create: (_) =>
                                                RatingBloc(
                                                  RatingServices(
                                                    FirebaseFirestore.instance,
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
                                                    if (state is RatingLoaded) {
                                                      return Row(
                                                        children: [
                                                          SizedBox(width: 4),
                                                          Text(
                                                            state.averageRating
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
                                                    FirebaseFirestore.instance,
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
              ),
            ],
          );
        }
        return SizedBox();
      },
    );
  }
}
