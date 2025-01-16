import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nirlipta_yoga_mobile/features/workshop/presentation/view/workshop_view.dart';
import 'package:nirlipta_yoga_mobile/features/workshop/presentation/view_model/workshop_bloc.dart';

import '../../../../app/di/di.dart';
import '../../../course/presentation/view/course_view.dart';
import '../../../course/presentation/view_model/course_bloc.dart';

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
        const Center(child: Text('Dashboard')),
        // Adding Course view with CourseBloc
        BlocProvider(
          create: (context) => getIt<CourseBloc>(),
          child: CourseView(),
        ),
        // Adding Batch view with BatchBloc
        BlocProvider(
          create: (context) => getIt<WorkshopBloc>(),
          child: WorkshopView(),
        ),
        const Center(child: Text('Account')),
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
