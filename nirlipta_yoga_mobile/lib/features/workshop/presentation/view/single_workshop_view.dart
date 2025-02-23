import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nirlipta_yoga_mobile/features/workshop/domain/entity/workshop_entity.dart';

import '../../../../app/shared_prefs/user_shared_prefs.dart';
import '../../../enrollment/presentation/view_model/enrollment_bloc.dart';
import '../view_model/single_workshop_bloc.dart';
import '../view_model/single_workshop_event.dart';
import '../view_model/single_workshop_state.dart';

// Primary and Secondary Colors for Branding
const Color primaryColor = Color(0xFF9B6763);
const Color secondaryColor = Color(0xFFB8978C);

class SingleWorkshopView extends StatelessWidget {
  final String workshopId;

  const SingleWorkshopView({super.key, required this.workshopId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Workshop Details"),
        backgroundColor: primaryColor, // Dark Theme
        iconTheme: const IconThemeData(
          color: Colors.white, // White Back Button
        ),
      ),
      body: BlocProvider(
        create: (context) =>
            SingleWorkshopBloc()..add(LoadSingleWorkshop(workshopId)),
        child: BlocBuilder<SingleWorkshopBloc, SingleWorkshopState>(
          builder: (context, state) {
            if (state is SingleWorkshopLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SingleWorkshopLoaded) {
              final workshop = state.workshop;

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Workshop Image
                      if (workshop["photo"] != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            workshop["photo"],
                            width: double.infinity,
                            height: 220,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                              width: double.infinity,
                              height: 220,
                              color: Colors.grey[300],
                              child: const Icon(Icons.image,
                                  size: 50, color: Colors.grey),
                            ),
                          ),
                        ),
                      const SizedBox(height: 16),

                      // Title & Category
                      Text(
                        workshop["title"] ?? "No Title",
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        workshop["category"] ?? "No Category",
                        style:
                            const TextStyle(fontSize: 18, color: Colors.grey),
                      ),

                      const SizedBox(height: 16),
                      const Divider(),

                      // Price & Enroll Now Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Price Display
                          if (workshop["discount_price"] != null &&
                              workshop["discount_price"] > 0 &&
                              workshop["discount_price"] < workshop["price"])
                            Row(
                              children: [
                                Text(
                                  "\$${workshop["price"]}",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                      decoration: TextDecoration
                                          .lineThrough), // Strike-through
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "\$${workshop["discount_price"]}",
                                  style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green),
                                ),
                              ],
                            )
                          else
                            Text(
                              "\$${workshop["price"] ?? "0.00"}",
                              style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor),
                            ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () async {
                              final userData = await context
                                  .read<UserSharedPrefs>()
                                  .getUserData();
                              final userId = userData.fold(
                                (failure) => null,
                                (data) => data[2], // User ID is in data[2]
                              );

                              if (userId == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("User not logged in!")),
                                );
                                return;
                              }

                              final enrollmentBloc =
                                  context.read<EnrollmentBloc>();

                              // Use the actual workshop data from the state
                              final workshop = state.workshop;

                              enrollmentBloc.add(
                                AddEnrollment(
                                  userId: userId,
                                  workshop: WorkshopEntity(
                                    id: workshop["workshopId"],
                                    title: workshop["title"],
                                    categoryId: workshop["category"],
                                    price: workshop["price"],
                                    discountPrice: workshop["discount_price"],
                                    photo: workshop["photo"],
                                    description: workshop["description"],
                                    difficultyLevel: 'difficulty_level',
                                    modules: [],
                                  ),
                                  paymentStatus: "Pending",
                                  enrollmentDate: DateTime.now(),
                                  completionStatus: "In Progress",
                                  feedback: null,
                                ),
                              );
                            },
                            child: const Text("Enroll Now",
                                style: TextStyle(color: Colors.white)),
                          ),
                          // Your button code here
                          // "Enroll Now" Button
                        ],
                      ),

                      const SizedBox(height: 16),
                      const Divider(),

                      // Address
                      _buildInfoTile(Icons.location_on, "Address",
                          workshop["address"] ?? "No Address Available"),

                      // Classroom Info
                      _buildInfoTile(Icons.meeting_room, "Classroom Info",
                          workshop["classroom_info"] ?? "No Info Available"),

                      // Difficulty Level
                      _buildInfoTile(Icons.emoji_people, "Difficulty Level",
                          workshop["difficulty_level"]?.toUpperCase() ?? "N/A"),

                      // Map Location
                      _buildInfoTile(Icons.map, "Location Coordinates",
                          workshop["map_location"] ?? "Not Provided"),

                      const Divider(),

                      // Description
                      const SizedBox(height: 12),
                      const Text(
                        "Workshop Description",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        workshop["description"] ?? "No description available.",
                        style: const TextStyle(fontSize: 16),
                      ),

                      const SizedBox(height: 16),
                      const Divider(),

                      // Modules Section
                      if (workshop["modules"] != null &&
                          workshop["modules"].isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 12),
                            const Text(
                              "Workshop Modules",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            ...workshop["modules"].map<Widget>((module) {
                              return Card(
                                elevation: 2,
                                margin: const EdgeInsets.symmetric(vertical: 6),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(12),
                                  leading: const Icon(Icons.library_books,
                                      color: primaryColor),
                                  title: Text(
                                    module["name"] ?? "No Module Name",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    "Duration: ${module["duration"] ?? "Unknown"} mins",
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ),
                              );
                            }).toList(),
                          ],
                        ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              );
            } else if (state is SingleWorkshopError) {
              return Center(
                  child: Text("Error: ${state.message}",
                      style: const TextStyle(color: Colors.red)));
            } else {
              return const Center(child: Text("No workshop details available"));
            }
          },
        ),
      ),
    );
  }

  /// Reusable Widget for Info Tiles
  Widget _buildInfoTile(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: primaryColor),
          const SizedBox(width: 10),
          Expanded(
            child: Text.rich(
              TextSpan(
                text: "$title: ",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                children: [
                  TextSpan(
                    text: value,
                    style: const TextStyle(
                        fontWeight: FontWeight.normal, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
