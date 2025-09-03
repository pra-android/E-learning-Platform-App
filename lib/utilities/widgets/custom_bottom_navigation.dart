import 'package:e_learning_platform/blocs/bottomnavigation/bottom_navigation_event.dart';
import 'package:e_learning_platform/blocs/bottomnavigation/bottom_navigation_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import '../../blocs/bottomnavigation/bottom_navigation_bloc.dart';
import '../constants/colors_constant.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
      builder: (context, state) {
        return BottomNavigationBar(
          elevation: 4,
          currentIndex: state.selectedIndex,
          onTap: (index) {
            context.read<BottomNavigationBloc>().add(
              BottomNavigationElementPressed(index: index),
            );
          },
          showUnselectedLabels: true,
          showSelectedLabels: true,
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: Colors.black,

          items: [
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Icon(Iconsax.home, color: Colors.black),
              activeIcon: Icon(Iconsax.home, color: AppColors.primaryColor),
              label: "Home",
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.white,

              icon: Icon(
                Iconsax.heart,
                color: Colors.black, // unselected
              ),
              activeIcon: Icon(
                Iconsax.heart,
                color: AppColors.primaryColor, // selected
              ),
              label: "Favourties",
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Icon(
                Iconsax.transaction_minus,
                color: Colors.black, // unselected
              ),
              activeIcon: Icon(
                Iconsax.transaction_minus,
                color: AppColors.primaryColor, // selected
              ),
              label: "History",
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Icon(
                Iconsax.notification,
                color: Colors.black, // unselected
              ),
              activeIcon: Icon(
                Iconsax.notification,
                color: AppColors.primaryColor, // selected
              ),
              label: "Notifications",
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Icon(
                Iconsax.user,
                color: Colors.black, // unselected
              ),
              activeIcon: Icon(
                Iconsax.user,
                color: AppColors.primaryColor, // selected
              ),
              label: "Profile",
            ),
          ],
        );
      },
    );
  }
}
