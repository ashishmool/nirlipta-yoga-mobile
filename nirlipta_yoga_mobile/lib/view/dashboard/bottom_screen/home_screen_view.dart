import 'package:flutter/material.dart';
import 'package:nirlipta_yoga_mobile/models/category.dart';
import 'package:nirlipta_yoga_mobile/models/workshop.dart';
import 'package:nirlipta_yoga_mobile/view/workshop/workshop_screen_view.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  // Test Data
  final List<Category> categories = [
    Category(id: '1', name: 'Asanas'),
    Category(id: '2', name: 'Physical Well-Being'),
    Category(id: '3', name: 'Beginner Yoga'),
  ];

  final List<Workshop> workshops = [
    Workshop(
      id: '101',
      title: 'Morning Yoga Flow',
      categoryId: '1',
      duration: '30 mins',
      price: 500,
      discountPrice: 399,
      imageUrl:
          'https://www.peerspace.com/resources/wp-content/uploads/yoga-2959226_1280.jpg',
    ),
    Workshop(
      id: '102',
      title: 'Core Strengthening Yoga',
      categoryId: '2',
      duration: '45 mins',
      price: 700,
      imageUrl:
          'https://www.peerspace.com/resources/wp-content/uploads/yoga-2959226_1280.jpg',
    ),
    Workshop(
      id: '103',
      title: 'Beginner Yoga Essentials',
      categoryId: '3',
      duration: '20 mins',
      price: 300,
      discountPrice: 199,
      imageUrl:
          'https://www.peerspace.com/resources/wp-content/uploads/yoga-2959226_1280.jpg',
    ),
  ];

  String? selectedCategoryId;

  @override
  Widget build(BuildContext context) {
    List<Workshop> filteredWorkshops = selectedCategoryId == null
        ? workshops
        : workshops
            .where((workshop) => workshop.categoryId == selectedCategoryId)
            .toList();

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Workshops',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return _buildCategoryItem(
                    'All',
                    null,
                    selectedCategoryId == null,
                  );
                }
                final category = categories[index - 1];
                return _buildCategoryItem(
                  category.name,
                  category.id,
                  selectedCategoryId == category.id,
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          WorkshopScreenView(workshops: filteredWorkshops),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(String name, String? id, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategoryId = id;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF9B6763) : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            name,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
