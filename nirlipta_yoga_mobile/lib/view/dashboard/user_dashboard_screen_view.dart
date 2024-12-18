import 'package:flutter/material.dart';
import 'package:nirlipta_yoga_mobile/view/dashboard/bottom_screen/about_screen_view.dart';
import 'package:nirlipta_yoga_mobile/view/dashboard/bottom_screen/enrollments_screen_view.dart';
import 'package:nirlipta_yoga_mobile/view/dashboard/bottom_screen/profile_screen_view.dart';

import '../../core/common/snackbar.dart';
import 'bottom_screen/home_screen_view.dart';

class StudentDashboardScreenView extends StatefulWidget {
  const StudentDashboardScreenView({super.key});

  @override
  State<StudentDashboardScreenView> createState() =>
      _StudentDashboardScreenViewState();
}

class _StudentDashboardScreenViewState
    extends State<StudentDashboardScreenView> {
  int _selectedIndex = 0;

  List<Widget> lstBottomScreen = [
    const HomeScreenView(),
    const EnrollmentScreenView(),
    const ProfileScreenView(),
    const AboutScreenView(),
  ];

  @override
  Widget build(BuildContext context) {
    final primaryColor = const Color(0xFF9B6763); // Primary color

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // title: const Text('Home'),
        actions: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/login');
              showMySnackbar(context, 'Logged Out Successfully');
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Icon(Icons.logout, color: Colors.white),
                  const SizedBox(width: 8),
                  Text(
                    'Logout',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Gilroy',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: lstBottomScreen[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.menu_book), label: "My Enrollment"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: "About"),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: primaryColor,
        // Set active item color
        unselectedItemColor: Colors.grey,
        // Optional: Set inactive item color
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
