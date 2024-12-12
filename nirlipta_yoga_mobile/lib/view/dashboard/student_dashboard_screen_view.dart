import 'package:flutter/material.dart';
import '../../common/snackbar.dart';

class StudentDashboardScreenView extends StatelessWidget {
  const StudentDashboardScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = const Color(0xFF9B6763); // Primary color
    final secondaryColor = const Color(0xFFB8978C); // Secondary color

    final dashboardItems = [
      {
        'title': 'My Profile',
        'icon': Icons.person,
        'route': '/my_profile'
      },
      {
        'title': 'My Enrollments',
        'icon': Icons.list_alt,
        'route': '/my_enrollments'
      },
      {
        'title': 'My Retreats',
        'icon': Icons.beach_access,
        'route': '/my_retreats'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Dashboard'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black54,
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
                  Icon(Icons.logout, color: primaryColor),
                  const SizedBox(width: 8),
                  Text(
                    'Logout',
                    style: TextStyle(
                      color: primaryColor,
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


      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                // Welcome Text
                Center(
                  child: Text(
                    'Welcome {user}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: secondaryColor,
                      fontFamily: 'Gilroy',
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // Dashboard Grid
                Expanded(
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemCount: dashboardItems.length,
                    itemBuilder: (context, index) {
                      final item = dashboardItems[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, item['route'] as String);
                        },
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                item['icon'] as IconData,
                                size: 48,
                                color: primaryColor,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                item['title'] as String,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
