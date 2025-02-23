import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../workshop/presentation/view/single_workshop_view.dart';
import '../../../../workshop/presentation/view/workshop_card_view.dart';
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
      create: (context) => DashboardBloc()..add(LoadDashboardData()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Yoga Workshops',
              style: TextStyle(fontWeight: FontWeight.bold)),
          actions: [
            IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: () {
                Fluttertoast.showToast(msg: "Search clicked");
              },
            ),
            IconButton(
              icon: const Icon(Icons.grid_view, color: Colors.white),
              onPressed: () {
                Fluttertoast.showToast(msg: "Grid view clicked");
              },
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
                  // Category Filters
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
                  // Workshop Grid
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.all(8),
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

                        return GestureDetector(
                          onTap: () {
                            // Access the correct workshopId
                            print(
                                "Workshop ID: ${workshop["workshopId"]}"); // Print the workshopId for debugging

                            // Navigate to SingleWorkshopView with the correct workshopId
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SingleWorkshopView(
                                  workshopId: workshop[
                                      "workshopId"], // Pass the workshopId here
                                ),
                              ),
                            );
                          },
                          child: WorkshopCard(
                            title: workshop["title"],
                            category: workshop["category"],
                            price: workshop["price"],
                            photo: workshop["photo"],
                            description: workshop["description"],
                            discountPrice: workshop["discount_price"],
                            onTap: () {
                              print("Workshop ID: ${workshop["workshopId"]}");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SingleWorkshopView(
                                    workshopId: workshop["workshopId"],
                                  ),
                                ),
                              );
                            },
                          ),
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
