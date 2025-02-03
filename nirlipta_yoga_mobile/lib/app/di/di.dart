import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:nirlipta_yoga_mobile/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:nirlipta_yoga_mobile/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:nirlipta_yoga_mobile/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:nirlipta_yoga_mobile/features/workshop/data/data_source/local_datasource/workshop_local_data_source.dart';
import 'package:nirlipta_yoga_mobile/features/workshop/data/data_source/remote_datasource/workshop_remote_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/network/api_service.dart';
import '../../core/network/hive_service.dart';
import '../../features/auth/data/data_source/remote_datasource/user_remote_data_source.dart';
import '../../features/auth/data/repository/user_remote_repository.dart';
import '../../features/auth/domain/use_case/create_user_usecase.dart';
import '../../features/auth/domain/use_case/login_user_usecase.dart';
import '../../features/home/presentation/view_model/home_cubit.dart';
import '../../features/onboarding/presentation/view_model/onboarding_cubit.dart';
import '../../features/splash/presentation/view_model/splash_cubit.dart';
import '../../features/workshop/data/repository/workshop_local_repository.dart';
import '../../features/workshop/data/repository/workshop_remote_repository.dart';
import '../../features/workshop/domain/use_case/create_workshop_usecase.dart';
import '../../features/workshop/domain/use_case/delete_workshop_usecase.dart';
import '../../features/workshop/domain/use_case/get_all_workshops_usecase.dart';
import '../../features/workshop/domain/use_case/get_workshop_by_id_usecase.dart';
import '../../features/workshop/domain/use_case/update_workshop_usecase.dart';
import '../../features/workshop/presentation/view_model/workshop_bloc.dart';
import '../shared_prefs/token_shared_prefs.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // Sequence of Dependencies Matter!!

  await _initHiveService();
  await _initApiService();
  await _initSharedPreferences();

  await _initWorkshopDependencies();

  // Before Home and Register
  await _initLoginDependencies();

  // Initialize Home and Register dependencies before LoginBloc
  await _initHomeDependencies();
  await _initRegisterDependencies();

  // Initialize other dependencies
  await _initSplashScreenDependencies();
  await _initOnboardingScreenDependencies();
}

_initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

_initApiService() {
  // Remote Data Source
  getIt.registerLazySingleton<Dio>(
    () => ApiService(Dio()).dio,
  );
}

Future<void> _initSharedPreferences() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}

_initWorkshopDependencies() async {
  // Local Data Source
  getIt.registerFactory<WorkshopLocalDataSource>(
      () => WorkshopLocalDataSource(getIt<HiveService>()));

  // Remote Data Source
  getIt.registerFactory<WorkshopRemoteDataSource>(
      () => WorkshopRemoteDataSource(getIt<Dio>()));

  // Local Repository
  getIt.registerLazySingleton<WorkshopLocalRepository>(() =>
      WorkshopLocalRepository(
          workshopLocalDataSource: getIt<WorkshopLocalDataSource>()));

  // Remote Repository
  getIt.registerLazySingleton<WorkshopRemoteRepository>(() =>
      WorkshopRemoteRepository(
          workshopRemoteDataSource: getIt<WorkshopRemoteDataSource>()));

  // // Local Usecases
  // getIt.registerLazySingleton<CreateWorkshopUseCase>(() =>
  //     CreateWorkshopUseCase(
  //         workshopRepository: getIt<WorkshopLocalRepository>()));
  //
  // getIt.registerLazySingleton<GetAllWorkshopsUseCase>(() =>
  //     GetAllWorkshopsUseCase(
  //         workshopRepository: getIt<WorkshopLocalRepository>()));
  //
  // getIt.registerLazySingleton<DeleteWorkshopUseCase>(
  //   () => DeleteWorkshopUseCase(
  //       workshopRepository: getIt<WorkshopLocalRepository>(),
  //       tokenSharedPrefs: getIt<TokenSharedPrefs>()),
  // );
  //
  // getIt.registerLazySingleton<UpdateWorkshopUseCase>(
  //   () => UpdateWorkshopUseCase(
  //       workshopRepository: getIt<WorkshopLocalRepository>()),
  // );
  //
  // getIt.registerLazySingleton<GetWorkshopByIdUseCase>(
  //   () => GetWorkshopByIdUseCase(
  //       workshopRepository: getIt<WorkshopLocalRepository>()),
  // );

  // Remote Usecases
  getIt.registerLazySingleton<CreateWorkshopUseCase>(() =>
      CreateWorkshopUseCase(
          workshopRepository: getIt<WorkshopRemoteRepository>()));

  getIt.registerLazySingleton<GetAllWorkshopsUseCase>(() =>
      GetAllWorkshopsUseCase(
          workshopRepository: getIt<WorkshopRemoteRepository>()));

  getIt.registerLazySingleton<DeleteWorkshopUseCase>(
    () => DeleteWorkshopUseCase(
        workshopRepository: getIt<WorkshopRemoteRepository>(),
        tokenSharedPrefs: getIt<TokenSharedPrefs>()),
  );

  getIt.registerLazySingleton<UpdateWorkshopUseCase>(
    () => UpdateWorkshopUseCase(
        workshopRepository: getIt<WorkshopRemoteRepository>()),
  );

  getIt.registerLazySingleton<GetWorkshopByIdUseCase>(
    () => GetWorkshopByIdUseCase(
        workshopRepository: getIt<WorkshopRemoteRepository>()),
  );

  // Bloc
  getIt.registerFactory<WorkshopBloc>(
    () => WorkshopBloc(
      createWorkshopUseCase: getIt<CreateWorkshopUseCase>(),
      getAllWorkshopsUseCase: getIt<GetAllWorkshopsUseCase>(),
      deleteWorkshopUseCase: getIt<DeleteWorkshopUseCase>(),
      // updateWorkshopUseCase: getIt<UpdateWorkshopUseCase>(),
      // getWorkshopByIdUseCase: getIt<GetWorkshopByIdUseCase>(),
    ),
  );
}

_initHomeDependencies() async {
  // getIt.registerLazySingleton<TokenSharedPrefs>(
  //   () => TokenSharedPrefs(getIt<SharedPreferences>()),
  // );

  getIt.registerSingleton<HomeCubit>(
    HomeCubit(tokenSharedPrefs: getIt<TokenSharedPrefs>()),
  );
}

_initRegisterDependencies() async {
  if (!getIt.isRegistered<UserRemoteDataSource>()) {
    getIt.registerFactory<UserRemoteDataSource>(
      () => UserRemoteDataSource(getIt<Dio>()),
    );
  }

  if (!getIt.isRegistered<UserRemoteRepository>()) {
    getIt.registerLazySingleton<UserRemoteRepository>(
        () => UserRemoteRepository(getIt<UserRemoteDataSource>()));
  }

  // Register CreateStudentUsecase
  getIt.registerLazySingleton<CreateUserUsecase>(
      () => CreateUserUsecase(userRepository: getIt<UserRemoteRepository>()));

  // Register Upload Image Use Case
  getIt.registerLazySingleton<UploadImageUseCase>(
      () => UploadImageUseCase(getIt<UserRemoteRepository>()));

  // Register RegisterBloc
  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      // batchBloc: getIt<BatchBloc>(),
      // workshopBloc: getIt<WorkshopBloc>(),
      createUserUsecase: getIt<CreateUserUsecase>(),
      uploadImageUseCase: getIt<UploadImageUseCase>(),
    ),
  );
}

_initLoginDependencies() async {
  getIt.registerLazySingleton<TokenSharedPrefs>(
    () => TokenSharedPrefs(getIt<SharedPreferences>()),
  );

  // Use common StudentRemoteDataSource and StudentLocalRepository
  if (!getIt.isRegistered<LoginUserUsecase>()) {
    getIt.registerLazySingleton<LoginUserUsecase>(() => LoginUserUsecase(
        tokenSharedPrefs: getIt<TokenSharedPrefs>(),
        userRepository: getIt<UserRemoteRepository>()));
  }

  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      registerBloc: getIt<RegisterBloc>(),
      homeCubit: getIt<HomeCubit>(),
      // batchBloc: getIt<BatchBloc>(),
      // workshopBloc: getIt<WorkshopBloc>(),
      loginUserUsecase: getIt<LoginUserUsecase>(),
    ),
  );
}

_initSplashScreenDependencies() async {
  getIt.registerFactory<SplashCubit>(
    () => SplashCubit(),
  );
}

_initOnboardingScreenDependencies() async {
  getIt.registerFactory<OnboardingCubit>(
    () => OnboardingCubit(getIt<LoginBloc>()),
  );
}
