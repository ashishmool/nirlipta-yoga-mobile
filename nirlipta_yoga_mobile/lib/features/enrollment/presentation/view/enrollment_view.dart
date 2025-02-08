import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view_model/enrollment_bloc.dart';

class EnrollmentView extends StatelessWidget {
  EnrollmentView({super.key});

  final enrollmentNameController = TextEditingController();

  final _enrollmentViewFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _enrollmentViewFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 10),
              BlocBuilder<EnrollmentBloc, EnrollmentState>(
                builder: (context, state) {
                  print(
                      "Current enrollments: ${state.enrollments}"); // Debugging

                  if (state.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state.error != null) {
                    return Center(child: Text("Error: ${state.error}"));
                  } else if (state.enrollments.isEmpty) {
                    return Center(child: Text('No Enrollments Added Yet'));
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: state.enrollments.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title:
                                Text(state.enrollments[index].completionStatus),
                            subtitle: Text(state.enrollments[index].id!),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
