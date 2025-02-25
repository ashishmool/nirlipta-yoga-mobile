import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:nirlipta_yoga_mobile/core/common/snackbar/snackbar.dart';
import 'package:nirlipta_yoga_mobile/core/theme/app_theme.dart';

import '../../../../app/shared_prefs/user_shared_prefs.dart';
import '../../../../core/theme/theme_cubit.dart';
import '../../../schedule/view_schedule_user.dart';
import '../view_model/enrollment_bloc.dart';

class EnrollmentView extends StatelessWidget {
  EnrollmentView({super.key});

  final String baseUrl = "http://10.0.2.2:5000";

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<ThemeCubit>();
    final isDarkMode = themeCubit.state.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Enrollments'),
        backgroundColor: isDarkMode ? Colors.grey[900] : primaryColor,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: isDarkMode ? Colors.white : Colors.black,
        ),
        actions: [
          FutureBuilder<String?>(
            future: _getUserId(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }
              return IconButton(
                icon: Icon(Icons.calendar_today,
                    color: isDarkMode ? Colors.white : Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ViewScheduleUser(userId: snapshot.data!),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Container(
        color: isDarkMode ? Colors.black : Colors.white,
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
                itemCount: state.enrollments.length,
                itemBuilder: (context, index) {
                  final enrollment = state.enrollments[index];
                  final date = enrollment.enrollmentDate;
                  final formattedDate =
                      "${date.day}/${date.month}/${date.year}";

                  return Card(
                    color: isDarkMode ? Colors.black54 : Colors.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Workshop Image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: enrollment.workshop.photo != null &&
                                    enrollment.workshop.photo!.isNotEmpty
                                ? Image.network(
                                    "$baseUrl${enrollment.workshop.photo}",
                                    width: double.infinity,
                                    height: 140,
                                    fit: BoxFit.cover,
                                  )
                                : Container(
                                    width: double.infinity,
                                    height: 140,
                                    color: isDarkMode
                                        ? Colors.grey[800]
                                        : Colors.grey[300],
                                    child: Icon(
                                      Icons.image_not_supported,
                                      size: 50,
                                      color: isDarkMode
                                          ? Colors.white54
                                          : Colors.grey,
                                    ),
                                  ),
                          ),
                          const SizedBox(height: 12),

                          // Workshop Details
                          Text(
                            "Workshop Title: ${enrollment.workshop.title ?? 'N/A'}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? Colors.white : Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "Status: ${enrollment.completionStatus}",
                            style: TextStyle(
                              fontSize: 14,
                              color:
                                  isDarkMode ? Colors.white70 : Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "Enrollment Date: $formattedDate",
                            style: TextStyle(
                              fontSize: 14,
                              color:
                                  isDarkMode ? Colors.white70 : Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "Payment Status: ${enrollment.paymentStatus}",
                            style: TextStyle(
                              fontSize: 14,
                              color:
                                  isDarkMode ? Colors.white70 : Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Buttons Section
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Generate Certificate Button
                              if (enrollment.completionStatus == "completed")
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      final userId = await _getUserId();
                                      final workshopId = enrollment.workshop.id;

                                      if (userId != null &&
                                          workshopId != null) {
                                        final url = Uri.parse(
                                            "$baseUrl/api/enrollments/certification/$userId/$workshopId");

                                        try {
                                          showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (context) {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            },
                                          );
                                          final response = await http.get(url);
                                          Navigator.pop(context);

                                          if (response.statusCode == 200) {
                                            showMySnackBar(
                                                context: context,
                                                message:
                                                    "Certificate Generated Successfully!");
                                          }
                                        } catch (e) {
                                          print(
                                              "Error generating certificate: $e");
                                        }
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.teal,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: const Text('Generate Certificate'),
                                  ),
                                ),

                              const SizedBox(width: 10),

                              // Make Payment & Delete Button
                              if (enrollment.paymentStatus == "failed" ||
                                  enrollment.paymentStatus == "pending")
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            _showPaymentDialog(
                                                context,
                                                enrollment.id!,
                                                enrollment.workshop.price);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red[700],
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: const Text('Make Payment'),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            if (enrollment.id != null) {
                                              context
                                                  .read<EnrollmentBloc>()
                                                  .add(DeleteEnrollment(
                                                      enrollment.id!));
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.grey[700],
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: const Text('Delete'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
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
    );
  }

  // Function to show the payment modal
  // Function to show the payment modal
  void _showPaymentDialog(
      BuildContext context, String enrollmentId, double? price) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Payment'),
          content: Text(
            'Amount to be paid: ₹${price ?? 0.0}',
            // Ensuring price is displayed correctly
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the modal
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(context); // Close modal
                await _processPayment(context, enrollmentId);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text('Confirm Payment'),
            ),
          ],
        );
      },
    );
  }

  // Function to call API and process payment
  Future<void> _processPayment(
      BuildContext context, String enrollmentId) async {
    final url = Uri.parse("$baseUrl/api/enrollments/status/$enrollmentId");

    try {
      // Retrieve token
      final userData = await UserSharedPrefs().getUserData();
      final token = userData.fold((failure) => null, (data) => data[1]);

      if (token == null) {
        showMySnackBar(
            context: context,
            message: "Authentication failed. Please log in again.");
        return;
      }

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        },
      );

      final response = await http.patch(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token", // Add Bearer token here
        },
        body: jsonEncode({"payment_status": "paid"}),
      );

      Navigator.pop(context); // Close loading dialog

      if (response.statusCode == 200) {
        showMySnackBar(context: context, message: "Payment Successful!");
        // context.read<EnrollmentBloc>().add(LoadEnrollments());
      } else {
        showMySnackBar(context: context, message: "Payment Failed. Try again.");
      }
    } catch (e) {
      Navigator.pop(context);
      showMySnackBar(context: context, message: "Error processing payment.");
    }
  }
}

Future<String?> _getUserId() async {
  final userData = await UserSharedPrefs().getUserData();
  return userData.fold((failure) => null, (data) => data[2]);
}
