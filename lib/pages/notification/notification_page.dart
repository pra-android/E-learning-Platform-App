// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_learning_platform/blocs/bottomnavigation/bottom_navigation_bloc.dart';
import 'package:e_learning_platform/blocs/bottomnavigation/bottom_navigation_event.dart';
import 'package:e_learning_platform/blocs/bottomnavigation/bottom_navigation_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../blocs/notifications/notification_bloc.dart';
import '../../blocs/notifications/notification_event.dart';
import '../../blocs/notifications/notification_state.dart';
import '../../utilities/constants/colors_constant.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          NotificationBloc(firestore: FirebaseFirestore.instance)
            ..add(LoadNotifications()),
      child: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          if (state is NotificationLoading) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            );
          } else if (state is NotificationLoaded) {
            if (state.notifications.isEmpty) {
              return Center(child: Text("Oops!....No notifications yet 🔔"));
            }
            return Column(
              children: [
                SizedBox(height: 35.h),
                Center(
                  child: Text(
                    "Notifications 🔔",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  padding: EdgeInsets.only(top: 15.h),
                  itemCount: state.notifications.length,
                  itemBuilder: (context, index) {
                    final notification = state.notifications[index];
                    return Column(
                      children: [
                        BlocListener<
                          BottomNavigationBloc,
                          BottomNavigationState
                        >(
                          listener: (context, state) {},
                          child: ListTile(
                            leading: Icon(
                              Icons.notifications,
                              color: AppColors.primaryColor,
                            ),
                            title: Text(notification["title"] ?? "No Title"),
                            subtitle: Text(
                              notification["body"] ?? "",
                              style: TextStyle(overflow: TextOverflow.ellipsis),
                              maxLines: 1,
                            ),
                            trailing: Text(
                              (notification["createdAt"] is Timestamp)
                                  ? (notification["createdAt"] as Timestamp)
                                        .toDate()
                                        .toString()
                                  : notification["createdAt"].toString(),
                            ),
                            onTap: () async {
                              context.read<BottomNavigationBloc>().add(
                                BottomNavigationElementPressed(index: 0),
                              );
                            },
                          ),
                        ),

                        Divider(),
                      ],
                    );
                  },
                ),
              ],
            );
          } else if (state is NotificationError) {
            return Center(child: Text(state.message));
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
