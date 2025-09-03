import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_learning_platform/blocs/favourites/favourites_bloc.dart';
import 'package:e_learning_platform/blocs/favourites/favourites_event.dart';
import 'package:e_learning_platform/blocs/rating/rating_bloc.dart';
import 'package:e_learning_platform/blocs/rating/rating_event.dart';
import 'package:e_learning_platform/blocs/tabs/study_materials_bloc.dart';
import 'package:e_learning_platform/pages/explore/coursedetails/course_body.dart';
import 'package:e_learning_platform/pages/explore/coursedetails/course_header.dart';
import 'package:e_learning_platform/pages/explore/coursedetails/coursecomment/course_comment_section.dart';
import 'package:e_learning_platform/pages/explore/coursedetails/courserating/course_rating.dart';
import 'package:e_learning_platform/pages/explore/coursedetails/studymaterials/study_material_tab_contents.dart';
import 'package:e_learning_platform/pages/explore/coursedetails/studymaterials/study_materials_tab_section.dart';
import 'package:e_learning_platform/services/rating_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/comment/comment_bloc.dart';
import '../../../blocs/comment/comment_event.dart';
import '../../../services/comment_services.dart';

class CourseDetails extends StatefulWidget {
  final Map<String, dynamic> course;
  const CourseDetails({super.key, required this.course});

  @override
  State<CourseDetails> createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) {
            return CommentBloc(CommentServices(FirebaseFirestore.instance))
              ..add(LoadComment(widget.course['courseId']));
          },
        ),
        BlocProvider(create: (_) => StudyMaterialsBloc()),
        BlocProvider(
          create: (_) =>
              FavoritesBloc()
                ..add(LoadFavoriteStatus(widget.course['courseId'])),
        ),
        BlocProvider(
          create: (_) {
            return RatingBloc(RatingServices(FirebaseFirestore.instance))
              ..add(FetchRating(widget.course['courseId']));
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //Course Details Header
              CourseHeader(course: widget.course),

              //Course Details Body
              CourseBody(course: widget.course),

              // Study Material Tabs
              StudyMaterialsTabSection(),

              // Study Material Tab Contents
              StudyMaterialTabContents(course: widget.course),

              CourseRatingSection(courseId: widget.course['courseId']),
              //Course Comments
              CourseCommentSection(courseId: widget.course['courseId']),
            ],
          ),
        ),
      ),
    );
  }
}
