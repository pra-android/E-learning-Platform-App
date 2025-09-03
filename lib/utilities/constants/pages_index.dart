import 'package:e_learning_platform/pages/explore/explore.dart';
import 'package:e_learning_platform/pages/history/history.dart';
import 'package:e_learning_platform/pages/notification/notification_page.dart';
import 'package:e_learning_platform/pages/profile/profile_screen.dart';

import '../../pages/favourites/favourites.dart';

class PagesIndex {
  static List pagesOfIndex = [
    Explore(),
    Favourites(),
    History(),
    NotificationPage(),
    ProfileScreen(),
  ];
}
