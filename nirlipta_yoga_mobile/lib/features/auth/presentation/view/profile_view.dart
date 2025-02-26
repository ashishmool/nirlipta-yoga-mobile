import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nirlipta_yoga_mobile/core/theme/app_theme.dart';

import '../../../../core/common/permission_checker/permission_checker.dart';
import '../../../../core/theme/theme_cubit.dart';
import '../../../home/presentation/view_model/home_cubit.dart';
import '../view_model/profile/profile_bloc.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final _gap = const SizedBox(height: 8);
  final _key = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _medicalConditionsController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController(text: '');
  String? _genderValue = 'male';
  bool _isPasswordVisible = false;
  bool _isPasswordEditable = false;
  bool _isNoneSelected = true;

  File? _img;
  String? _previousImageName;

  Future _browseImage(ImageSource imageSource) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageSource);
      if (photo != null) {
        setState(() {
          _img = File(photo.path);
        });
        context.read<ProfileBloc>().add(LoadImage(file: _img!));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<ThemeCubit>(); // Watch theme state
    final isDarkMode = themeCubit.state.isDarkMode; // Check theme mode

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: isDarkMode ? Colors.grey[900] : primaryColor,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Container(
        color: isDarkMode ? Colors.black : Colors.white,
        child: MultiBlocListener(
          listeners: [
            BlocListener<ProfileBloc, ProfileState>(
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
                } else if (!state.isImageLoading && !state.isImageSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text('Failed to upload image. Please try again.'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
            ),
            BlocListener<ProfileBloc, ProfileState>(
              listenWhen: (previous, current) =>
                  previous.isUpdateLoading != current.isUpdateLoading ||
                  previous.isUpdateSuccess != current.isUpdateSuccess,
              listener: (context, state) {
                if (state.isUpdateLoading) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Updating profile...'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                } else if (state.isUpdateSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Profile updated successfully!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  context.read<HomeCubit>().onTabTapped(0);
                } else if (!state.isUpdateLoading && !state.isUpdateSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Failed to update profile. Try again.'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
            ),
            // Listener to update form fields when user data is fetched
            BlocListener<ProfileBloc, ProfileState>(
              listenWhen: (previous, current) =>
                  previous.user != current.user, // Listen for user data changes
              listener: (context, state) {
                if (state.user != null) {
                  // Update form fields with fetched user data
                  _nameController.text = state.user!.name;
                  _usernameController.text = state.user!.username;
                  _phoneController.text = state.user!.phone;
                  _emailController.text = state.user!.email;
                  _genderValue = state.user!.gender;
                  _passwordController.text = state.user!.password ?? '';
                  _medicalConditionsController.text =
                      state.user!.medical_conditions?.join(', ') ?? 'None';
                  _isNoneSelected =
                      state.user!.medical_conditions?.contains('None') ?? true;
                }
              },
            ),
          ],
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.user == null) {
                return const Center(child: Text("User data not available"));
              }

              return SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _key,
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            backgroundColor: isDarkMode
                                ? Colors.grey[850]
                                : Colors.grey[300],
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () async {
                                      await PermissionChecker
                                          .checkCameraPermission();
                                      _browseImage(ImageSource.camera);
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(
                                      Icons.camera,
                                      color: Colors.white,
                                    ),
                                    label: const Text('Camera'),
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: () async {
                                      await PermissionChecker
                                          .checkCameraPermission();
                                      _browseImage(ImageSource.gallery);
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(
                                      Icons.image,
                                      color: Colors.white,
                                    ),
                                    label: const Text('Gallery'),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        child: SizedBox(
                          height: 180,
                          width: 180,
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
                                      : (state.user?.photo != null &&
                                                  state.user!.photo!.isNotEmpty
                                              ? NetworkImage(
                                                  "http://10.0.2.2:5000/uploads/${state.user!.photo!}")
                                              : const AssetImage(
                                                  'assets/images/profile-placeholder.png'))
                                          as ImageProvider,
                                ),
                                Positioned(
                                  bottom: 5,
                                  right: 20,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black
                                              .withValues(alpha: 0.3),
                                          blurRadius: 5,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: const Icon(
                                      Icons.camera_alt,
                                      size: 24,
                                      color: Colors.black87,
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
                          prefixIcon: Icon(Icons.person),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter full name';
                          }
                          return null;
                        },
                      ),
                      _gap,
                      _gap,
                      Row(
                        children: [
                          // Gender Dropdown takes 30% of the width
                          Expanded(
                            flex: 5,
                            child: DropdownButtonFormField<String>(
                              value: _genderValue,
                              items: ['male', 'female', 'other']
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
                                prefixIcon: Icon(Icons.transgender),
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
                            flex: 6,
                            child: TextFormField(
                              controller: _phoneController,
                              decoration: const InputDecoration(
                                labelText: 'Mobile No.',
                                prefixIcon: Icon(Icons.phone),
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
                      _gap,
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: TextFormField(
                              controller: _passwordController,
                              obscureText: !_isPasswordVisible,
                              enabled: _isPasswordEditable,
                              // Check if it's enabled
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
                                if (_isPasswordEditable &&
                                    (value == null || value.isEmpty)) {
                                  return 'Please enter password';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),

                      // Add a checkbox for enabling/disabling the password field
                      Row(
                        children: [
                          Checkbox(
                            value: _isPasswordEditable,
                            onChanged: (bool? value) {
                              setState(() {
                                _isPasswordEditable = value ?? false;
                                if (!_isPasswordEditable) {
                                  _passwordController
                                      .clear(); // Clear the password when disabled
                                }
                              });
                            },
                          ),
                          const Text('Select to Change Password'),
                        ],
                      ),
                      _gap,
                      _gap,
                      Row(
                        children: [
                          // Email Field takes 50% of the width
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              controller: _emailController,
                              enabled: false,
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                prefixIcon: Icon(Icons.email),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter email';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 10), // Spacing between fields
                          // Username Field takes 50% of the width
                          Expanded(
                            flex: 1,
                            child: TextFormField(
                              controller: _usernameController,
                              enabled: false,
                              decoration: const InputDecoration(
                                labelText: 'Username',
                                prefixIcon: Icon(Icons.account_circle),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter username';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      _gap,
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
                                prefixIcon: Icon(Icons.medical_information),
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
                      _gap,
                      _gap,

                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_key.currentState!.validate()) {
                              final updateState =
                                  context.read<ProfileBloc>().state;
                              final imageName = updateState.imageName;
                              final userId = updateState
                                  .userId; // Get userId from the state

                              if (userId != null) {
                                context
                                    .read<ProfileBloc>()
                                    .add(UpdateUserProfile(
                                      id: userId,
                                      // Use the userId from the state
                                      name: _nameController.text,
                                      username: _usernameController.text,
                                      phone: _phoneController.text,
                                      password: _passwordController.text,
                                      email: _emailController.text,
                                      gender: _genderValue.toString(),
                                      medical_conditions: ['None'],
                                      photo: _img != null
                                          ? imageName
                                          : state.user?.photo,
                                    ));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('User ID is not available.'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            }
                          },
                          child: const Text('Update Profile'),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
