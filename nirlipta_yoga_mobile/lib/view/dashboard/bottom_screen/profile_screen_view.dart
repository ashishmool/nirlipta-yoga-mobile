import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nirlipta_yoga_mobile/core/common/snackbar.dart';
import 'package:nirlipta_yoga_mobile/models/user.dart';

class ProfileScreenView extends StatefulWidget {
  final User user;

  const ProfileScreenView({super.key, required this.user});

  @override
  ProfileScreenViewState createState() => ProfileScreenViewState();
}

class ProfileScreenViewState extends State<ProfileScreenView> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();

  late TextEditingController _ageController;
  late TextEditingController _medicalConditionsController;

  File? _newProfilePicture;
  String? _selectedGender;

  @override
  void initState() {
    super.initState();
    _ageController = TextEditingController(text: widget.user.age.toString());
    _medicalConditionsController =
        TextEditingController(text: widget.user.medicalConditions.join(', '));
    _selectedGender = widget.user.gender.isNotEmpty ? widget.user.gender : null;
  }

  Future<void> _pickProfilePicture() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _newProfilePicture = File(image.path);
      });
    }
  }

  void _saveProfile() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.user.profilePicture =
          _newProfilePicture?.path ?? widget.user.profilePicture;
      widget.user.age = int.parse(_ageController.text);
      widget.user.gender = _selectedGender ?? widget.user.gender;
      widget.user.medicalConditions = _medicalConditionsController.text
          .split(',')
          .map((e) => e.trim())
          .toList();

      showMySnackbar(context, "Profile Updated Successfully!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.settings, size: 28),
                    onPressed: () {},
                    color: Colors.black,
                    tooltip: 'Settings',
                  ),
                  Stack(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.notifications, size: 28),
                        onPressed: () {},
                        color: Colors.black,
                        tooltip: 'Notifications',
                      ),
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 18,
                            minHeight: 18,
                          ),
                          child: const Text(
                            '3',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Profile Picture Part
              Center(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: _newProfilePicture != null
                              ? FileImage(_newProfilePicture!)
                              : NetworkImage(widget.user.profilePicture)
                                  as ImageProvider,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: _pickProfilePicture,
                            child: CircleAvatar(
                              radius: 16,
                              backgroundColor: Colors.blue,
                              child: const Icon(
                                Icons.camera_alt,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.user.email,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Profile Form Fields
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Age Field
                    TextFormField(
                      controller: _ageController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Age'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your age';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    DropdownButtonFormField<String>(
                      value: _selectedGender,
                      decoration: const InputDecoration(labelText: 'Gender'),
                      items: ['Male', 'Female', 'Other']
                          .map((gender) => DropdownMenuItem(
                                value: gender,
                                child: Text(gender),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),

                    // Medical Conditions Field
                    TextFormField(
                      controller: _medicalConditionsController,
                      decoration: const InputDecoration(
                          labelText: 'Medical Conditions'),
                    ),
                    const SizedBox(height: 24),

                    // Save Button
                    ElevatedButton(
                      onPressed: _saveProfile,
                      child: const Text('Save Profile'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoCard(String label, String value) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
