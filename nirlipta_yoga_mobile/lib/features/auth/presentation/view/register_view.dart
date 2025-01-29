import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../view_model/signup/register_bloc.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _gap = const SizedBox(height: 8);
  final _key = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: 'Ashish Mool');
  final _usernameController = TextEditingController(text: 'ashishmool');
  final _medicalConditionsController = TextEditingController(text: 'None');
  final _phoneController = TextEditingController(text: '9813949495');
  final _emailController = TextEditingController(text: 'a3.asis@gmail.com');
  final _passwordController = TextEditingController(text: 'test12345');
  final _confirmPasswordController = TextEditingController(text: 'test12345');

  String? _genderValue = 'Male';
  bool _isPasswordVisible = false;
  bool _isNoneSelected =
      false; // Track whether "None" is selected for medical conditions

  // Checking for Runtime Camera Permissions
  checkCameraPermission() async {
    if (await Permission.camera.request().isRestricted ||
        await Permission.camera.request().isDenied) {
      await Permission.camera.request();
    }
  }

  File? _img;

  Future _browseImage(ImageSource imageSource) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageSource);
      if (photo != null) {
        setState(() {
          _img = File(photo.path);

          //Send File to server
          context.read<RegisterBloc>().add(LoadImage(file: _img!));
        });
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Registration'),
        centerTitle: true,
      ),
      body: MultiBlocListener(
        listeners: [
          // Listener for Image Upload
          BlocListener<RegisterBloc, RegisterState>(
            listenWhen: (previous, current) =>
                previous.isImageLoading != current.isImageLoading ||
                previous.isImageSuccess != current.isImageSuccess,
            listener: (context, state) {
              if (state.isImageLoading) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Uploading image...'),
                    duration: Duration(seconds: 2),
                  ),
                );
              } else if (state.isImageSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Image uploaded successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );
              } else if (!state.isImageLoading &&
                  !state.isImageSuccess &&
                  state.imageName == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Failed to upload image. Please try again.'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),
          // Listener for Student Registration
          BlocListener<RegisterBloc, RegisterState>(
            listenWhen: (previous, current) =>
                previous.isLoading != current.isLoading ||
                previous.isSuccess != current.isSuccess,
            listener: (context, state) {
              if (state.isLoading) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Registering user...'),
                    duration: Duration(seconds: 2),
                  ),
                );
              } else if (state.isSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('User registered successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );

                // Navigate back to the login page after registration success
                Future.delayed(const Duration(seconds: 2), () {
                  Navigator.pop(context);
                });
              } else if (!state.isLoading && !state.isSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Failed to register user. Try again.'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),
        ],
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
                                    checkCameraPermission();
                                    _browseImage(ImageSource.camera);
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(Icons.camera),
                                  label: const Text('Camera'),
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    checkCameraPermission();
                                    _browseImage(ImageSource.gallery);
                                    Navigator.pop(context);
                                  },
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
                                backgroundImage: _img != null
                                    ? FileImage(_img!)
                                    : AssetImage(
                                        'assets/images/profile-placeholder.png',
                                      ) as ImageProvider,
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
                    TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter username';
                        }
                        return null;
                      },
                    ),
                    _gap,
                    // Medical Conditions and "None" Checkbox
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
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
                        Expanded(
                          flex: 7,
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
                      ],
                    ),
                    _gap,

                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_key.currentState!.validate()) {
                            final registerState =
                                context.read<RegisterBloc>().state;
                            final imageName = registerState.imageName;
                            context.read<RegisterBloc>().add(RegisterUser(
                                  name: _nameController.text,
                                  username: _usernameController.text,
                                  phone: _phoneController.text,
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  gender: _genderValue.toString(),
                                  medical_conditions: '',
                                  photo: imageName,
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
