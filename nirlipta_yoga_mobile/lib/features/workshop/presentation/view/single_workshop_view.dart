import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view_model/single_workshop_bloc.dart';
import '../view_model/single_workshop_event.dart';
import '../view_model/single_workshop_state.dart';

class SingleWorkshopView extends StatelessWidget {
  final String workshopId;

  const SingleWorkshopView({super.key, required this.workshopId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SingleWorkshopBloc()..add(LoadSingleWorkshop(workshopId)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Workshop Details"),
        ),
        body: BlocBuilder<SingleWorkshopBloc, SingleWorkshopState>(
          builder: (context, state) {
            if (state is SingleWorkshopLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SingleWorkshopLoaded) {
              var workshop = state.workshop;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Workshop Image
                    if (workshop["photo"] != null)
                      Image.network(
                        workshop["photo"],
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: double.infinity,
                          height: 200,
                          color: Colors.grey[300],
                          child: const Icon(Icons.image,
                              size: 50, color: Colors.grey),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            workshop["title"],
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            workshop["category"],
                            style: const TextStyle(
                                fontSize: 16, color: Colors.grey),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Instructor: ${workshop["instructor"]}",
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Duration: ${workshop["duration"]}",
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Schedule: ${workshop["schedule"]}",
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            workshop["description"],
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "AU\$ ${workshop["price"]}",
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                          const SizedBox(height: 16),
                          if (workshop["isPremium"])
                            Chip(
                              label: const Text("Premium",
                                  style: TextStyle(color: Colors.white)),
                              backgroundColor: Colors.orange,
                            ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Workshop booked!")),
                              );
                            },
                            child: const Text("Book Now"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is SingleWorkshopError) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text("Something went wrong"));
            }
          },
        ),
      ),
    );
  }
}
