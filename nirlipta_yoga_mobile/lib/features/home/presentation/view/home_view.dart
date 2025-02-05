import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/logo.dart';
import '../../../../core/common/snackbar/snackbar.dart';
import '../view_model/home_cubit.dart';
import '../view_model/home_state.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  final bool _isDarkTheme = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(
              height: 50, // Increase the size of the logo as needed
              child: Logo.white(height: 40.0), // Larger logo
            ),
          ],
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        actions: [
          Switch(
            value: _isDarkTheme,
            onChanged: (value) {
              // Change theme logic
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              showMySnackBar(
                context: context,
                message: 'Logging out...',
                color: Colors.black54,
              );
              context.read<HomeCubit>().logout(context);
            },
          ),
        ],
      ),

      // body: _views.elementAt(_selectedIndex),
      body: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
        return state.views.elementAt(state.selectedIndex);
      }),
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
                label: 'Category',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.group),
                label: 'Workshop',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.cast_for_education),
                label: 'Enrollments',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: 'Account',
              ),
            ],
            currentIndex: state.selectedIndex,
            selectedItemColor: Color(0xFF9B6763),
            unselectedItemColor: Color(0xFFB8978C),
            backgroundColor: Colors.black,
            onTap: (index) {
              context.read<HomeCubit>().onTabTapped(index);
            },
          );
        },
      ),
    );
  }
}
