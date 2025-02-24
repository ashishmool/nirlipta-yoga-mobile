import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nirlipta_yoga_mobile/core/theme/app_theme.dart';

import '../../../features/home/presentation/view_model/home_cubit.dart';
import '../../theme/theme_cubit.dart';
import '../logo.dart';
import '../shake_detector/shake_detector.dart';
import '../snackbar/snackbar.dart';

class MainAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MainAppBar({super.key});

  @override
  _MainAppBarState createState() => _MainAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MainAppBarState extends State<MainAppBar> {
  late ShakeDetector _shakeDetector;

  @override
  void initState() {
    super.initState();

    _shakeDetector = ShakeDetector(
      onShake: () {
        showMySnackBar(
          context: context,
          message: 'Logging out...',
          color: Colors.black54,
        );
        context.read<HomeCubit>().logout(context);
      },
    );

    _shakeDetector.startListening();
  }

  @override
  void dispose() {
    _shakeDetector.stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<ThemeCubit>();
    final isDarkMode = themeCubit.state.isDarkMode;

    return AppBar(
      backgroundColor:
          themeCubit.state.isDarkMode ? Colors.black : Colors.white,
      title: Row(
        children: [
          SizedBox(
            height: 50,
            child: isDarkMode
                ? const Logo.white(height: 40.0) // White logo for dark mode
                : const Logo.colour(
                    height: 40.0), // Colored logo for light mode
          ),
        ],
      ),
      iconTheme: IconThemeData(
        color: themeCubit.state.isDarkMode ? Colors.white : Colors.black,
      ),
      actions: [
        Switch(
          value: themeCubit.state.isDarkMode,
          activeTrackColor: Colors.white,
          // Always red when ON
          inactiveTrackColor: Colors.white,
          // Always red when OFF
          activeColor: Colors.black,
          // Thumb color when ON
          inactiveThumbColor: primaryColor,
          // Thumb color when OFF
          onChanged: (value) {
            themeCubit.toggleTheme(); // Toggle theme on switch
          },
        ),
        IconButton(
          icon: Icon(
            Icons.logout,
            color: themeCubit.state.isDarkMode ? Colors.white : Colors.black,
          ),
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
}
