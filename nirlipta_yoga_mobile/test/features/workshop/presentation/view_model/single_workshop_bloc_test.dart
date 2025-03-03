import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nirlipta_yoga_mobile/features/workshop/presentation/view_model/single_workshop_bloc.dart';
import 'package:nirlipta_yoga_mobile/features/workshop/presentation/view_model/single_workshop_state.dart';

class MockSingleWorkshopBloc extends Mock implements SingleWorkshopBloc {}

void main() {
  late SingleWorkshopBloc singleWorkshopBloc;

  setUp(() {
    singleWorkshopBloc = SingleWorkshopBloc();
  });

  tearDown(() {
    singleWorkshopBloc.close();
  });

  final mockWorkshop = {
    "id": "1",
    "title": "Yoga Basics",
    "description": "Introduction to yoga",
    "address": "Main Hall",
    "classroom_info": "Room A",
    "map_location": "Lat: 27.7, Long: 85.3",
    "difficulty_level": "Beginner",
    "category": "Health & Wellness",
    "price": 20.0,
    "discount_price": 15.0,
    "photo": "https://example.com/image.jpg",
    "duration": "2 hours",
    "schedule": [],
    "modules": []
  };

  group('SingleWorkshopBloc Tests', () {
    test('Initial state is SingleWorkshopInitial', () {
      expect(singleWorkshopBloc.state, isA<SingleWorkshopInitial>());
    });
  });
}
