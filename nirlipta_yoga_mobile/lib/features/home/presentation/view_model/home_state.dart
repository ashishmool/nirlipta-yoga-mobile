import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nirlipta_yoga_mobile/features/home/presentation/view/bottom_view/account_view.dart';
import 'package:nirlipta_yoga_mobile/features/home/presentation/view/bottom_view/dashboard_view.dart';

import '../../../../app/di/di.dart';
import '../../../enrollment/presentation/view/enrollment_view.dart';
import '../../../enrollment/presentation/view_model/enrollment_bloc.dart';
import '../../../workshop_category/presentation/view_model/category_bloc.dart';
import '../view/bottom_view/fitness_view.dart';
import '../view/bottom_view_model/dashboard_bloc.dart';

class HomeState extends Equatable {
  final int selectedIndex;
  final List<Widget> views;

  const HomeState({
    required this.selectedIndex,
    required this.views,
  });

  // Initial state
  static HomeState initial() {
    return HomeState(
      selectedIndex: 0,
      views: [
        // const Center(child: Text('Dashboard')),
        BlocProvider(
          create: (context) => getIt<DashboardBloc>(),
          child: DashboardView(),
        ),
        // Adding Category view with CategoryBloc
        BlocProvider(
          create: (context) => getIt<CategoryBloc>(),
          child: FitnessView(),
        ),
        // Adding Workshop view with WorkshopBloc
        BlocProvider(
          create: (context) => getIt<EnrollmentBloc>(),
          child: EnrollmentView(),
        ),
        // const Text ('My Enrollments'),
        BlocProvider(
          create: (context) => getIt<DashboardBloc>(),
          child: AccountView(),
        ),
      ],
    );
  }

  HomeState copyWith({
    int? selectedIndex,
    List<Widget>? views,
  }) {
    return HomeState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      views: views ?? this.views,
    );
  }

  @override
  List<Object?> get props => [selectedIndex, views];
}
