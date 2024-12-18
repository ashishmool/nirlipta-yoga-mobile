import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nirlipta_yoga_mobile/core/common/snackbar.dart';
import 'package:nirlipta_yoga_mobile/models/user.dart';

class ProfileScreenView extends StatefulWidget {
  final User user;

  const ProfileScreenView({super.key, required this.user}); // Constructor

  @override
  _ProfileScreenViewState createState() => _ProfileScreenViewState();
}

class _ProfileScreenViewState extends State<ProfileScreenView> {
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
    _selectedGender = widget.user.gender.isNotEmpty
        ? widget.user.gender
        : null; // Set initial gender
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
      // Update user information
      widget.user.profilePicture =
          _newProfilePicture?.path ?? widget.user.profilePicture;
      widget.user.age = int.parse(_ageController.text);
      widget.user.gender = _selectedGender ?? widget.user.gender;
      widget.user.medicalConditions = _medicalConditionsController.text
          .split(',')
          .map((e) => e.trim())
          .toList();

      ScaffoldMessenger.of(context).showSnackBar(
        showMySnackbar(context, 'Profile Updated Succesful!'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                // Profile image
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(widget.user.profilePicture),
                ),
                const SizedBox(height: 16),
                // Display the email, which is non-editable
                Text("Email: ${widget.user.email}"),
                const SizedBox(height: 8),
                // Display role, also non-editable
                Text("Role: ${widget.user.role}"),
                const SizedBox(height: 16),
                // Editable fields for age
                TextFormField(
                  controller: _ageController,
                  decoration: const InputDecoration(labelText: 'Age'),
                  keyboardType: TextInputType.number,
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
                  items: const [
                    DropdownMenuItem(value: 'Male', child: Text('Male')),
                    DropdownMenuItem(value: 'Female', child: Text('Female')),
                    DropdownMenuItem(value: 'Other', child: Text('Other')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                    });
                  },
                  decoration: const InputDecoration(labelText: 'Gender'),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select your gender';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Text("Medical Conditions:"),
                TextFormField(
                  controller: _medicalConditionsController,
                  decoration: const InputDecoration(
                      labelText: 'Medical Conditions (comma separated)'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your medical conditions';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),

                ElevatedButton(
                  onPressed: _saveProfile,
                  child: const Text(
                    "Update Profile",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
