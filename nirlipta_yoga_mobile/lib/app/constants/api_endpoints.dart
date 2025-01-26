class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);

  // For Android Emulator
  static const String baseUrl = "http://10.0.2.2:5000/api/";

  // ============= Auth Routes =============
  static const String login = "auth/login";
  static const String register = "auth/register-mobile";
  static const String resetPasswordRequest = "auth/reset-password-request";
  static const String resetPassword = "auth/reset-password";
  static const String deleteUser = "auth/delete/";
  static const String getAllUsers = "auth/getAllUsers/";

  static const String imageUrl = "http://10.0.2.2:3000/uploads/";
  static const String uploadImage = "auth/uploadImage";

  // ============= Workshop Routes =============
  static const String createWorkshop = "workshops/save";
  static const String getAllWorkshops = "workshops/";
  static const String getWorkshopById = "workshops/:id";
  static const String updateWorkshop = "workshops/update/:id";
  static const String deleteWorkshop = "workshops/delete/:id";
}
