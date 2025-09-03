import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_learning_platform/blocs/favourites/favourites_bloc.dart';
import 'package:e_learning_platform/blocs/favourites/favourites_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../blocs/favourites/favourites_event.dart';

class CourseHeader extends StatelessWidget {
  final Map<String, dynamic> course;
  const CourseHeader({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            CachedNetworkImage(
              imageUrl: course['imageUrl'],
              fit: BoxFit.fill,
              width: double.infinity,
              height: 250.h,
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
            Positioned(
              top: 40.h,
              left: 15.w,
              child: InkWell(
                onTap: () {
                  context.pop();
                },
                child: CircleAvatar(
                  backgroundColor: Colors.grey.shade200,
                  child: Icon(Icons.arrow_back_ios_new_outlined, size: 16.sp),
                ),
              ),
            ),
            Positioned(
              top: 40.h,
              right: 15.w,
              child: BlocBuilder<FavoritesBloc, FavouritesState>(
                builder: (context, state) {
                  bool isFav = false;
                  if (state is FavoriteLoaded) {
                    isFav = state.isFavorite;
                  }
                  return InkWell(
                    onTap: () {
                      context.read<FavoritesBloc>().add(
                        ToggleFavorite(course, context),
                      );
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.grey.shade200,
                      child: HugeIcon(
                        icon: HugeIcons.strokeRoundedFavourite,
                        color: isFav ? Colors.red : Colors.black,
                        size: 16.sp,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
