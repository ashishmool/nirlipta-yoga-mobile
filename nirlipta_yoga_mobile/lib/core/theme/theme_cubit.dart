import 'package:flutter_bloc/flutter_bloc.dart';

import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeInitial(false)); // Default: Light Theme

  void toggleTheme() {
    emit(ThemeUpdated(!state.isDarkMode));
  }
}
