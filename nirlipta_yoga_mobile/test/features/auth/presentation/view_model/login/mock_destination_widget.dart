import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';

class MockDestinationWidget extends Fake implements Widget {
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MockDestinationWidget';
  }
}
