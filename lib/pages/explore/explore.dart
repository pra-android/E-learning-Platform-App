import 'package:e_learning_platform/blocs/categoriesselection/categories_selection_state.dart';
import 'package:e_learning_platform/blocs/course/course_bloc.dart';
import 'package:e_learning_platform/blocs/course/course_event.dart';
import 'package:e_learning_platform/pages/categorybasedcourses/category_based_courses.dart';
import 'package:e_learning_platform/pages/explore/explore_banner.dart';
import 'package:e_learning_platform/pages/explore/explore_header.dart';
import 'package:e_learning_platform/pages/explore/freeunpaidcourses/free_unpaid_courses.dart';
import 'package:e_learning_platform/pages/explore/paidcourses/paid_courses.dart';
import 'package:e_learning_platform/utilities/widgets/curver_clipper.dart';
import 'package:e_learning_platform/utilities/widgets/u_circular_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../blocs/categoriesselection/categories_selection_bloc.dart';
import '../../utilities/constants/colors_constant.dart';
import 'explore_categories.dart';

class Explore extends StatelessWidget {
  const Explore({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CategorySelectionBloc, CategorySelectionState>(
      listener: (context, state) {
        if (state is CategorySelected) {
          debugPrint("Chosen category: ${state.category}");
          context.read<CourseBloc>().add(LoadCoursesbyCategory(state.category));
        }
      },
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipPath(
              clipper: CurveClipper(),
              child: Container(
                height: 200.h,
                width: MediaQuery.of(context).size.width,
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
                    ExploreHeader(),
                    Positioned(
                      top: 90.h,
                      left: 0.w,
                      right: 0.w,
                      child: ExploreCategories(),
                    ),
                  ],
                ),
              ),
            ),
            //banner
            ExploreBanner(),

            CategoryBasedCourses(),
            //Unpaid Courses
            FreeUnpaidCourses(),
            //Paid Courses
            PaidCourses(),
          ],
        ),
      ),
    );
  }
}
