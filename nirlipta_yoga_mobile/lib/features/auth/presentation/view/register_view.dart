import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

import '../../../batch/data/model/batch_hive_model.dart';
import '../../../batch/domain/entity/batch_entity.dart';
import '../../../batch/presentation/view_model/batch_bloc.dart';
import '../../../course/data/model/course_hive_model.dart';
import '../../../course/domain/entity/course_entity.dart';
import '../../../course/presentation/view_model/course_bloc.dart';
import '../view_model/signup/register_bloc.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _gap = const SizedBox(height: 8);
  final _key = GlobalKey<FormState>();
  final _fnameController = TextEditingController(text: 'Ashish');
  final _lnameController = TextEditingController(text: 'Mool');
  final _phoneController = TextEditingController(text: '9813943777');
  final _emailController = TextEditingController(text: 'test@email.com');
  final _passwordController = TextEditingController(text: 'password123');

  BatchEntity? _dropDownValue;
  final List<CourseEntity> _lstCourseSelected = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Student'),
        centerTitle: true,
      ),
      body: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state.isLoading) {
            // Show a loading Snackbar
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Registering student...'),
                duration: Duration(seconds: 2),
              ),
            );
          } else if (state.isSuccess) {
            // Show success message and clear form
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Student registered successfully!'),
                backgroundColor: Colors.green,
              ),
            );
            _key.currentState!.reset();

            // Navigate back to the login page
            Future.delayed(const Duration(seconds: 4), () {
              Navigator.pop(
                  context); // This pops the current register screen and goes back
            });
          } else if (!state.isLoading && !state.isSuccess) {
            // Show error message
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Failed to register student. Try again.'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Form(
                key: _key,
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          backgroundColor: Colors.grey[300],
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          builder: (context) => Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(Icons.camera),
                                  label: const Text('Camera'),
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(Icons.image),
                                  label: const Text('Gallery'),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: SizedBox(
                        height: 200,
                        width: 200,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              const AssetImage('assets/images/profile.png')
                                  as ImageProvider,
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    TextFormField(
                      controller: _fnameController,
                      decoration: const InputDecoration(
                        labelText: 'First Name',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter first name';
                        }
                        return null;
                      },
                    ),
                    _gap,
                    TextFormField(
                      controller: _lnameController,
                      decoration: const InputDecoration(
                        labelText: 'Last Name',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter last name';
                        }
                        return null;
                      },
                    ),
                    _gap,
                    TextFormField(
                      controller: _phoneController,
                      decoration: const InputDecoration(
                        labelText: 'Phone No',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter phone number';
                        }
                        return null;
                      },
                    ),
                    _gap,
                    BlocBuilder<BatchBloc, BatchState>(
                        builder: (context, state) {
                      return DropdownButtonFormField<BatchEntity>(
                        items: state.batches
                            .map((e) => DropdownMenuItem<BatchEntity>(
                                  value: e,
                                  child: Text(e.batchName),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _dropDownValue = value;
                          });
                        },
                        value: _dropDownValue,
                        decoration: const InputDecoration(
                          labelText: 'Select Batch',
                        ),
                        validator: (value) {
                          if (value == null) {
                            return 'Please select batch';
                          }
                          return null;
                        },
                      );
                    }),
                    _gap,
                    BlocBuilder<CourseBloc, CourseState>(
                        builder: (context, courseState) {
                      if (courseState.isLoading) {
                        return const CircularProgressIndicator();
                      } else {
                        return MultiSelectDialogField(
                          title: const Text('Select course'),
                          items: courseState.courses
                              .map(
                                (course) => MultiSelectItem(
                                  course,
                                  course.courseName,
                                ),
                              )
                              .toList(),
                          listType: MultiSelectListType.CHIP,
                          buttonText: const Text(
                            'Select course',
                            style: TextStyle(color: Colors.black),
                          ),
                          buttonIcon: const Icon(Icons.search),
                          onConfirm: (values) {
                            _lstCourseSelected.clear();
                            _lstCourseSelected.addAll(values);
                          },
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black87,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select courses';
                            }
                            return null;
                          },
                        );
                      }
                    }),
                    _gap,
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter email';
                        }
                        return null;
                      },
                    ),
                    _gap,
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                    ),
                    _gap,
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_key.currentState!.validate()) {
                            final batchHiveModel = _dropDownValue != null
                                ? BatchHiveModel.fromEntity(_dropDownValue!)
                                : null;
                            final coursesHiveModels =
                                CourseHiveModel.fromEntityList(
                                    _lstCourseSelected);
                            context.read<RegisterBloc>().add(RegisterStudent(
                                  fName: _fnameController.text,
                                  lName: _lnameController.text,
                                  phone: _phoneController.text,
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  batch: batchHiveModel!,
                                  courses: coursesHiveModels,
                                ));
                          }
                        },
                        child: const Text('Register'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
