import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:accessibility_app/ui/components/bottom_bar_custom.dart';
import 'package:accessibility_app/ui/pages/accessibility/accessibility_page.dart';
import 'package:accessibility_app/ui/pages/history/history_page.dart';
import 'package:accessibility_app/ui/pages/home/home_page.dart';
import 'package:accessibility_app/ui/pages/landing/landing_cubit.dart';

class LandingPage extends StatelessWidget {
  LandingPage({Key? key, this.selectedIndex = 0}) : super(key: key);

  final int selectedIndex;
  final List pages = [
    const HomePage(),
    const HistoryPage(),
    const AccessibilityPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LandingCubit(selectedIndex),
      child: BlocBuilder<LandingCubit, LandingState>(
        builder: (context, state) {
          return Scaffold(
              body: SafeArea(child: pages[state.currentIndex]),
              bottomNavigationBar:
                  AppBottomNav(currentIndex: state.currentIndex));
        },
      ),
    );
  }
}
