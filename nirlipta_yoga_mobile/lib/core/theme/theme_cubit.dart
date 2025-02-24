import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<bool> {
  ThemeCubit() : super(false); // Default: Light Theme (false)

  void toggleTheme() {
    emit(!state); // Toggle between light and dark mode
  }
}
