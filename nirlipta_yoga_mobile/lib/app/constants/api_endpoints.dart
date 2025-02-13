class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);

  // For Android Emulator
  static const String baseUrl = "http://10.0.2.2:5000/api/";

  // // For iPhone
  // static const String baseUrl = "http://localhost:5000/api/";

  // ============= Auth Routes =============
  static const String login = "auth/login";
  static const String register = "auth/register-mobile";
  static const String resetPasswordRequest = "auth/reset-password-request";
  static const String resetPassword = "auth/reset-password";
  static const String deleteUser = "auth/delete/";
  static const String getAllUsers = "auth/getAllUsers/";

  static const String imageUrl = "http://10.0.2.2:5000/uploads/";
  static const String uploadImage = "auth/uploadImage";

  // ============= Workshop Routes =============
  static const String createWorkshop = "workshops/save";
  static const String getAllWorkshops = "workshops/";
  static const String getWorkshopById = "workshops/";
  static const String updateWorkshop = "workshops/update/";
  static const String deleteWorkshop = "workshops/delete/";

  // ============= Category Routes =============
  static const String createCategory = "workshop-categories/save";
  static const String getAllCategories = "workshop-categories/";
  static const String getCategoryById = "workshop-categories/";
  static const String updateCategory = "workshop-categories/update/";
  static const String deleteCategory = "workshop-categories/delete/";

  // ============= Enrollment Routes =============
  static const String createEnrollment = "enrollments/save";
  static const String getAllEnrollments = "enrollments/";
  static const String getEnrollmentById = "enrollments/";
  static const String getEnrollment = "enrollments/user/";
  static const String updateEnrollment = "enrollments/update/";
  static const String deleteEnrollment = "enrollments/delete/";

  // ============= User Routes =============
  static const String createUser = "users/save";
  static const String getAllUser = "users/";
}
