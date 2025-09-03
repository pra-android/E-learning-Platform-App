import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../blocs/categories/categories_bloc.dart';
import '../../blocs/categories/categories_state.dart';
import '../../blocs/categoriesselection/categories_selection_bloc.dart';
import '../../blocs/categoriesselection/categories_selection_event.dart';

class ExploreCategories extends StatelessWidget {
  const ExploreCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CourseCategoriesState>(
      builder: (context, state) {
        if (state is CourseCategoriesLoading) {
          return Center(child: CircularProgressIndicator(color: Colors.white));
        } else if (state is CourseCategoriesLoaded) {
          return SizedBox(
            height: 55.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.categories.length,
              shrinkWrap: true,

              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(top: 2.h, right: 5.w),
                  child: InkWell(
                    onTap: () {
                      context.read<CategorySelectionBloc>().add(
                        SelectCategoryEvent(state.categories[index]),
                      );
                    },

                    child: Padding(
                      padding: EdgeInsets.only(top: 12.h, left: 8.w),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(width: 1, color: Colors.white),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(5.w),
                          child: Row(
                            children: [
                              Text(
                                state.categories[index],
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
        return SizedBox();
      },
    );
  }
}
