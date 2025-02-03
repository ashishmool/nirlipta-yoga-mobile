import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nirlipta_yoga_mobile/features/workshop_category/presentation/view/category_view.dart';

import '../../../../app/di/di.dart';
import '../../../workshop/presentation/view/workshop_view.dart';
import '../../../workshop/presentation/view_model/workshop_bloc.dart';
import '../../../workshop_category/presentation/view_model/category_bloc.dart';

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
        // Adding Category view with CategoryBloc
        BlocProvider(
          create: (context) => getIt<CategoryBloc>(),
          child: CategoryView(),
        ),
        // Adding Workshop view with WorkshopBloc
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
