import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_learning_platform/blocs/tabs/study_materials_bloc.dart';
import 'package:e_learning_platform/blocs/tabs/study_materials_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

class StudyMaterialTabContents extends StatelessWidget {
  final Map<String, dynamic> course;
  const StudyMaterialTabContents({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 85.h,
      child: BlocBuilder<StudyMaterialsBloc, StudyMaterialsState>(
        builder: (context, state) {
          if (state is StudyMaterialTabLoadedState) {
            return IndexedStack(
              index: state.selectedIndex,
              children: [
                // Tab 0 content
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        final videoUrl = course['videoUrl'];
                        context.pushNamed('coursevideo', extra: videoUrl);
                      },
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(12.r),
                          child: CachedNetworkImage(
                            imageUrl: course['imageUrl'],
                            height: 80.h,
                            width: 80.w,
                            errorWidget: (context, url, error) {
                              return Container(
                                height: 90.h,
                                width: 90.w,
                                child: Column(
                                  children: [
                                    Text("Unable to load Images"),
                                    Icon(Icons.error_outline, size: 45.sp),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),

                        title: Text(
                          "${course['title']}",
                          style: GoogleFonts.lato(),
                        ),
                        subtitle: Text(course['duration']),
                        trailing: HugeIcon(
                          icon: HugeIcons.strokeRoundedView,
                          size: 14.sp,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    Divider(),
                  ],
                ),

                // Tab 1 content
                Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        final pdfUrl = course['pdfs'][0];
                        context.pushNamed('coursepdf', extra: pdfUrl);
                      },
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(12.r),
                          child: CachedNetworkImage(
                            imageUrl: course['imageUrl'],
                            height: 80.h,
                            width: 80.w,
                            errorWidget: (context, url, error) => Container(
                              height: 90.h,
                              width: 90.w,
                              child: Column(
                                children: [
                                  Text("Unable to load Images"),
                                  Icon(Icons.error_outline, size: 45.sp),
                                ],
                              ),
                            ),
                          ),
                        ),

                        title: Text(
                          "${course['title']}",
                          style: GoogleFonts.lato(),
                        ),
                        subtitle: Text("Pages: ${course['pages']}"),
                        trailing: HugeIcon(
                          icon: HugeIcons.strokeRoundedPdf01,
                          size: 18.sp,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    Divider(),
                  ],
                ),

                // Tab 2 content
                Column(
                  children: [
                    SizedBox(height: 15.h),
                    Center(
                      child: Text(
                        "Q/A is coming soon",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
