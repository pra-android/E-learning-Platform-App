import 'package:e_learning_platform/blocs/rating/rating_state.dart';
import 'package:e_learning_platform/utilities/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../blocs/rating/rating_bloc.dart';
import '../../../../blocs/rating/rating_event.dart';

class CourseRatingSection extends StatelessWidget {
  final String courseId;
  const CourseRatingSection({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "★ Course Rating",
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.h),
          BlocBuilder<RatingBloc, RatingState>(
            builder: (context, state) {
              double averageRating = 0.0;

              if (state is RatingLoading) {
                return const CircularProgressIndicator();
              } else if (state is RatingLoaded) {
                averageRating = state.averageRating;
              } else if (state is RatingError) {
                return Text(
                  "Error: ${state.message}",
                  style: TextStyle(color: Colors.red),
                );
              }

              return Row(
                children: List.generate(5, (index) {
                  int starIndex = index + 1;
                  return GestureDetector(
                    onTap: () {
                      CustomDialogs.showCustomDialog(
                        context,
                        "Are you sure do you want to give rating to this course",
                        () {
                          context.read<RatingBloc>().add(
                            SubmitRating(courseId, starIndex),
                          );
                          context.pop();
                        },
                      );
                    },
                    child: Icon(
                      Icons.star,
                      size: 28.sp,
                      color: starIndex <= averageRating
                          ? Colors.green
                          : Colors.grey[300],
                    ),
                  );
                }),
              );
            },
          ),
        ],
      ),
    );
  }
}
