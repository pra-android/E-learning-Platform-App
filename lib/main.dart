import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_learning_platform/blocs/auth/auth_bloc.dart';
import 'package:e_learning_platform/blocs/biometric/biometric_auth_bloc.dart';
import 'package:e_learning_platform/blocs/categories/categories_bloc.dart';
import 'package:e_learning_platform/blocs/categories/categories_event.dart';
import 'package:e_learning_platform/blocs/categoriesselection/categories_selection_bloc.dart';
import 'package:e_learning_platform/blocs/course/course_bloc.dart';
import 'package:e_learning_platform/blocs/rating/rating_bloc.dart';
import 'package:e_learning_platform/firebase_options.dart';
import 'package:e_learning_platform/services/auth_services.dart';
import 'package:e_learning_platform/services/course_categories_services.dart';
import 'package:e_learning_platform/services/rating_services.dart';
import 'package:e_learning_platform/utilities/routing/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  print("Handling a background message: ${message.notification!.title}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation
        .portraitDown, // optional, if you want upside-down portrait
  ]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authRepo = AuthServices();
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        // final uid = FirebaseAuth.instance.currentUser?.uid;
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => AuthBloc(authRepo)),
            BlocProvider(create: (_) => BiometricAuthBloc()),
            BlocProvider(create: (_) => CategorySelectionBloc()),
            BlocProvider(create: (_) => CourseBloc(FirebaseFirestore.instance)),

            BlocProvider(
              create: (_) =>
                  RatingBloc(RatingServices(FirebaseFirestore.instance)),
            ),

            //Connecting to UI for Categories
            BlocProvider(
              create: (_) => CategoriesBloc(
                CourseCategoriesServices(FirebaseFirestore.instance),
              )..add(LoadCategoriesEvent()),
            ),

            //Connecting to UI For Category Selection
            BlocProvider(create: (_) => CategorySelectionBloc()),
          ],
          child: MaterialApp.router(
            routerConfig: AppRouter(authRepositories: authRepo).router,
            debugShowCheckedModeBanner: false,
          ),
        );
      },
    );
  }
}
