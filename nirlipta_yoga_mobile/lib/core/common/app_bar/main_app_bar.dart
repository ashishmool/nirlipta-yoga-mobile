import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/home/presentation/view_model/home_cubit.dart';
import '../logo.dart';
import '../snackbar/snackbar.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isDarkTheme;

  const MainAppBar({super.key, required this.isDarkTheme});

  @override
  Widget build(BuildContext context) {
    // Determine icon color based on the theme
    final bool isLightTheme = Theme.of(context).brightness == Brightness.light;
    final Color logoutIconColor = isLightTheme ? Colors.black : Colors.white;

    return AppBar(
      backgroundColor: Colors.white, // White background
      title: Row(
        children: [
          SizedBox(
            height: 50, // Adjust logo size
            child: Logo.colour(height: 40.0), // Logo
          ),
        ],
      ),
      iconTheme: const IconThemeData(
        color: Colors.black, // Black icons for contrast
      ),
      actions: [
        Switch(
          value: isDarkTheme,
          onChanged: (value) {
            // Handle theme change logic
          },
        ),
        IconButton(
          icon: Icon(Icons.logout, color: logoutIconColor),
          // Dynamic logout icon color
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
