import 'package:get_it/get_it.dart';
import 'package:nirlipta_yoga_mobile/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:nirlipta_yoga_mobile/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:nirlipta_yoga_mobile/features/workshop/data/data_source/local_datasource/workshop_local_data_source.dart';

import '../../core/network/hive_service.dart';
import '../../features/auth/data/data_source/local_datasource/student_local_datasource.dart';
import '../../features/auth/data/repository/student_local_repository.dart';
import '../../features/auth/domain/use_case/create_student_usecase.dart';
import '../../features/auth/domain/use_case/login_student_usecase.dart';
import '../../features/batch/data/data_source/local_datasource/batch_local_data_source.dart';
import '../../features/batch/data/repository/batch_local_repository.dart';
import '../../features/batch/domain/use_case/create_batch_usecase.dart';
import '../../features/batch/domain/use_case/delete_batch_usecase.dart';
import '../../features/batch/domain/use_case/get_all_batch_usecase.dart';
import '../../features/batch/presentation/view_model/batch_bloc.dart';
import '../../features/course/data/data_source/local_datasource/course_local_data_source.dart';
import '../../features/course/data/repository/course_local_repository.dart';
import '../../features/course/domain/use_case/create_course_usecase.dart';
import '../../features/course/domain/use_case/delete_course_usecase.dart';
import '../../features/course/domain/use_case/get_all_course_usecase.dart';
import '../../features/course/presentation/view_model/course_bloc.dart';
import '../../features/home/presentation/view_model/home_cubit.dart';
import '../../features/onboarding/presentation/view_model/onboarding_cubit.dart';
import '../../features/splash/presentation/view_model/splash_cubit.dart';
import '../../features/workshop/data/repository/workshop_local_repository.dart';
import '../../features/workshop/domain/use_case/create_workshop_usecase.dart';
import '../../features/workshop/domain/use_case/delete_workshop_usecase.dart';
import '../../features/workshop/domain/use_case/get_all_workshops_usecase.dart';
import '../../features/workshop/domain/use_case/get_workshop_by_id_usecase.dart';
import '../../features/workshop/domain/use_case/update_workshop_usecase.dart';
import '../../features/workshop/presentation/view_model/workshop_bloc.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // Sequence of Dependencies Matter!!

  await _initHiveService();
  await _initCommonDependencies();

  await _initBatchDependencies();
  await _initWorkshopDependencies();
  await _initCourseDependencies();

  // Initialize Home and Register dependencies before LoginBloc
  await _initHomeDependencies();
  await _initRegisterDependencies();
  await _initLoginDependencies();

  // Initialize other dependencies
  await _initSplashScreenDependencies();
  await _initOnboardingScreenDependencies();
}

_initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

_initBatchDependencies() async {
  //Data Source
  getIt.registerFactory<BatchLocalDataSource>(
      () => BatchLocalDataSource(getIt<HiveService>()));

  //Repository
  getIt.registerLazySingleton<BatchLocalRepository>(() => BatchLocalRepository(
      batchLocalDataSource: getIt<BatchLocalDataSource>()));
  //Usecases
  getIt.registerLazySingleton<CreateBatchUseCase>(
      () => CreateBatchUseCase(batchRepository: getIt<BatchLocalRepository>()));

  getIt.registerLazySingleton<GetAllBatchUseCase>(
      () => GetAllBatchUseCase(batchRepository: getIt<BatchLocalRepository>()));

  getIt.registerLazySingleton<DeleteBatchUseCase>(
    () => DeleteBatchUseCase(batchRepository: getIt<BatchLocalRepository>()),
  );

  // Bloc
  getIt.registerFactory<BatchBloc>(
    () => BatchBloc(
      createBatchUseCase: getIt<CreateBatchUseCase>(),
      getAllBatchUseCase: getIt<GetAllBatchUseCase>(),
      deleteBatchUseCase: getIt<DeleteBatchUseCase>(),
    ),
  );
}

_initWorkshopDependencies() async {
  //Data Source
  getIt.registerFactory<WorkshopLocalDataSource>(
      () => WorkshopLocalDataSource(getIt<HiveService>()));

  //Repository
  getIt.registerLazySingleton<WorkshopLocalRepository>(() =>
      WorkshopLocalRepository(
          workshopLocalDataSource: getIt<WorkshopLocalDataSource>()));
  //Usecases
  // Usecases
  getIt.registerLazySingleton<CreateWorkshopUseCase>(() =>
      CreateWorkshopUseCase(
          workshopRepository: getIt<WorkshopLocalRepository>()));

  getIt.registerLazySingleton<GetAllWorkshopsUseCase>(() =>
      GetAllWorkshopsUseCase(
          workshopRepository: getIt<WorkshopLocalRepository>()));

  getIt.registerLazySingleton<DeleteWorkshopUseCase>(
    () => DeleteWorkshopUseCase(
        workshopRepository: getIt<WorkshopLocalRepository>()),
  );

  getIt.registerLazySingleton<UpdateWorkshopUseCase>(
    () => UpdateWorkshopUseCase(
        workshopRepository: getIt<WorkshopLocalRepository>()),
  );

  getIt.registerLazySingleton<GetWorkshopByIdUseCase>(
    () => GetWorkshopByIdUseCase(
        workshopRepository: getIt<WorkshopLocalRepository>()),
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

_initCourseDependencies() async {
  //Data Source
  getIt.registerFactory<CourseLocalDataSource>(
      () => CourseLocalDataSource(getIt<HiveService>()));

  //Repository
  getIt.registerLazySingleton<CourseLocalRepository>(() =>
      CourseLocalRepository(
          courseLocalDataSource: getIt<CourseLocalDataSource>()));
  //Usecases
  getIt.registerLazySingleton<CreateCourseUseCase>(() =>
      CreateCourseUseCase(courseRepository: getIt<CourseLocalRepository>()));

  getIt.registerLazySingleton<GetAllCourseUseCase>(() =>
      GetAllCourseUseCase(courseRepository: getIt<CourseLocalRepository>()));

  getIt.registerLazySingleton<DeleteCourseUseCase>(
    () => DeleteCourseUseCase(courseRepository: getIt<CourseLocalRepository>()),
  );

  // Bloc
  getIt.registerFactory<CourseBloc>(
    () => CourseBloc(
      createCourseUseCase: getIt<CreateCourseUseCase>(),
      getAllCourseUseCase: getIt<GetAllCourseUseCase>(),
      deleteCourseUseCase: getIt<DeleteCourseUseCase>(),
    ),
  );
}

_initHomeDependencies() async {
  getIt.registerSingleton<HomeCubit>(
    HomeCubit(),
  );
}

_initCommonDependencies() {
  // Register common dependencies used across multiple features
  if (!getIt.isRegistered<StudentLocalDatasource>()) {
    getIt.registerFactory<StudentLocalDatasource>(
      () => StudentLocalDatasource(getIt<HiveService>()),
    );
  }

  if (!getIt.isRegistered<StudentLocalRepository>()) {
    getIt.registerLazySingleton<StudentLocalRepository>(() =>
        StudentLocalRepository(
            studentLocalDataSource: getIt<StudentLocalDatasource>()));
  }
}

_initRegisterDependencies() async {
  // Use common StudentLocalDatasource and StudentLocalRepository
  getIt.registerLazySingleton<CreateStudentUsecase>(() =>
      CreateStudentUsecase(studentRepository: getIt<StudentLocalRepository>()));
  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      batchBloc: getIt<BatchBloc>(),
      workshopBloc: getIt<WorkshopBloc>(),
      createStudentUsecase: getIt<CreateStudentUsecase>(),
    ),
  );
}

_initLoginDependencies() async {
  // Use common StudentLocalDatasource and StudentLocalRepository
  getIt.registerLazySingleton<LoginStudentUsecase>(() =>
      LoginStudentUsecase(studentRepository: getIt<StudentLocalRepository>()));
  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      registerBloc: getIt<RegisterBloc>(),
      homeCubit: getIt<HomeCubit>(),
      batchBloc: getIt<BatchBloc>(),
      workshopBloc: getIt<WorkshopBloc>(),
      loginStudentUsecase: getIt<LoginStudentUsecase>(),
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
