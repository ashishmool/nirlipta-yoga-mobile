import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../app/di/di.dart';
import '../bottom_view_model/dashboard_bloc.dart';
import '../bottom_view_model/dashboard_event.dart';
import '../bottom_view_model/dashboard_state.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final List<String> _selectedCategories = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DashboardBloc>()..add(LoadDashboardData()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Yoga Workshops',
              style: TextStyle(fontWeight: FontWeight.bold)),
          actions: [
            IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.grid_view, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
        body: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            if (state is DashboardLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is DashboardLoaded) {
              return Column(
                children: [
                  // Category Filter Checkboxes
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Wrap(
                      spacing: 10,
                      children: state.categories.map((category) {
                        return FilterChip(
                          label: Text(category),
                          selected: _selectedCategories.contains(category),
                          onSelected: (bool selected) {
                            setState(() {
                              if (selected) {
                                _selectedCategories.add(category);
                              } else {
                                _selectedCategories.remove(category);
                              }
                            });
                            context.read<DashboardBloc>().add(FilterWorkshops(
                                List.from(_selectedCategories)));
                          },
                        );
                      }).toList(),
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
                          isPremium: workshop["isPremium"] ?? false,
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
  final bool isPremium;

  const _WorkshopCard({
    required this.title,
    required this.category,
    required this.price,
    this.photo,
    this.isPremium = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                    Text(
                      "AU\$ $price",
                      style: const TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
