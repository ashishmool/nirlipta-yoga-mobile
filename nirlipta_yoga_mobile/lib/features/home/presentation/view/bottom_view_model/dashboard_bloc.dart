// import 'package:bloc/bloc.dart';
//
// import 'dashboard_event.dart';
// import 'dashboard_state.dart';
//
// class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
//   DashboardBloc() : super(DashboardInitial()) {
//     on<LoadDashboardData>(_onLoadDashboardData);
//     on<FilterWorkshops>(_onFilterWorkshops);
//   }
//
//   // Simulated data fetching
//   void _onLoadDashboardData(
//       LoadDashboardData event, Emitter<DashboardState> emit) async {
//     emit(DashboardLoading());
//     try {
//       await Future.delayed(const Duration(seconds: 1)); // Simulate API call
//
//       List<String> categories = ["Yoga", "Asanas", "Meditation"];
//       List<Map<String, dynamic>> workshops = [
//         {
//           "title": "Yoga Basics",
//           "category": "Yoga",
//           "price": 20.00,
//           "photo":
//               "https://www.verywellfit.com/thmb/r2dVEzh8Du0JW0GxbVxj5Z7GS0g=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Verywell-01-3567198-WarriorOne-acb9d35e634e4f548c2d251e9c739c74.jpg"
//         },
//         {
//           "title": "Advanced Asanas",
//           "category": "Asanas",
//           "price": 30.50,
//           "photo":
//               "https://www.verywellfit.com/thmb/r2dVEzh8Du0JW0GxbVxj5Z7GS0g=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Verywell-01-3567198-WarriorOne-acb9d35e634e4f548c2d251e9c739c74.jpg"
//         },
//         {
//           "title": "Deep Meditation",
//           "category": "Meditation",
//           "price": 25.00,
//           "photo":
//               "https://www.verywellfit.com/thmb/r2dVEzh8Du0JW0GxbVxj5Z7GS0g=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Verywell-01-3567198-WarriorOne-acb9d35e634e4f548c2d251e9c739c74.jpg"
//         },
//       ];
//
//       emit(DashboardLoaded(categories: categories, workshops: workshops));
//     } catch (e) {
//       emit(DashboardError("Failed to load data"));
//     }
//   }
//
//   void _onFilterWorkshops(
//       FilterWorkshops event, Emitter<DashboardState> emit) async {
//     if (state is DashboardLoaded) {
//       var currentState = state as DashboardLoaded;
//
//       List<Map<String, dynamic>> filteredWorkshops = currentState.workshops
//           .where((workshop) => workshop["category"] == event.category)
//           .toList();
//
//       emit(DashboardLoaded(
//           categories: currentState.categories, workshops: filteredWorkshops));
//     }
//   }
// }

import 'package:bloc/bloc.dart';

import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<LoadDashboardData>(_onLoadDashboardData);
    on<FilterWorkshops>(_onFilterWorkshops);
  }

  // Simulated data fetching
  void _onLoadDashboardData(
      LoadDashboardData event, Emitter<DashboardState> emit) async {
    emit(DashboardLoading());
    try {
      await Future.delayed(const Duration(seconds: 1)); // Simulate API call

      List<String> categories = ["Yoga", "Asanas", "Meditation"];
      List<Map<String, dynamic>> workshops = [
        {
          "title": "Yoga Basics",
          "category": "Yoga",
          "price": 20.00,
          "photo":
              "https://www.verywellfit.com/thmb/r2dVEzh8Du0JW0GxbVxj5Z7GS0g=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Verywell-01-3567198-WarriorOne-acb9d35e634e4f548c2d251e9c739c74.jpg"
        },
        {
          "title": "Advanced Asanas",
          "category": "Asanas",
          "price": 30.50,
          "photo":
              "https://www.verywellfit.com/thmb/r2dVEzh8Du0JW0GxbVxj5Z7GS0g=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Verywell-01-3567198-WarriorOne-acb9d35e634e4f548c2d251e9c739c74.jpg"
        },
        {
          "title": "Deep Meditation",
          "category": "Meditation",
          "price": 25.00,
          "photo":
              "https://www.verywellfit.com/thmb/r2dVEzh8Du0JW0GxbVxj5Z7GS0g=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Verywell-01-3567198-WarriorOne-acb9d35e634e4f548c2d251e9c739c74.jpg"
        },
      ];

      emit(DashboardLoaded(categories: categories, workshops: workshops));
    } catch (e) {
      emit(DashboardError("Failed to load data"));
    }
  }

  void _onFilterWorkshops(
      FilterWorkshops event, Emitter<DashboardState> emit) async {
    if (state is DashboardLoaded) {
      var currentState = state as DashboardLoaded;

      List<Map<String, dynamic>> filteredWorkshops = currentState.workshops
          .where((workshop) =>
              event.selectedCategories.contains(workshop["category"]))
          .toList();

      emit(DashboardLoaded(
          categories: currentState.categories, workshops: filteredWorkshops));
    }
  }
}
