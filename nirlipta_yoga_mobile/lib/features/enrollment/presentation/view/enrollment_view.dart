import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nirlipta_yoga_mobile/core/theme/app_theme.dart';

import '../../../../core/theme/theme_cubit.dart';
import '../view_model/enrollment_bloc.dart';

class EnrollmentView extends StatelessWidget {
  EnrollmentView({super.key});

  final String baseUrl = "http://10.0.2.2:5000";

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<ThemeCubit>(); // Watch theme state
    final isDarkMode = themeCubit.state.isDarkMode; // Check theme mode

    return Scaffold(
      appBar: AppBar(
        title: const Text('Enrollments'),
        backgroundColor: isDarkMode ? Colors.black : primaryColor,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      body: Container(
        color: isDarkMode ? Colors.black : Colors.white, // Background color
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<EnrollmentBloc, EnrollmentState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.enrollments.isEmpty) {
                return Center(
                  child: Text(
                    'No Enrollments Added Yet',
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                );
              } else {
                return ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: state.enrollments.length,
                  itemBuilder: (context, index) {
                    final enrollment = state.enrollments[index];
                    final date = enrollment.enrollmentDate;
                    final formattedDate =
                        "${date.day}/${date.month}/${date.year}"; // Format date

                    return Card(
                      color: isDarkMode ? Colors.black54 : Colors.white,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Left side: Workshop details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Workshop Title: ${enrollment.workshop.title ?? 'N/A'}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "Status: ${enrollment.completionStatus}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: isDarkMode
                                          ? Colors.white70
                                          : Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "Enrollment Date: $formattedDate",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: isDarkMode
                                          ? Colors.white70
                                          : Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "Payment Status: ${enrollment.paymentStatus}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: isDarkMode
                                          ? Colors.white70
                                          : Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 8),

                                  // Show "Generate Certificate" button if status is completed
                                  if (enrollment.completionStatus ==
                                      "completed")
                                    ElevatedButton(
                                      onPressed: () {
                                        print("Generate Certificate");
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: isDarkMode
                                            ? Colors.tealAccent[700]
                                            : Colors.teal,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: const Text('Generate Certificate'),
                                    ),

                                  // Show "Make Payment" button if payment status is failed
                                  if (enrollment.paymentStatus == "failed")
                                    ElevatedButton(
                                      onPressed: () {
                                        print("Redirect to Payment Page");
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: const Text(
                                        'Make Payment',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                ],
                              ),
                            ),

                            // Right side: Workshop Image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: enrollment.workshop.photo != null &&
                                      enrollment.workshop.photo!.isNotEmpty
                                  ? Image.network(
                                      "$baseUrl${enrollment.workshop.photo}",
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    )
                                  : Container(
                                      width: 80,
                                      height: 80,
                                      color: isDarkMode
                                          ? Colors.grey[800]
                                          : Colors.grey[300],
                                      child: Icon(
                                        Icons.image_not_supported,
                                        color: isDarkMode
                                            ? Colors.white54
                                            : Colors.grey,
                                      ),
                                    ),
                            ),

                            // Delete Icon Button
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                if (enrollment.id != null) {
                                  context
                                      .read<EnrollmentBloc>()
                                      .add(DeleteEnrollment(enrollment.id!));
                                } else {
                                  print("ID is null, cannot delete enrollment");
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
