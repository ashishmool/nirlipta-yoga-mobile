import 'package:flutter/material.dart';
import 'package:nirlipta_yoga_mobile/models/retreat.dart';
import 'package:nirlipta_yoga_mobile/models/workshop.dart';

class EnrollmentScreenView extends StatelessWidget {
  const EnrollmentScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy enrollment data
    final List<WorkshopEnrollment> workshopEnrollments = [
      WorkshopEnrollment(
        workshop: Workshop(
          id: '101',
          title: 'Morning Yoga Flow',
          categoryId: '1',
          duration: '30 mins',
          price: 500,
          discountPrice: 399,
          imageUrl:
              'https://theyogahub.ie/wp-content/uploads/2017/11/Yoga-shutterstock_126464135.jpg',
        ),
        enrollmentDate: DateTime(2024, 12, 1),
      ),
      WorkshopEnrollment(
        workshop: Workshop(
          id: '102',
          title: 'Core Strengthening Yoga',
          categoryId: '2',
          duration: '45 mins',
          price: 700,
          imageUrl:
              'https://kumarahyoga.com/wp-content/uploads/2018/03/AdobeStock_142783316-min-1080x720-1024x683.jpeg',
        ),
        enrollmentDate: DateTime(2024, 12, 5),
      ),
    ];

    final List<RetreatEnrollment> retreatEnrollments = [
      RetreatEnrollment(
        retreat: Retreat(
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
        enrollmentDate: DateTime(2024, 11, 15),
      ),
    ];

    // Sort enrollments by enrollment date
    workshopEnrollments
        .sort((a, b) => b.enrollmentDate.compareTo(a.enrollmentDate));
    retreatEnrollments
        .sort((a, b) => b.enrollmentDate.compareTo(a.enrollmentDate));

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Workshops',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: workshopEnrollments.length,
              itemBuilder: (context, index) {
                final enrollment = workshopEnrollments[index];
                return _buildEnrollmentItem(enrollment.workshop.title,
                    enrollment.workshop.imageUrl, enrollment.enrollmentDate);
              },
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Retreats',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: retreatEnrollments.length,
              itemBuilder: (context, index) {
                final enrollment = retreatEnrollments[index];
                return _buildEnrollmentItem(
                    enrollment.retreat.title,
                    enrollment.retreat.photos!.first,
                    enrollment.enrollmentDate);
              },
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build individual enrollment items
  Widget _buildEnrollmentItem(
      String title, String imageUrl, DateTime enrollmentDate) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading:
            Image.network(imageUrl, width: 60, height: 60, fit: BoxFit.cover),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Enrolled on: ${enrollmentDate.toLocal().toString().split(' ')[0]}',
          style: const TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}

// Dummy data models for enrollments
class WorkshopEnrollment {
  final Workshop workshop;
  final DateTime enrollmentDate;

  WorkshopEnrollment({required this.workshop, required this.enrollmentDate});
}

class RetreatEnrollment {
  final Retreat retreat;
  final DateTime enrollmentDate;

  RetreatEnrollment({required this.retreat, required this.enrollmentDate});
}
