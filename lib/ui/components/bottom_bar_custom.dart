import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:accessibility_app/ui/pages/landing/landing_cubit.dart';
import 'package:accessibility_app/utils/colors.dart';

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({
    super.key,
    required this.currentIndex,
  });

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black54.withOpacity(0.4),
            blurRadius: 10.0,
            offset: const Offset(0.0, 0.75),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) => context.read<LandingCubit>().onBottomCLicked(index),
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
          elevation: 0,
          fixedColor: primaryColor,
          showUnselectedLabels: true,
          selectedLabelStyle: const TextStyle(
              color: primaryColor,
              fontSize: 10,
              height: 2.6,
              fontWeight: FontWeight.bold),
          unselectedItemColor: txtGrey,
          unselectedLabelStyle:
              const TextStyle(color: txtGrey, fontSize: 10, height: 2.6),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                color: txtGrey,
              ),
              activeIcon: Icon(
                Icons.home,
                color: primaryColor,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.history,
                  color: txtGrey,
                ),
                activeIcon: Icon(
                  Icons.history,
                  color: primaryColor,
                ),
                label: "History"),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.accessibility,
                color: txtGrey,
              ),
              activeIcon: Icon(
                Icons.accessibility,
                color: primaryColor,
              ),
              label: 'Accessibility',
            ),
          ],
        ),
      ),
    );
  }
}
