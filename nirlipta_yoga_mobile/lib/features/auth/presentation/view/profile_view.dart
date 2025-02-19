import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final _gap = const SizedBox(height: 8);
  final _key = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: 'Ashish Mool');
  final _usernameController = TextEditingController(text: 'ashishmool');
  final _medicalConditionsController = TextEditingController();
  final _phoneController = TextEditingController(text: '9813949495');
  final _emailController = TextEditingController(text: 'a3.asis@gmail.com');
  final _passwordController = TextEditingController(text: 'test12345');
  final _confirmPasswordController = TextEditingController(text: 'test12345');

  String? _genderValue = 'male';
  bool _isPasswordVisible = false;
  bool _isNoneSelected = true;

  File? _img;

  Future _browseImage(ImageSource imageSource) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageSource);
      if (photo != null) {
        setState(() {
          _img = File(photo.path);
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _key,
              child: Column(
                children: [
                  const SizedBox(height: 12),
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
                                onPressed: () {
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
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          CircleAvatar(
                            radius: 100,
                            backgroundColor: Colors.white,
                            backgroundImage: _img != null
                                ? FileImage(_img!)
                                : const AssetImage(
                                    'assets/images/profile-placeholder.png',
                                  ) as ImageProvider,
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
                                    color: Colors.black.withOpacity(0.3),
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
                  const SizedBox(height: 25),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Full Name',
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  _gap,
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
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
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 6,
                        child: TextFormField(
                          controller: _phoneController,
                          decoration: const InputDecoration(
                            labelText: 'Mobile No.',
                            prefixIcon: Icon(Icons.phone),
                          ),
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
                        ),
                      ),
                      const SizedBox(width: 10),
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
                        ),
                      ),
                    ],
                  ),
                  _gap,
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                  _gap,
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      prefixIcon: Icon(Icons.account_circle),
                    ),
                  ),
                  _gap,
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: _isNoneSelected,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isNoneSelected = value ?? false;
                                  if (_isNoneSelected) {
                                    _medicalConditionsController.text = 'None';
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
                        child: TextFormField(
                          controller: _medicalConditionsController,
                          decoration: const InputDecoration(
                            labelText: 'Medical Conditions',
                            prefixIcon: Icon(Icons.medical_information),
                          ),
                          enabled: !_isNoneSelected,
                        ),
                      ),
                    ],
                  ),
                  _gap,
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_key.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Profile details saved!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        }
                      },
                      child: const Text('Save Changes'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
