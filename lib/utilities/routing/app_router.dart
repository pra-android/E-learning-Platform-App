import 'package:e_learning_platform/pages/admin/admin_page.dart';
import 'package:e_learning_platform/pages/authentication/login/forgot_password_screen.dart';
import 'package:e_learning_platform/pages/authentication/login/login.dart';
import 'package:e_learning_platform/pages/authentication/signup/signup.dart';
import 'package:e_learning_platform/pages/explore/coursedetails/course_details_pdf.dart';
import 'package:e_learning_platform/pages/homescreen/home_screen.dart';
import 'package:e_learning_platform/pages/privacypolicy/privacy_policy.dart';
import 'package:e_learning_platform/repositories/auth_repositories.dart';
import 'package:e_learning_platform/splash_screen.dart';
import 'package:go_router/go_router.dart';
import '../../pages/explore/coursedetails/course_details.dart';
import '../../pages/explore/coursedetails/course_video.dart';

class AppRouter {
  final AuthRepositories authRepositories;
  AppRouter({required this.authRepositories});

  GoRouter get router {
    return GoRouter(
      routes: [
        GoRoute(
          path: '/',
          name: 'splashscreen',
          builder: (context, state) => SplashScreen(),
        ),
        GoRoute(
          path: '/login',
          name: 'login',
          builder: (context, state) => LoginScreen(),
        ),
        GoRoute(
          path: '/signup',
          name: 'signup',
          builder: (context, state) => SignUp(),
        ),
        GoRoute(
          path: '/homepage',
          name: 'homepage',
          builder: (context, state) => HomeScreen(),
        ),
        GoRoute(
          path: '/forgotpassword',
          name: 'forgotpassword',
          builder: (context, state) => ForgotPasswordScreen(),
        ),
        GoRoute(
          path: '/privacypolicy',
          name: 'privacypolicy',
          builder: (context, state) => PrivacyPolicy(),
        ),
        GoRoute(
          path: '/coursedetails',
          name: 'coursedetails',
          builder: (context, state) {
            final course = state.extra as Map<String, dynamic>;
            return CourseDetails(course: course);
          },
        ),
        GoRoute(
          path: '/adminpage',
          name: 'adminpage',
          builder: (context, state) => AdminPage(),
        ),
        GoRoute(
          path: '/coursepdf',
          name: 'coursepdf',
          builder: (context, state) {
            final course = state.extra as String;
            return CourseDetailsPdf(url: course);
          },
        ),
        GoRoute(
          name: 'coursevideo',
          path: '/coursevideo',
          builder: (context, state) {
            final videoUrl = state.extra as String;
            return CourseVideo(videoUrl: videoUrl);
          },
        ),
      ],
    );
  }
}
