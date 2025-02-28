import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:nirlipta_yoga_mobile/core/common/snackbar/snackbar.dart';
import 'package:nirlipta_yoga_mobile/core/theme/app_theme.dart';

import '../../../../app/shared_prefs/user_shared_prefs.dart';
import '../../../../core/theme/theme_cubit.dart';
import '../../../schedule/presentation/view/view_schedule_user.dart';
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

                          /// Workshop Title
                          Text(
                            "Workshop Title: ${enrollment.workshop.title ?? 'N/A'}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? Colors.white : Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),

                          /// **Status & Payment Status Row**
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  _getStatusIcon(enrollment.completionStatus),
                                  const SizedBox(width: 6),
                                  Text(
                                    "Status: ${enrollment.completionStatus}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: isDarkMode
                                          ? Colors.white70
                                          : Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "Enrollment Date: $formattedDate",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: isDarkMode
                                      ? Colors.white70
                                      : Colors.black87,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),

                          /// **Enrollment Date & Price Row**
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  _getPaymentStatusIcon(
                                      enrollment.paymentStatus),
                                  const SizedBox(width: 6),
                                  Text(
                                    "Payment: ${enrollment.paymentStatus}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: isDarkMode
                                          ? Colors.white70
                                          : Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  // Show discounted price if valid
                                  if (enrollment.workshop.discountPrice !=
                                          null &&
                                      enrollment.workshop.discountPrice! > 0 &&
                                      enrollment.workshop.discountPrice! <
                                          enrollment.workshop.price!)
                                    Row(
                                      children: [
                                        // Strikethrough original price
                                        Text(
                                          "₹${enrollment.workshop.price}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: isDarkMode
                                                ? Colors.white70
                                                : Colors.black54,
                                            decoration: TextDecoration
                                                .lineThrough, // Strikethrough
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        // Add some spacing
                                        // Show discounted price
                                        Text(
                                          "₹${enrollment.workshop.discountPrice}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: isDarkMode
                                                ? Colors.white
                                                : Colors.black87,
                                          ),
                                        ),
                                      ],
                                    )
                                  else
                                    // Show original price if no valid discount
                                    Text(
                                      "₹${enrollment.workshop.price ?? 'N/A'}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: isDarkMode
                                            ? Colors.white
                                            : Colors.black87,
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          /// **Buttons Row**
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
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
                              if (enrollment.paymentStatus == "failed" ||
                                  enrollment.paymentStatus == "pending")
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            _processPayment(
                                                context, enrollment.id!);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red[700],
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: const Text('Pay Now'),
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

  Widget _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case "completed":
        return const Icon(Icons.check_circle, color: Colors.green, size: 20);
      case "not started":
        return const Icon(Icons.pause_circle, color: Colors.amber, size: 20);
      case "in progress":
        return const Icon(Icons.autorenew, color: Colors.blue, size: 20);
      default:
        return const Icon(Icons.help_outline, color: Colors.grey, size: 20);
    }
  }

  Widget _getPaymentStatusIcon(String paymentStatus) {
    switch (paymentStatus.toLowerCase()) {
      case "paid":
        return const Icon(Icons.check_circle, color: Colors.green, size: 20);
      case "failed":
        return const Icon(Icons.cancel, color: Colors.red, size: 20);
      case "pending":
        return const Icon(Icons.hourglass_empty,
            color: Colors.orange, size: 20);
      default:
        return const Icon(Icons.help_outline, color: Colors.grey, size: 20);
    }
  }

  Future<void> _processPayment(
      BuildContext context, String enrollmentId) async {
    final url = Uri.parse("$baseUrl/api/enrollments/status/$enrollmentId");

    try {
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
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({"payment_status": "paid"}),
      );

      Navigator.pop(context);

      if (response.statusCode == 200) {
        showMySnackBar(context: context, message: "Payment Successful!");
        // Dispatch an event to reload the enrollments
        context.read<EnrollmentBloc>().add(LoadEnrollments());
      } else {
        showMySnackBar(context: context, message: "Payment Failed. Try again.");
      }
    } catch (e) {
      Navigator.pop(context);
      showMySnackBar(context: context, message: "Error processing payment.");
    }
  }

  Future<String?> _getUserId() async {
    final userData = await UserSharedPrefs().getUserData();
    return userData.fold((failure) => null, (data) => data[2]);
  }
}
