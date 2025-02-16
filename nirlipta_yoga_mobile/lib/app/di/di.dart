import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:nirlipta_yoga_mobile/app/shared_prefs/user_shared_prefs.dart';
import 'package:nirlipta_yoga_mobile/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:nirlipta_yoga_mobile/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:nirlipta_yoga_mobile/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:nirlipta_yoga_mobile/features/enrollment/domain/use_case/get_enrollment_by_user_usecase.dart';
import 'package:nirlipta_yoga_mobile/features/workshop/data/data_source/local_datasource/workshop_local_data_source.dart';
import 'package:nirlipta_yoga_mobile/features/workshop/data/data_source/remote_datasource/workshop_remote_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/network/api_service.dart';
import '../../core/network/hive_service.dart';
import '../../features/auth/data/data_source/remote_datasource/user_remote_data_source.dart';
import '../../features/auth/data/repository/user_remote_repository.dart';
import '../../features/auth/domain/use_case/create_user_usecase.dart';
import '../../features/auth/domain/use_case/login_user_usecase.dart';
import '../../features/enrollment/data/data_source/remote_datasource/enrollment_remote_data_source.dart';
import '../../features/enrollment/data/repository/enrollment_remote_repository.dart';
import '../../features/enrollment/domain/use_case/create_enrollment_usecase.dart';
import '../../features/enrollment/domain/use_case/delete_enrollment_usecase.dart';
import '../../features/enrollment/domain/use_case/get_all_enrollments_usecase.dart';
import '../../features/enrollment/domain/use_case/get_enrollment_by_id_usecase.dart';
import '../../features/enrollment/domain/use_case/update_enrollment_usecase.dart';
import '../../features/enrollment/presentation/view_model/enrollment_bloc.dart';
import '../../features/home/presentation/view/bottom_view_model/dashboard_bloc.dart';
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
import '../../features/workshop_category/data/data_source/local_datasource/category_local_data_source.dart';
import '../../features/workshop_category/data/data_source/remote_datasource/category_remote_data_source.dart';
import '../../features/workshop_category/data/repository/category_local_repository.dart';
import '../../features/workshop_category/data/repository/category_remote_repository.dart';
import '../../features/workshop_category/domain/use_case/create_category_usecase.dart';
import '../../features/workshop_category/domain/use_case/delete_category_usecase.dart';
import '../../features/workshop_category/domain/use_case/get_all_categories_usecase.dart';
import '../../features/workshop_category/domain/use_case/get_category_by_id_usecase.dart';
import '../../features/workshop_category/domain/use_case/update_category_usecase.dart';
import '../../features/workshop_category/presentation/view_model/category_bloc.dart';
import '../shared_prefs/token_shared_prefs.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // Sequence of Dependencies Matter!!

  await _initHiveService();
  await _initApiService();
  await _initSharedPreferences();

  // Start with Splash
  await _initSplashScreenDependencies();

  // Onboarding
  await _initOnboardingScreenDependencies();

  // Initialize Authentication Dependencies
  await _initLoginDependencies();
  await _initRegisterDependencies();

  // Initialize Home
  await _initHomeDependencies();

  // Initialize Dashboard and Others
  await _initDashboardDependencies();

  await _initWorkshopDependencies();
  await _initCategoryDependencies();
  await _initEnrollmentDependencies();
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
        workshopRepository: getIt<WorkshopRemoteRepository>(),
        tokenSharedPrefs: getIt<TokenSharedPrefs>()),
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
    ),
  );
}

_initCategoryDependencies() async {
  // Local Data Source
  getIt.registerFactory<CategoryLocalDataSource>(
      () => CategoryLocalDataSource(getIt<HiveService>()));

  // Remote Data Source
  getIt.registerFactory<CategoryRemoteDataSource>(
      () => CategoryRemoteDataSource(getIt<Dio>()));

  // Local Repository
  getIt.registerLazySingleton<CategoryLocalRepository>(() =>
      CategoryLocalRepository(
          categoryLocalDataSource: getIt<CategoryLocalDataSource>()));

  // Remote Repository
  getIt.registerLazySingleton<CategoryRemoteRepository>(() =>
      CategoryRemoteRepository(
          categoryRemoteDataSource: getIt<CategoryRemoteDataSource>()));

  // Remote Usecases
  getIt.registerLazySingleton<CreateCategoryUseCase>(() =>
      CreateCategoryUseCase(
          categoryRepository: getIt<CategoryRemoteRepository>()));

  getIt.registerLazySingleton<GetAllCategoriesUseCase>(() =>
      GetAllCategoriesUseCase(
          categoryRepository: getIt<CategoryRemoteRepository>()));

  getIt.registerLazySingleton<DeleteCategoryUseCase>(
    () => DeleteCategoryUseCase(
        categoryRepository: getIt<CategoryRemoteRepository>(),
        tokenSharedPrefs: getIt<TokenSharedPrefs>()),
  );

  getIt.registerLazySingleton<UpdateCategoryUseCase>(
    () => UpdateCategoryUseCase(
        categoryRepository: getIt<CategoryRemoteRepository>(),
        tokenSharedPrefs: getIt<TokenSharedPrefs>()),
  );

  getIt.registerLazySingleton<GetCategoryByIdUseCase>(
    () => GetCategoryByIdUseCase(
        categoryRepository: getIt<CategoryRemoteRepository>()),
  );

  // Bloc
  getIt.registerFactory<CategoryBloc>(
    () => CategoryBloc(
      createCategoryUseCase: getIt<CreateCategoryUseCase>(),
      getAllCategoriesUseCase: getIt<GetAllCategoriesUseCase>(),
      deleteCategoryUseCase: getIt<DeleteCategoryUseCase>(),
      updateCategoryUseCase: getIt<UpdateCategoryUseCase>(),
      // getCategoryByIdUseCase: getIt<GetCategoryByIdUseCase>(),
    ),
  );
}

_initHomeDependencies() async {
  // getIt.registerLazySingleton<TokenSharedPrefs>(
  //   () => TokenSharedPrefs(getIt<SharedPreferences>()),
  // );

  getIt.registerSingleton<HomeCubit>(
    HomeCubit(
        tokenSharedPrefs: getIt<TokenSharedPrefs>(),
        userSharedPrefs: getIt<UserSharedPrefs>()),
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

  // Register CreateUserUsecase
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

  getIt.registerLazySingleton<UserSharedPrefs>(
    () => UserSharedPrefs(),
  );

  if (!getIt.isRegistered<LoginUserUsecase>()) {
    getIt.registerLazySingleton<LoginUserUsecase>(() => LoginUserUsecase(
          tokenSharedPrefs: getIt<TokenSharedPrefs>(),
          userRepository: getIt<UserRemoteRepository>(),
          userSharedPrefs: getIt<UserSharedPrefs>(),
        ));
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

_initDashboardDependencies() {
  getIt.registerFactory<DashboardBloc>(() => DashboardBloc());
}

_initEnrollmentDependencies() async {
  // Remote Data Source
  getIt.registerFactory<EnrollmentRemoteDataSource>(
      () => EnrollmentRemoteDataSource(getIt<Dio>()));

  // Repository
  getIt.registerLazySingleton<EnrollmentRemoteRepository>(
      () => EnrollmentRemoteRepository(getIt<EnrollmentRemoteDataSource>()));

  // Use Cases
  getIt.registerLazySingleton<CreateEnrollmentUseCase>(() =>
      CreateEnrollmentUseCase(
          enrollmentRepository: getIt<EnrollmentRemoteRepository>()));

  getIt.registerLazySingleton<GetAllEnrollmentsUseCase>(() =>
      GetAllEnrollmentsUseCase(
          enrollmentRepository: getIt<EnrollmentRemoteRepository>()));

  getIt.registerLazySingleton<GetEnrollmentByUserUseCase>(() =>
      GetEnrollmentByUserUseCase(
          enrollmentRepository: getIt<EnrollmentRemoteRepository>()));

  getIt.registerLazySingleton<DeleteEnrollmentUseCase>(
    () => DeleteEnrollmentUseCase(
        enrollmentRepository: getIt<EnrollmentRemoteRepository>(),
        tokenSharedPrefs: getIt<TokenSharedPrefs>()),
  );

  getIt.registerLazySingleton<UpdateEnrollmentUseCase>(
    () => UpdateEnrollmentUseCase(
        enrollmentRepository: getIt<EnrollmentRemoteRepository>(),
        tokenSharedPrefs: getIt<TokenSharedPrefs>()),
  );

  getIt.registerLazySingleton<GetEnrollmentByIdUseCase>(
    () => GetEnrollmentByIdUseCase(
        enrollmentRepository: getIt<EnrollmentRemoteRepository>()),
  );

  // Bloc
  getIt.registerFactory<EnrollmentBloc>(
    () => EnrollmentBloc(
      createEnrollmentUseCase: getIt<CreateEnrollmentUseCase>(),
      deleteEnrollmentUseCase: getIt<DeleteEnrollmentUseCase>(),
      getEnrollmentByUserUseCase: getIt<GetEnrollmentByUserUseCase>(),
      userSharedPrefs: getIt<UserSharedPrefs>(),
    ),
  );
}
