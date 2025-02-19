// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
//
// import '../../../../core/common/permission_checker/permission_checker.dart';
// import '../../domain/use_case/update_user_usecase.dart';
// import '../view_model/profile/profile_bloc.dart';
//
// class ProfileView extends StatefulWidget {
//   const ProfileView({super.key});
//
//   @override
//   State<ProfileView> createState() => _ProfileViewState();
// }
//
// class _ProfileViewState extends State<ProfileView> {
//   final _gap = const SizedBox(height: 8);
//   final _key = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _usernameController = TextEditingController();
//   final _medicalConditionsController = TextEditingController();
//   final _phoneController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//
//   String? _genderValue = 'male';
//   bool _isPasswordVisible = false;
//   bool _isNoneSelected = true;
//
//   File? _img;
//
//   Future _browseImage(ImageSource imageSource) async {
//     try {
//       final photo = await ImagePicker().pickImage(source: imageSource);
//       if (photo != null) {
//         setState(() {
//           _img = File(photo.path);
//         });
//       }
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Profile'),
//         centerTitle: true,
//         iconTheme: const IconThemeData(
//           color: Colors.white,
//         ),
//       ),
//       body: BlocConsumer<ProfileBloc, ProfileState>(
//         listener: (context, state) {
//           if (state.isSuccess && state.user != null) {
//             setState(() {
//               _nameController.text = state.user!.name;
//               _usernameController.text = state.user!.username;
//               _phoneController.text = state.user!.phone;
//               _emailController.text = state.user!.email;
//               _genderValue = state.user!.gender;
//               _medicalConditionsController.text =
//                   state.user!.medical_conditions.isNotEmpty
//                       ? state.user!.medical_conditions
//                       : '';
//             });
//           }
//
//           if (state.isUpdateSuccess) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(
//                 content: Text('Profile updated successfully!'),
//                 backgroundColor: Colors.green,
//               ),
//             );
//           }
//         },
//         builder: (context, state) {
//           if (state.isLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           return SingleChildScrollView(
//             padding: const EdgeInsets.all(24),
//             child: Form(
//               key: _key,
//               child: Column(
//                 children: [
//                   InkWell(
//                     onTap: () {
//                       showModalBottomSheet(
//                         backgroundColor: Colors.grey[300],
//                         context: context,
//                         isScrollControlled: true,
//                         shape: const RoundedRectangleBorder(
//                           borderRadius: BorderRadius.vertical(
//                             top: Radius.circular(20),
//                           ),
//                         ),
//                         builder: (context) => Padding(
//                           padding: const EdgeInsets.all(20),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: [
//                               ElevatedButton.icon(
//                                 onPressed: () async {
//                                   await PermissionChecker
//                                       .checkCameraPermission();
//                                   _browseImage(ImageSource.camera);
//                                   Navigator.pop(context);
//                                 },
//                                 icon: const Icon(
//                                   Icons.camera,
//                                   color: Colors.white,
//                                 ),
//                                 label: const Text('Camera'),
//                               ),
//                               ElevatedButton.icon(
//                                 onPressed: () async {
//                                   await PermissionChecker
//                                       .checkCameraPermission();
//                                   _browseImage(ImageSource.gallery);
//                                   Navigator.pop(context);
//                                 },
//                                 icon: const Icon(
//                                   Icons.image,
//                                   color: Colors.white,
//                                 ),
//                                 label: const Text('Gallery'),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                     child: SizedBox(
//                       height: 180,
//                       width: 180,
//                       child: CircleAvatar(
//                         radius: 100,
//                         backgroundColor: Colors.white,
//                         backgroundImage: _img != null
//                             ? FileImage(_img!)
//                             : (state.user?.photo != null &&
//                                         state.user!.photo!.isNotEmpty
//                                     ? NetworkImage(
//                                         "http://10.0.2.2:5000/uploads/${state.user!.photo!}")
//                                     : const AssetImage(
//                                         'assets/images/profile-placeholder.png'))
//                                 as ImageProvider,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 25),
//                   TextFormField(
//                     controller: _nameController,
//                     decoration: const InputDecoration(
//                       labelText: 'Full Name',
//                       prefixIcon: Icon(Icons.person),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter full name';
//                       }
//                       return null;
//                     },
//                   ),
//                   _gap,
//                   Row(
//                     children: [
//                       Expanded(
//                         flex: 4,
//                         child: DropdownButtonFormField<String>(
//                           value: _genderValue,
//                           items: ['male', 'female', 'other']
//                               .map((gender) => DropdownMenuItem<String>(
//                                     value: gender,
//                                     child: Text(gender),
//                                   ))
//                               .toList(),
//                           onChanged: (value) {
//                             setState(() {
//                               _genderValue = value;
//                             });
//                           },
//                           decoration: const InputDecoration(
//                             labelText: 'Gender',
//                             prefixIcon: Icon(Icons.transgender),
//                           ),
//                           validator: (value) {
//                             if (value == null) {
//                               return 'Please select gender';
//                             }
//                             return null;
//                           },
//                         ),
//                       ),
//                       const SizedBox(width: 10),
//                       Expanded(
//                         flex: 6,
//                         child: TextFormField(
//                           controller: _phoneController,
//                           decoration: const InputDecoration(
//                             labelText: 'Mobile No.',
//                             prefixIcon: Icon(Icons.phone),
//                           ),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter mobile number';
//                             }
//                             return null;
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                   _gap,
//                   TextFormField(
//                     controller: _emailController,
//                     decoration: const InputDecoration(
//                       labelText: 'Email',
//                       prefixIcon: Icon(Icons.email),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter email';
//                       }
//                       return null;
//                     },
//                   ),
//                   _gap,
//                   TextFormField(
//                     controller: _usernameController,
//                     decoration: const InputDecoration(
//                       labelText: 'Username',
//                       prefixIcon: Icon(Icons.account_circle),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter username';
//                       }
//                       return null;
//                     },
//                   ),
//                   _gap,
//                   Row(
//                     children: [
//                       Expanded(
//                         flex: 3,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Checkbox(
//                               value: _isNoneSelected,
//                               onChanged: (bool? value) {
//                                 setState(() {
//                                   _isNoneSelected = value ?? false;
//                                   if (_isNoneSelected) {
//                                     _medicalConditionsController.text = 'None';
//                                   } else {
//                                     _medicalConditionsController.clear();
//                                   }
//                                 });
//                               },
//                             ),
//                             const Text('None'),
//                           ],
//                         ),
//                       ),
//                       Expanded(
//                         flex: 7,
//                         child: TextFormField(
//                           controller: _medicalConditionsController,
//                           decoration: const InputDecoration(
//                             labelText: 'Medical Conditions',
//                             prefixIcon: Icon(Icons.medical_information),
//                           ),
//                           enabled: !_isNoneSelected,
//                           validator: (value) {
//                             if (!_isNoneSelected &&
//                                 (value == null || value.isEmpty)) {
//                               return 'Please enter medical conditions';
//                             }
//                             return null;
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                   _gap,
//                   SizedBox(
//                     height: 50,
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         if (_key.currentState!.validate()) {
//                           final params = UpdateUserParams(
//                             id: state.user!.id!,
//                             name: _nameController.text,
//                             username: _usernameController.text,
//                             phone: _phoneController.text,
//                             email: _emailController.text,
//                             photo:
//                                 _img != null ? _img!.path : state.user?.photo,
//                             gender: _genderValue!,
//                             medical_conditions:
//                                 _medicalConditionsController.text,
//                             password: _passwordController.text,
//                           );
//
//                           context
//                               .read<ProfileBloc>()
//                               .add(UpdateUserProfile(params: params));
//                         }
//                       },
//                       child: const Text('Update Profile'),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/common/permission_checker/permission_checker.dart';
import '../../domain/use_case/update_user_usecase.dart';
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
  final _passwordController = TextEditingController();

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
        title: const Text('Profile'),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state.isSuccess && state.user != null) {
            setState(() {
              _nameController.text = state.user!.name;
              _usernameController.text = state.user!.username;
              _phoneController.text = state.user!.phone;
              _emailController.text = state.user!.email;
              _genderValue = state.user!.gender;
            });
          }

          if (state.isUpdateSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Profile updated successfully!'),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // User data is available in the state
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
                      child: CircleAvatar(
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
                          validator: (value) {
                            if (value == null) {
                              return 'Please select gender';
                            }
                            return null;
                          },
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
                  TextFormField(
                    controller: _emailController,
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
                  _gap,
                  TextFormField(
                    controller: _usernameController,
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
                          final params = UpdateUserParams(
                            id: state.user!.id!,
                            name: _nameController.text,
                            username: _usernameController.text,
                            phone: _phoneController.text,
                            email: _emailController.text,
                            photo:
                                _img != null ? _img!.path : state.user?.photo,
                            gender: _genderValue!,
                            // medical_conditions:
                            //     _medicalConditionsController.text,
                            password: _passwordController.text,
                          );

                          context
                              .read<ProfileBloc>()
                              .add(UpdateUserProfile(params: params));
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
    );
  }
}
