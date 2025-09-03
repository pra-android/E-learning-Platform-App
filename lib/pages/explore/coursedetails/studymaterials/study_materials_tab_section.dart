import 'package:e_learning_platform/blocs/tabs/study_materials_bloc.dart';
import 'package:e_learning_platform/blocs/tabs/study_materials_event.dart';
import 'package:e_learning_platform/blocs/tabs/study_materials_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utilities/constants/course_tab_section_constant.dart';

class StudyMaterialsTabSection extends StatelessWidget {
  const StudyMaterialsTabSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8.w),
          child: Text(
            "Study Materials",
            style: GoogleFonts.lato(
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: 14.5.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 40.h,

          child: Center(
            child: BlocBuilder<StudyMaterialsBloc, StudyMaterialsState>(
              builder: (context, state) {
                return ListView.separated(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w),
                  separatorBuilder: (context, index) {
                    return SizedBox(width: 20.w);
                  },
                  shrinkWrap: true,
                  itemCount: CourseTabSectionConstant.tabSections.length,
                  physics: ScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            context.read<StudyMaterialsBloc>().add(
                              TabChanged(index: index),
                            );
                          },
                          child: Container(
                            height: 35.h,

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color:
                                  // state is StudyMaterialTabLoadedState &&
                                  //     state.selectedIndex == index
                                  Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    CourseTabSectionConstant.tabSections[index],
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      decoration:
                                          state is StudyMaterialTabLoadedState &&
                                              state.selectedIndex == index
                                          ? TextDecoration.underline
                                          : TextDecoration.none,
                                      // decorationColor: AppColors.primaryColor,
                                      // decorationThickness: 3.5,
                                    ),
                                  ),
                                  SizedBox(width: 4.w),
                                  Icon(
                                    CourseTabSectionConstant.tabIcons[index],
                                    color: Colors.white,
                                    size: 12.sp,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
