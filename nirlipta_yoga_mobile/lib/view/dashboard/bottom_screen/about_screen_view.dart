import 'package:flutter/material.dart';

class AboutScreenView extends StatelessWidget {
  const AboutScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),

          // Title
          const Text(
            'Nirliptah Yoga App 🧘‍♀️📱',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF9B6763),
            ),
          ),
          const SizedBox(height: 32),

          // About Us Section
          const Text(
            'About Us 🌍',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'In a world where maintaining physical and mental well-being is increasingly essential, Nirliptah Yoga App bridges the ancient wisdom of yoga with cutting-edge mobile technology. Designed for yoga enthusiasts of all levels, the app offers a seamless experience tailored to personal goals, schedules, and expertise.',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 32),

          // Key Features
          const Text(
            'Key Features 🌟',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '1. Personalized Yoga Experience 👤.',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          const Text(
            '2. Workshops & Retreats 📚.',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          const Text(
            '3. Digital Achievements 🎓.',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          const Text(
            '4. Modern Tech Integration 🛠️.',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
