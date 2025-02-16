import 'package:connectivity_plus/connectivity_plus.dart';

class InternetChecker {
  final Connectivity _connectivity = Connectivity();

  // Check the current connectivity status
  Future<List<ConnectivityResult>> checkConnectivity() async {
    try {
      return await _connectivity.checkConnectivity();
    } catch (e) {
      // Handle errors (e.g., platform exceptions)
      throw Exception('Failed to check connectivity: $e');
    }
  }

  // Stream to listen for connectivity changes
  Stream<List<ConnectivityResult>> get onConnectivityChanged {
    return _connectivity.onConnectivityChanged;
  }

  // Check if there is an active internet connection
  Future<bool> hasInternetConnection() async {
    final connectivityResult = await checkConnectivity();
    return connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi);
  }
}