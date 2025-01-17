import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view_model/workshop_bloc.dart';

class WorkshopView extends StatelessWidget {
  WorkshopView({super.key});

  final workshopTitleController = TextEditingController();
  final workshopPriceController = TextEditingController();
  final workshopDifficultyLevelController = TextEditingController();
  final workshopCategoryController = TextEditingController();
  final _workshopFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _workshopFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: workshopTitleController,
                decoration: const InputDecoration(labelText: 'Workshop Title'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a workshop title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: workshopPriceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Workshop Price'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a workshop price';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: workshopCategoryController,
                keyboardType: TextInputType.number,
                decoration:
                    const InputDecoration(labelText: 'Workshop Category'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a workshop category';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: workshopDifficultyLevelController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Difficulty'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a workshop difficulty';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (_workshopFormKey.currentState!.validate()) {
                    context.read<WorkshopBloc>().add(
                          AddWorkshop(
                            title: workshopTitleController.text,
                            price: double.parse(workshopPriceController.text),
                            difficultyLevel:
                                workshopDifficultyLevelController.text,
                            categoryId: workshopCategoryController.text,
                          ),
                        );
                    workshopTitleController.clear();
                    workshopPriceController.clear();
                    workshopDifficultyLevelController.clear();
                    workshopCategoryController.clear();
                  }
                },
                child: const Text('Add Workshop'),
              ),
              const SizedBox(height: 10),
              BlocBuilder<WorkshopBloc, WorkshopState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const CircularProgressIndicator();
                  }
                  if (state.error != null) {
                    return Center(child: Text('Error: ${state.error}'));
                  }
                  if (state.workshops.isEmpty) {
                    return const Center(child: Text('No Workshops Added Yet'));
                  }
                  return Expanded(
                    child: ListView.builder(
                      itemCount: state.workshops.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(state.workshops[index].title),
                          subtitle: Text(
                              'Rs. ${state.workshops[index].price.toStringAsFixed(2)}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              context.read<WorkshopBloc>().add(
                                    DeleteWorkshop(
                                      workshopId:
                                          state.workshops[index].id ?? '',
                                    ),
                                  );
                            },
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
