import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;

import 'single_workshop_event.dart';
import 'single_workshop_state.dart';

class SingleWorkshopBloc
    extends Bloc<SingleWorkshopEvent, SingleWorkshopState> {
  SingleWorkshopBloc() : super(SingleWorkshopInitial()) {
    on<LoadSingleWorkshop>(_onLoadSingleWorkshop);
  }

  void _onLoadSingleWorkshop(
      LoadSingleWorkshop event, Emitter<SingleWorkshopState> emit) async {
    emit(SingleWorkshopLoading());
    try {
      final response = await http.get(
          Uri.parse("http://10.0.2.2:5000/api/workshops/${event.workshopId}"));

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);

        // Ensure every key exists before using it
        Map<String, dynamic> workshop = {
          "id": jsonData["_id"] ?? "",
          "title": jsonData["title"] ?? "No Title",
          "description": jsonData["description"] ?? "No Description",
          "address": jsonData["address"] ?? "No Address",
          "classroom_info": jsonData["classroom_info"] ?? "No Classroom Info",
          "map_location": jsonData["map_location"] ?? "No Location",
          "difficulty_level": jsonData["difficulty_level"] ?? "Unknown Level",
          "category": jsonData["category"]?["name"] ?? "No Category",
          "price":
              jsonData["price"] != null ? jsonData["price"].toDouble() : 0.0,
          "discount_price": jsonData["discount_price"]?.toDouble(),
          "photo": jsonData["photo"] != null
              ? "http://10.0.2.2:5000${jsonData["photo"]}"
              : null,
          "duration": jsonData["duration"] ?? "No Duration",
          "schedule": jsonData["schedule"] ?? [],
          "modules": jsonData["modules"] != null
              ? List<Map<String, dynamic>>.from(
                  jsonData["modules"].map((module) => {
                        "id": module["_id"] ?? "",
                        "name": module["name"] ?? "No Name",
                        "duration": module["duration"] ?? "No Duration",
                      }),
                )
              : [],
        };

        emit(SingleWorkshopLoaded(workshop: workshop));
      } else {
        emit(SingleWorkshopError("Failed to load workshop details"));
      }
    } catch (e) {
      emit(SingleWorkshopError("Error: ${e.toString()}"));
    }
  }
}
