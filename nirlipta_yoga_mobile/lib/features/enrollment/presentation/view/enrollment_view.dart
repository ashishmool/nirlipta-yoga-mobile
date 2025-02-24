// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../view_model/enrollment_bloc.dart';
//
// class EnrollmentView extends StatelessWidget {
//   EnrollmentView({super.key});
//
//   final String baseUrl = "http://10.0.2.2:5000";
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox.expand(
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: BlocBuilder<EnrollmentBloc, EnrollmentState>(
//           builder: (context, state) {
//             if (state.isLoading) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state.enrollments.isEmpty) {
//               return const Center(child: Text('No Enrollments Added Yet'));
//             } else {
//               return ListView.builder(
//                 padding: const EdgeInsets.all(8),
//                 itemCount: state.enrollments.length,
//                 itemBuilder: (context, index) {
//                   final enrollment = state.enrollments[index];
//                   final date = (enrollment.enrollmentDate);
//                   final formattedDate =
//                       "${date.day}/${date.month}/${date.year}"; // Format date
//
//                   return Card(
//                     elevation: 5,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // Left side: Workshop details
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "Workshop Title: ${enrollment.workshop.title ?? 'N/A'}",
//                                   style: const TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 5),
//                                 Text(
//                                   "Status: ${enrollment.completionStatus}",
//                                   style: const TextStyle(
//                                     fontSize: 14,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 5),
//                                 Text(
//                                   "Enrollment Date: $formattedDate",
//                                   style: const TextStyle(
//                                     fontSize: 14,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 5),
//                                 Text(
//                                   "Payment Status: ${enrollment.paymentStatus}",
//                                   style: const TextStyle(
//                                     fontSize: 14,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 8),
//
//                                 // Show "Generate Certificate" button if status is completed
//                                 if (enrollment.completionStatus == "completed")
//                                   ElevatedButton(
//                                     onPressed: () {
//                                       print("Generate Certificate");
//                                     },
//                                     style: ElevatedButton.styleFrom(
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(10),
//                                       ),
//                                     ),
//                                     child: const Text('Generate Certificate'),
//                                   ),
//
//                                 // Show "Make Payment" button if payment status is failed
//                                 if (enrollment.paymentStatus == "failed")
//                                   ElevatedButton(
//                                     onPressed: () {
//                                       print("Redirect to Payment Page");
//                                       // Add logic to navigate to the payment screen
//                                     },
//                                     style: ElevatedButton.styleFrom(
//                                       backgroundColor: Colors.red,
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(10),
//                                       ),
//                                     ),
//                                     child: const Text(
//                                       'Make Payment',
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                   ),
//                               ],
//                             ),
//                           ),
//
//                           // Right side: Workshop Image
//                           ClipRRect(
//                             borderRadius: BorderRadius.circular(10),
//                             child: enrollment.workshop.photo != null &&
//                                     enrollment.workshop.photo!.isNotEmpty
//                                 ? Image.network(
//                                     "$baseUrl${enrollment.workshop.photo}",
//                                     width: 80,
//                                     height: 80,
//                                     fit: BoxFit.cover,
//                                   )
//                                 : Container(
//                                     width: 80,
//                                     height: 80,
//                                     color: Colors.grey[300],
//                                     child: const Icon(Icons.image_not_supported,
//                                         color: Colors.grey),
//                                   ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view_model/enrollment_bloc.dart';

class EnrollmentView extends StatelessWidget {
  EnrollmentView({super.key});

  final String baseUrl = "http://10.0.2.2:5000";

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<EnrollmentBloc, EnrollmentState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.enrollments.isEmpty) {
              return const Center(child: Text('No Enrollments Added Yet'));
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
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "Status: ${enrollment.completionStatus}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "Enrollment Date: $formattedDate",
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "Payment Status: ${enrollment.paymentStatus}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 8),

                                // Show "Generate Certificate" button if status is completed
                                if (enrollment.completionStatus == "completed")
                                  ElevatedButton(
                                    onPressed: () {
                                      print("Generate Certificate");
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
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
                                        borderRadius: BorderRadius.circular(10),
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
                                    color: Colors.grey[300],
                                    child: const Icon(Icons.image_not_supported,
                                        color: Colors.grey),
                                  ),
                          ),

                          // Delete Icon Button
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              if (enrollment.id != null) {
                                // Pass `enrollment.id!` to ensure it's not null
                                context
                                    .read<EnrollmentBloc>()
                                    .add(DeleteEnrollment(enrollment.id!));
                              } else {
                                // Handle null `id` if needed
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
    );
  }
}
