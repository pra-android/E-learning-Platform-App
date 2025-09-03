import 'package:e_learning_platform/blocs/bottomnavigation/bottom_navigation_bloc.dart';
import 'package:e_learning_platform/blocs/bottomnavigation/bottom_navigation_state.dart';
import 'package:e_learning_platform/utilities/constants/pages_index.dart';
import 'package:e_learning_platform/utilities/widgets/custom_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/fcm_services.dart';
import '../../services/notification_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    NotificationServices notificationServices = NotificationServices();
    notificationServices.requestNotification(context); //askin permission
    notificationServices.getDeviceToken(); //asking device token
    FcmServices.firebaseInit();
    notificationServices.firebaseInit(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BottomNavigationBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
          builder: (context, state) {
            return PagesIndex.pagesOfIndex[state.selectedIndex];
          },
        ),
        bottomNavigationBar: CustomBottomNavigation(),
      ),
    );
  }
}
