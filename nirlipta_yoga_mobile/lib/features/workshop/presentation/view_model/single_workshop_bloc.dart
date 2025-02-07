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
        Map<String, dynamic> workshop = {
          "id": jsonData["_id"],
          "title": jsonData["title"],
          "description": jsonData["description"],
          "category": jsonData["category"]["name"],
          "price": jsonData["price"].toDouble(),
          "photo": "http://10.0.2.2:5000" + jsonData["photo"],
          "isPremium": jsonData["isPremium"] ?? false,
          "instructor": jsonData["instructor"]["name"],
          "duration": jsonData["duration"],
          "schedule": jsonData["schedule"],
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
