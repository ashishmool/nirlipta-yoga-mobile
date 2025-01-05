import 'package:get_it/get_it.dart';
import 'package:nirlipta_yoga_mobile/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:nirlipta_yoga_mobile/features/auth/presentation/view_model/signup/register_bloc.dart';

import '../../features/batch/presentation/view_model/batch_bloc.dart';
import '../../features/home/presentation/view_model/home_cubit.dart';
import '../../features/onboarding/presentation/view_model/onboarding_cubit.dart';
import '../../features/splash/presentation/view_model/splash_cubit.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // Sequence of Dependencies Matter!!
  await _initBatchDependencies();

  // Initialize Home and Register dependencies before LoginBloc
  await _initHomeDependencies();
  await _initRegisterDependencies();

  // Initialize LoginBloc after HomeCubit and RegisterBloc
  await _initLoginDependencies();

  // Initialize other dependencies
  await _initOnboardingDependencies();
  await _initSplashScreenDependencies();
}

_initBatchDependencies() async {
  getIt.registerFactory<BatchBloc>(
    () => BatchBloc(),
  );
}

_initHomeDependencies() async {
  getIt.registerSingleton<HomeCubit>(
    HomeCubit(),
  );
}

_initRegisterDependencies() async {
  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(),
  );
}

_initLoginDependencies() async {
  assert(getIt.isRegistered<RegisterBloc>(), "RegisterBloc not registered");
  assert(getIt.isRegistered<HomeCubit>(), "HomeCubit not registered");

  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      registerBloc: getIt<RegisterBloc>(),
      homeCubit: getIt<HomeCubit>(),
    ),
  );
}

_initSplashScreenDependencies() async {
  getIt.registerFactory<SplashCubit>(
    () => SplashCubit(),
  );
}

_initOnboardingDependencies() async {
  assert(getIt.isRegistered<LoginBloc>(), "LoginBloc not registered");

  getIt.registerFactory<OnboardingCubit>(
    () => OnboardingCubit(loginBloc: getIt<LoginBloc>()),
  );
}
