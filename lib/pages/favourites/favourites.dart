import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_learning_platform/blocs/favourites/favourites_bloc.dart';
import 'package:e_learning_platform/blocs/favourites/favourites_event.dart';
import 'package:e_learning_platform/blocs/favourites/favourites_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class Favourites extends StatelessWidget {
  const Favourites({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FavoritesBloc()..add(LoadAllFavorites()),
      child: BlocBuilder<FavoritesBloc, FavouritesState>(
        builder: (context, state) {
          if (state is FavouriteLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is AllFavoritesLoaded) {
            final favourites = state.favourites;
            if (favourites.isEmpty) {
              return Column(
                children: [
                  SizedBox(height: 35.h),
                  Padding(
                    padding: EdgeInsets.only(left: 0.w),
                    child: Center(
                      child: Text(
                        "Favourites",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 250.h),
                  Center(child: Text("Oops!....No favourites yet 💔")),
                ],
              );
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 35.h),
                  Padding(
                    padding: EdgeInsets.only(left: 0.w),
                    child: Center(
                      child: Text(
                        "Favourites",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  //Courses
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.all(8.w),
                    child: GridView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.75,
                        crossAxisCount: 2,
                        mainAxisSpacing: 10.h,
                        crossAxisSpacing: 15.h,
                      ),
                      itemCount: favourites.length,
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      itemBuilder: (context, index) {
                        final course = favourites[index];
                        return Padding(
                          padding: EdgeInsets.only(right: 12.w),
                          child: InkWell(
                            onTap: () {
                              context.pushNamed('coursedetails', extra: course);
                            },
                            child: Container(
                              width: 160.w,
                              height: 200.h,
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
                                      imageUrl: course['imageUrl']!,
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
                                                style: TextStyle(
                                                  fontSize: 11.sp,
                                                ),
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
                                          course['title']!,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 4.h),
                                        Text(
                                          course['description']!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                        SizedBox(height: 6.h),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Colors.black,
                                              size: 14.sp,
                                            ),
                                            SizedBox(width: 4.w),
                                            Text(
                                              "${course['rating'] ?? 0.toString()} (${course['comments']})",
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                color: Colors.black,
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
                ],
              ),
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
