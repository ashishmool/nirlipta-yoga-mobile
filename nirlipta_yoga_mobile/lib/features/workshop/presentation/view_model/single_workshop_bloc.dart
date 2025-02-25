import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;

import '../../../../app/shared_prefs/user_shared_prefs.dart';
import 'single_workshop_event.dart';
import 'single_workshop_state.dart';

class SingleWorkshopBloc
    extends Bloc<SingleWorkshopEvent, SingleWorkshopState> {
  SingleWorkshopBloc() : super(SingleWorkshopInitial()) {
    on<LoadSingleWorkshop>(_onLoadSingleWorkshop);
    on<EnrollInWorkshop>(_onEnrollInWorkshop);
  }

  void _onLoadSingleWorkshop(
      LoadSingleWorkshop event, Emitter<SingleWorkshopState> emit) async {
    emit(SingleWorkshopLoading());
    try {
      final response = await http.get(
        Uri.parse("http://192.168.1.19:5000/api/workshops/${event.workshopId}"),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);

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
              ? "http://192.168.1.19:5000${jsonData["photo"]}"
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

        // Get user ID
        final userData = await UserSharedPrefs().getUserData();
        final userId = userData.fold((failure) => null, (data) => data[2]);

        bool isEnrolled = false;

        if (userId != null) {
          // Check if user is already enrolled
          final enrollResponse = await http.get(
            Uri.parse(
                "http://192.168.1.19:5000/api/enrollments/check/$userId/${event.workshopId}"),
          );

          if (enrollResponse.statusCode == 200) {
            final enrollData = jsonDecode(enrollResponse.body);
            isEnrolled = enrollData["enrolled"] ?? false;
          }
        }

        emit(SingleWorkshopLoaded(workshop: workshop, isEnrolled: isEnrolled));
      } else {
        emit(SingleWorkshopError("Failed to load workshop details"));
      }
    } catch (e) {
      emit(SingleWorkshopError("Error: ${e.toString()}"));
    }
  }

  void _onEnrollInWorkshop(
      EnrollInWorkshop event, Emitter<SingleWorkshopState> emit) async {
    emit(EnrollmentLoading());
    try {
      final response = await http.post(
        Uri.parse("http://192.168.1.19:5000/api/enrollments/save"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
            {"user_id": event.userId, "workshop_id": event.workshopId}),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 201) {
        emit(EnrollmentSuccess(
            message: responseData["message"] ?? "Enrollment successful!"));
      } else {
        emit(EnrollmentError(
            responseData["message"] ?? "Failed to enroll in workshop"));
      }
    } catch (e) {
      emit(EnrollmentError("Error: ${e.toString()}"));
    }
  }
}
