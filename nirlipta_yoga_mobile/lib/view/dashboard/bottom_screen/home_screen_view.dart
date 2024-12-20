import 'package:flutter/material.dart';
import 'package:nirlipta_yoga_mobile/models/category.dart';
import 'package:nirlipta_yoga_mobile/models/retreat.dart';
import 'package:nirlipta_yoga_mobile/models/user.dart';
import 'package:nirlipta_yoga_mobile/models/workshop.dart';
import 'package:nirlipta_yoga_mobile/view/dashboard/home_screen/header/header_user_screen_view.dart';
import 'package:nirlipta_yoga_mobile/view/dashboard/home_screen/pose/pose_screen_view.dart';
import 'package:nirlipta_yoga_mobile/view/dashboard/home_screen/retreat/retreat_screen_view.dart';
import 'package:nirlipta_yoga_mobile/view/dashboard/home_screen/workshop/workshop_screen_view.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  final User currentUser = User(
    userId: '001',
    name: 'Ashish Mool',
    email: 'something@gmail.com',
    profilePicture:
        'https://img.freepik.com/premium-photo/serene-5yearold-nepali-boy-with-composed-look_1308-151628.jpg',
    role: 'Student',
    age: 16,
    gender: 'Male',
    medicalConditions: ['Back Pain', 'Stress'],
    stepsToday: 2330,
  );

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
          'https://theyogahub.ie/wp-content/uploads/2017/11/Yoga-shutterstock_126464135.jpg',
    ),
    Workshop(
      id: '102',
      title: 'Core Strengthening Yoga',
      categoryId: '2',
      duration: '45 mins',
      price: 700,
      imageUrl:
          'https://kumarahyoga.com/wp-content/uploads/2018/03/AdobeStock_142783316-min-1080x720-1024x683.jpeg',
    ),
    Workshop(
      id: '103',
      title: 'Beginner Yoga Essentials',
      categoryId: '3',
      duration: '20 mins',
      price: 300,
      discountPrice: 199,
      imageUrl:
          'https://bauerfeind.com.au/cdn/shop/articles/bauerfeind-campaign-yoga-lumbotrain-lady_A7307091-eRGB2.tifLumboTrainLumboTrain_1200x.jpg',
    ),
  ];

  final List<Retreat> retreats = [
    Retreat(
      id: '201',
      title: 'Serenity Yoga Retreat',
      description: 'Find your inner peace in this tranquil retreat.',
      startDate: DateTime(2024, 12, 20),
      endDate: DateTime(2024, 12, 23),
      pricePerPerson: 675.00,
      maxParticipants: 20,
      organizer: 'Nirliptah Yoga',
      photos: [
        'https://susannerieker.com/wp-content/uploads/2018/07/thailand-yoga-retreats.jpg',
      ],
    ),
    Retreat(
      id: '202',
      title: 'Peaceful Meditation Escape',
      description: 'A perfect getaway for relaxation and mindfulness.',
      startDate: DateTime(2024, 11, 10),
      endDate: DateTime(2024, 11, 13),
      pricePerPerson: 750.00,
      maxParticipants: 15,
      organizer: 'Nirliptah Yoga',
      photos: [
        'https://tripjive.com/wp-content/uploads/2024/10/yoga-retreats-Pokhara-1-1024x585.jpg',
      ],
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),

          // Header Section
          SizedBox(
              height: 100,
              child: HeaderUserScreenView(
                  userName: currentUser.name,
                  userRole: currentUser.role,
                  userProfilePicture: currentUser.profilePicture,
                  stepsToday: currentUser.stepsToday)),

          // Explore Section
          SizedBox(
            height: 250,
            child: PoseSection(),
          ),
          const SizedBox(height: 20),

          // Workshops Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: const Text(
              'Workshops',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
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
          const SizedBox(height: 20),

          // Retreats Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
              'Retreats',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 8),
          SizedBox(
            height: 350,
            child: RetreatScreenView(retreats: retreats),
          ),
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
