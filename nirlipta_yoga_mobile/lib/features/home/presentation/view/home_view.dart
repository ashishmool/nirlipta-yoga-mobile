import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/app_bar/main_app_bar.dart';
import '../../../../core/theme/theme_cubit.dart';
import '../view_model/home_cubit.dart';
import '../view_model/home_state.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        context.watch<ThemeCubit>().state.isDarkMode; // Get theme mode

    return Scaffold(
      appBar: MainAppBar(),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return state.views.elementAt(state.selectedIndex);
        },
      ),
      bottomNavigationBar: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.book),
                label: 'My Fitness',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.cast_for_education),
                label: 'My Enrollments',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: 'My Profile',
              ),
            ],
            currentIndex: state.selectedIndex,
            selectedItemColor:
                isDarkMode ? Colors.white : const Color(0xFF9B6763),
            unselectedItemColor:
                isDarkMode ? Colors.grey[500] : const Color(0xFFB8978C),
            backgroundColor:
                isDarkMode ? const Color(0xFF121212) : Colors.white,
            // Dark theme background
            type: BottomNavigationBarType.fixed,
            // Ensures proper styling
            onTap: (index) {
              context.read<HomeCubit>().onTabTapped(index);
            },
          );
        },
      ),
    );
  }
}
