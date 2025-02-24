import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/home/presentation/view_model/home_cubit.dart';
import '../logo.dart';
import '../shake_detector/shake_detector.dart';
import '../snackbar/snackbar.dart';

class MainAppBar extends StatefulWidget implements PreferredSizeWidget {
  final bool isDarkTheme;

  const MainAppBar({super.key, required this.isDarkTheme});

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
    final bool isLightTheme = Theme.of(context).brightness == Brightness.light;
    final Color logoutIconColor = isLightTheme ? Colors.black : Colors.white;

    return AppBar(
      backgroundColor: Colors.white,
      title: Row(
        children: [
          SizedBox(
            height: 50,
            child: Logo.colour(height: 40.0),
          ),
        ],
      ),
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      actions: [
        Switch(
          value: widget.isDarkTheme,
          onChanged: (value) {
            // Handle theme change logic
          },
        ),
        IconButton(
          icon: Icon(Icons.logout, color: logoutIconColor),
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
