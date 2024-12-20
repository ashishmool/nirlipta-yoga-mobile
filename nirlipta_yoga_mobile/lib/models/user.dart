class User {
  final String userId;
  final String email;
  String name;
  String profilePicture;
  final String role;
  int age;
  int stepsToday;
  String gender;
  List<String> medicalConditions;

  User({
    required this.userId,
    required this.email,
    required this.name,
    required this.profilePicture,
    required this.role,
    required this.age,
    required this.stepsToday,
    required this.gender,
    required this.medicalConditions,
  });
}
