// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_learning_platform/blocs/comment/comment_bloc.dart';
import 'package:e_learning_platform/blocs/comment/comment_event.dart';
import 'package:e_learning_platform/models/purchasemodel/purchase_model.dart';
import 'package:e_learning_platform/services/comment_services.dart';
import 'package:e_learning_platform/utilities/widgets/custom_dialog.dart';
import 'package:esewa_flutter_sdk/esewa_config.dart';
import 'package:esewa_flutter_sdk/esewa_flutter_sdk.dart';
import 'package:esewa_flutter_sdk/esewa_payment.dart';
import 'package:esewa_flutter_sdk/esewa_payment_success_result.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../blocs/comment/comment_state.dart';
import '../../../blocs/course/course_bloc.dart';
import '../../../blocs/course/course_event.dart';
import '../../../blocs/course/course_states.dart';
import '../../../blocs/rating/rating_bloc.dart';
import '../../../blocs/rating/rating_event.dart';
import '../../../blocs/rating/rating_state.dart';
import '../../../services/rating_services.dart';
import '../../../utilities/constants/colors_constant.dart';

class PaidCourses extends StatelessWidget {
  const PaidCourses({super.key});

  @override
  Widget build(BuildContext context) {
    final dataAnalyticsBloc = CourseBloc(FirebaseFirestore.instance)
      ..add(LoadCoursesbyCategory("📊DataAnalytics"));

    return BlocProvider.value(
      value: dataAnalyticsBloc,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 12.w, top: 8.h, bottom: 8.h),
            child: Text(
              "Paid Courses",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 13.sp,
              ),
            ),
          ),
          BlocBuilder<CourseBloc, CourseStates>(
            bloc: dataAnalyticsBloc,
            builder: (context, state) {
              if (state is CourseLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                );
              } else if (state is CourseLoaded) {
                if (state.courses.isEmpty) {
                  return const Center(child: Text("No courses found."));
                }

                return ListView.separated(
                  padding: EdgeInsets.all(0),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: state.courses.length,
                  separatorBuilder: (_, __) => SizedBox(height: 14.h),
                  itemBuilder: (context, index) {
                    final course = state.courses[index];

                    return InkWell(
                      onTap: () async {
                        final userId = FirebaseAuth.instance.currentUser!.uid;
                        final priceType = course['priceType'];
                        if (priceType == "Free") {
                          context.pushNamed('coursedetails', extra: course);
                        } else {
                          final purchase = await getPurchase(
                            course['courseId'],
                            userId,
                          );
                          if (purchase != null) {
                            context.pushNamed('coursedetails', extra: course);
                          } else {
                            CustomDialogs.showCustomDialog(
                              context,
                              "Are you sure? Do you want to pay for the courses?",
                              () {
                                try {
                                  EsewaFlutterSdk.initPayment(
                                    esewaConfig: EsewaConfig(
                                      clientId:
                                          "JB0BBQ4aD0UqIThFJwAKBgAXEUkEGQUBBAwdOgABHD4DChwUAB0R",
                                      secretId:
                                          "BhwIWQQADhIYSxILExMcAgFXFhcOBwAKBgAXEQ==",
                                      environment: Environment.test,
                                    ),
                                    esewaPayment: EsewaPayment(
                                      productId: course["courseId"],
                                      productName: course["title"],
                                      productPrice: course['price'],
                                      callbackUrl: "",
                                    ),
                                    onPaymentSuccess:
                                        (EsewaPaymentSuccessResult es) async {
                                          await FirebaseFirestore.instance
                                              .collection("users")
                                              .doc(userId)
                                              .collection('purchasedCourses')
                                              .doc(course['courseId'])
                                              .set({
                                                "courseId": course['courseId'],
                                                "transactionId": es.refId,
                                                "amountPaid": course['price'],
                                                "paidAt": DateTime.now(),
                                                "courseName": course['title'],
                                                "userId": userId,
                                              });
                                          context.pushNamed(
                                            'coursedetails',
                                            extra: course,
                                          );
                                          context.pop();
                                        },
                                    onPaymentFailure: (error) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text("Payment Failed"),
                                        ),
                                      );
                                      context.pop();
                                    },
                                    onPaymentCancellation: (data) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text("Payment Cancelled"),
                                        ),
                                      );
                                      context.pop();
                                    },
                                  );
                                } catch (e) {
                                  debugPrint(e.toString());
                                }
                              },
                            );
                          }
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade200,
                                blurRadius: 8,
                                offset: const Offset(2, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Thumbnail
                              ClipRRect(
                                borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(14.r),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: course['imageUrl'],
                                  height: 110.h,
                                  width: 125.w,
                                  fit: BoxFit.fill,
                                  alignment: Alignment.topCenter,
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
                                            style: TextStyle(fontSize: 10.sp),
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

                              // Course Info
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(10.w),
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
                                      SizedBox(height: 6.h),
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
                                            color: Colors.amber,
                                            size: 16.sp,
                                          ),
                                          SizedBox(width: 3.w),

                                          // Rating
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
                                                ),
                                            child:
                                                BlocBuilder<
                                                  RatingBloc,
                                                  RatingState
                                                >(
                                                  builder: (context, state) {
                                                    if (state is RatingLoaded) {
                                                      return Text(
                                                        state.averageRating
                                                            .toStringAsFixed(1),
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 12.sp,
                                                        ),
                                                      );
                                                    }
                                                    return SizedBox.shrink();
                                                  },
                                                ),
                                          ),

                                          SizedBox(width: 12.w),

                                          // Comments
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
                                                      return Text(
                                                        "💬 ${state.commentModel.length}",
                                                        style: TextStyle(
                                                          fontSize: 12.sp,
                                                          color: Colors
                                                              .grey
                                                              .shade700,
                                                        ),
                                                      );
                                                    }
                                                    return SizedBox.shrink();
                                                  },
                                                ),
                                          ),
                                        ],
                                      ),

                                      SizedBox(height: 10.h),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
              return SizedBox();
            },
          ),
        ],
      ),
    );
  }

  Future<Purchase?> getPurchase(String courseId, String userId) async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('purchasedCourses')
        .doc(courseId)
        .get();
    if (doc.exists) {
      return Purchase.fromDoc(doc);
    } else {
      return null;
    }
  }
}
