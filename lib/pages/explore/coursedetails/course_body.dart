import 'package:e_learning_platform/blocs/rating/rating_bloc.dart';
import 'package:e_learning_platform/blocs/rating/rating_state.dart';
import 'package:e_learning_platform/utilities/constants/colors_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';

class CourseBody extends StatelessWidget {
  final Map<String, dynamic> course;
  const CourseBody({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            course['title'],
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(width: 20.w),
                BlocBuilder<RatingBloc, RatingState>(
                  builder: (context, state) {
                    if (state is RatingLoaded) {
                      return Row(
                        children: [
                          Icon(Icons.star, color: Colors.green),
                          Text(state.averageRating.toString()),
                        ],
                      );
                    }
                    return SizedBox.shrink();
                  },
                ),

                SizedBox(width: 20.h),
                Row(
                  children: [
                    HugeIcon(
                      icon: HugeIcons.strokeRoundedWatch01,
                      color: Colors.grey.shade300,
                    ),

                    Text(
                      "Duration: " + course['duration'],
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(right: 40.w),
              child: Container(
                height: 35.h,
                width: 65.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.r),
                  border: Border.all(width: 1, color: AppColors.primaryColor),
                  color: Colors.white,
                ),
                child: Center(
                  child: Text(
                    course['priceType'] == 'Paid'
                        ? "Rs ${course['price']}"
                        : "FREE",
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 8.w),
          child: Text(
            "About Course",
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.w),
          child: Text(
            course['description'],
            style: TextStyle(color: Colors.grey.shade800),
          ),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }
}
