import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../app/di/di.dart';
import '../bottom_view_model/dashboard_bloc.dart';
import '../bottom_view_model/dashboard_event.dart';
import '../bottom_view_model/dashboard_state.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DashboardBloc>()..add(LoadDashboardData()),
      child: Scaffold(
        body: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            if (state is DashboardLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is DashboardLoaded) {
              return Column(
                children: [
                  // Category Filter
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: DropdownButton<String>(
                            hint: const Text("Filter by category"),
                            value: null,
                            items: state.categories
                                .map((category) => DropdownMenuItem(
                                      value: category,
                                      child: Text(category),
                                    ))
                                .toList(),
                            onChanged: (category) {
                              if (category != null) {
                                context
                                    .read<DashboardBloc>()
                                    .add(FilterWorkshops(category));
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: state.workshops.length,
                      itemBuilder: (context, index) {
                        var workshop = state.workshops[index];
                        return _WorkshopCard(
                          photo: workshop["photo"],
                          title: workshop["title"],
                          category: workshop["category"],
                          price: (workshop["price"] as num).toDouble(),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else if (state is DashboardError) {
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

class _WorkshopCard extends StatelessWidget {
  final String title;
  final String category;
  final String? photo;
  final double price;

  const _WorkshopCard({
    required this.title,
    required this.category,
    required this.price,
    this.photo,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none, // Allows the button to overflow outside
      children: [
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Photo
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: photo != null
                    ? Image.network(
                        photo!,
                        width: double.infinity,
                        height: 120,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        width: double.infinity,
                        height: 120,
                        color: Colors.grey[300],
                        child: const Icon(Icons.image,
                            size: 50, color: Colors.grey),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 5),
                    Text(category, style: const TextStyle(color: Colors.grey)),
                    const SizedBox(height: 5),
                    Text("AU\$ $price",
                        style: const TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 40), // Space for button to overlap
                  ],
                ),
              ),
            ],
          ),
        ),
        // Badge (Top Center)
        Positioned(
          top: 10,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            alignment: Alignment.center,
            child: const Text(
              "Featured",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        // Floating Button (Half inside, half outside)
        Positioned(
          bottom: -20, // Moves half of the button outside
          left: 20,
          right: 20,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            onPressed: () {},
            child: const Text("View Details"),
          ),
        ),
      ],
    );
  }
}
