import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

import '../../../workshop/data/model/workshop_hive_model.dart';
import '../../../workshop/domain/entity/workshop_entity.dart';
import '../../../workshop/presentation/view_model/workshop_bloc.dart';
import '../view_model/signup/register_bloc.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _gap = const SizedBox(height: 8);
  final _key = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: '');
  final _medicalConditionsController = TextEditingController(text: '');
  final _phoneController = TextEditingController(text: '');
  final _emailController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: '');
  final _confirmPasswordController = TextEditingController(text: '');

  String? _genderValue = 'Male';
  bool _isPasswordVisible = false;
  bool _isNoneSelected =
      false; // Track whether "None" is selected for medical conditions

  final List<WorkshopEntity> _lstWorkshopSelected = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Registration'),
        centerTitle: true,
      ),
      body: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state.isLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Registering User...'),
                duration: Duration(seconds: 2),
              ),
            );
          } else if (state.isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('User Registered Successfully!'),
                backgroundColor: Colors.green,
              ),
            );
            _key.currentState!.reset();

            Future.delayed(const Duration(seconds: 4), () {
              Navigator.pop(context); // Navigate back to the login page
            });
          } else if (!state.isLoading && !state.isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Failed to register User. Try again!'),
                backgroundColor: Color(0xFF9B6763),
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
                    SizedBox(height: 28),
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
                        child: Container(
                          alignment: Alignment.center,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              CircleAvatar(
                                radius: 100,
                                backgroundColor: Colors.white,
                                backgroundImage: const AssetImage(
                                  'assets/images/profile-placeholder.png',
                                ),
                              ),
                              Positioned(
                                bottom: 5,
                                right: 15,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Colors.black.withValues(alpha: 0.3),
                                        blurRadius: 5,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt,
                                    size: 24,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Full Name',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter first name';
                        }
                        return null;
                      },
                    ),
                    _gap,
                    Row(
                      children: [
                        // Gender Dropdown takes 30% of the width
                        Expanded(
                          flex: 3,
                          child: DropdownButtonFormField<String>(
                            value: _genderValue,
                            items: ['Male', 'Female', 'Other']
                                .map((gender) => DropdownMenuItem<String>(
                                      value: gender,
                                      child: Text(gender),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _genderValue = value;
                              });
                            },
                            decoration: const InputDecoration(
                              labelText: 'Gender',
                            ),
                            validator: (value) {
                              if (value == null) {
                                return 'Please select gender';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 10), // Spacing between fields
                        // Mobile No. takes 70% of the width
                        Expanded(
                          flex: 7,
                          child: TextFormField(
                            controller: _phoneController,
                            decoration: const InputDecoration(
                              labelText: 'Mobile No.',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter mobile number';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    _gap,
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: !_isPasswordVisible,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter password';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 10), // Spacing between fields
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            controller: _confirmPasswordController,
                            obscureText: !_isPasswordVisible,
                            decoration: InputDecoration(
                              labelText: 'Confirm Password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please confirm password';
                              }
                              if (value != _passwordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
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
                    // Medical Conditions and "None" Checkbox
                    Row(
                      children: [
                        Expanded(
                          flex: 8,
                          // Adjusts the TextField width to take more space
                          child: TextFormField(
                            controller: _medicalConditionsController,
                            decoration: const InputDecoration(
                              labelText: 'Medical Conditions',
                            ),
                            enabled: !_isNoneSelected,
                            validator: (value) {
                              if (!_isNoneSelected &&
                                  (value == null || value.isEmpty)) {
                                return 'Please enter medical conditions';
                              }
                              return null;
                            },
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          // Adjusts the Checkbox width to take less space
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Checkbox(
                                value: _isNoneSelected,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _isNoneSelected = value ?? false;
                                    if (_isNoneSelected) {
                                      _medicalConditionsController.text =
                                          'None';
                                    } else {
                                      _medicalConditionsController.clear();
                                    }
                                  });
                                },
                              ),
                              const Text('None'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    _gap,
                    // BlocBuilder for Workshop selection
                    BlocBuilder<WorkshopBloc, WorkshopState>(
                      builder: (context, workshopState) {
                        if (workshopState.isLoading) {
                          return const CircularProgressIndicator();
                        } else {
                          return MultiSelectDialogField(
                            title: const Text('Select Workshop'),
                            items: workshopState.workshops
                                .map(
                                  (workshop) => MultiSelectItem(
                                    workshop,
                                    workshop.title,
                                  ),
                                )
                                .toList(),
                            listType: MultiSelectListType.CHIP,
                            buttonText: const Text(
                              'Select Workshop',
                              style: TextStyle(color: Colors.black),
                            ),
                            buttonIcon: const Icon(Icons.search),
                            onConfirm: (values) {
                              _lstWorkshopSelected.clear();
                              _lstWorkshopSelected.addAll(values);
                            },
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black87,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select at least one workshop';
                              }
                              return null;
                            },
                          );
                        }
                      },
                    ),
                    SizedBox(height: 16),

                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_key.currentState!.validate()) {
                            final workshopsHiveModels =
                                WorkshopHiveModel.fromEntityList(
                                    _lstWorkshopSelected);
                            context.read<RegisterBloc>().add(RegisterStudent(
                                  name: _nameController.text,
                                  phone: _phoneController.text,
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  gender: _genderValue.toString(),
                                  workshops: workshopsHiveModels,
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
