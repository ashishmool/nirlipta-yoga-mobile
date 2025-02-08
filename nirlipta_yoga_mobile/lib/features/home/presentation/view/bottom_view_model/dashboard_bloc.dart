import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;

import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  List<Map<String, dynamic>> allWorkshops = []; // Store all workshops
  List<String> allCategories = []; // Store all categories

  DashboardBloc() : super(DashboardInitial()) {
    on<LoadDashboardData>(_onLoadDashboardData);
    on<FilterWorkshops>(_onFilterWorkshops);
  }

  void _onLoadDashboardData(
      LoadDashboardData event, Emitter<DashboardState> emit) async {
    emit(DashboardLoading());
    try {
      final response =
          await http.get(Uri.parse("http://10.0.2.2:5000/api/workshops/"));

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);

        // Debugging: Check raw response
        print("Response: $jsonData");

        allCategories = jsonData
            .map<String>((workshop) => workshop["category"]["name"].toString())
            .toSet()
            .toList();

        allWorkshops = jsonData.map((workshop) {
          return {
            "workshopId": workshop["_id"], // "workshopId" change
            "title": workshop["title"],
            "category": workshop["category"]["name"],
            "price": workshop["price"].toDouble(),
            "photo": "http://10.0.2.2:5000" + workshop["photo"],
            "description": workshop["description"] ?? null,
          };
        }).toList();

        print("Loaded Workshops: $allWorkshops"); // Debugging

        emit(DashboardLoaded(
            categories: allCategories, workshops: allWorkshops));
      } else {
        emit(DashboardError("Failed to load data"));
      }
    } catch (e) {
      emit(DashboardError("Error: ${e.toString()}"));
    }
  }

  void _onFilterWorkshops(FilterWorkshops event, Emitter<DashboardState> emit) {
    if (state is DashboardLoaded) {
      if (event.selectedCategories.isEmpty) {
        // If no filters are selected, reset to all workshops
        emit(DashboardLoaded(
            categories: allCategories, workshops: allWorkshops));
      } else {
        // Apply filtering
        List<Map<String, dynamic>> filteredWorkshops = allWorkshops
            .where((workshop) =>
                event.selectedCategories.contains(workshop["category"]))
            .toList();

        emit(DashboardLoaded(
            categories: allCategories, workshops: filteredWorkshops));
      }
    }
  }
}
