import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view_model/category_bloc.dart';
import '../view_model/category_state.dart';

class CategoryView extends StatelessWidget {
  CategoryView({super.key});

  final categoryNameController = TextEditingController();
  final categoryDescriptionController = TextEditingController();
  final _categoryFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _categoryFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: categoryNameController,
                decoration: const InputDecoration(labelText: 'Category Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a category name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: categoryDescriptionController,
                keyboardType: TextInputType.number,
                decoration:
                    const InputDecoration(labelText: 'Category Description'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a category price';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (_categoryFormKey.currentState!.validate()) {
                    context.read<CategoryBloc>().add(
                          AddCategory(
                            name: categoryNameController.text,
                            description: categoryNameController.text,
                            photo: 'Need to Send Image',
                          ),
                        );
                    categoryNameController.clear();
                    categoryDescriptionController.clear();
                  }
                },
                child: const Text('Add Category'),
              ),
              const SizedBox(height: 10),
              BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const CircularProgressIndicator();
                  }
                  if (state.error != null) {
                    return Center(child: Text('Error: ${state.error}'));
                  }
                  if (state.categories.isEmpty) {
                    return const Center(child: Text('No Categories Added Yet'));
                  }
                  return Expanded(
                    child: ListView.builder(
                      itemCount: state.categories.length,
                      itemBuilder: (context, index) {
                        final category = state.categories[index];

                        return ListTile(
                          title: Text(category.name),
                          subtitle: Text(category.description ?? ''),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon:
                                    const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () {
                                  categoryNameController.text = category.name;
                                  categoryDescriptionController.text =
                                      category.description ?? '';

                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text("Edit Category"),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            TextFormField(
                                              controller:
                                                  categoryNameController,
                                              decoration: const InputDecoration(
                                                  labelText: "Category Name"),
                                            ),
                                            const SizedBox(height: 10),
                                            TextFormField(
                                              controller:
                                                  categoryDescriptionController,
                                              decoration: const InputDecoration(
                                                  labelText:
                                                      "Category Description"),
                                            ),
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text("Cancel"),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              context.read<CategoryBloc>().add(
                                                    UpdateCategory(
                                                      id: category.id!,
                                                      name:
                                                          categoryNameController
                                                              .text,
                                                      description:
                                                          categoryDescriptionController
                                                              .text,
                                                      photo: category.photo,
                                                    ),
                                                  );
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Save"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                              IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  context.read<CategoryBloc>().add(
                                        DeleteCategory(id: category.id ?? ''),
                                      );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
