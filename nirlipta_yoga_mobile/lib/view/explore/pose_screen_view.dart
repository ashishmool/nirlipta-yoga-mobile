import 'package:flutter/material.dart';
import 'package:nirlipta_yoga_mobile/models/pose.dart';

class ExploreYogaSection extends StatelessWidget {
  final List<Pose> poses = [
    Pose(
      imageUrl:
          'https://www.peerspace.com/resources/wp-content/uploads/yoga-2959226_1280.jpg',
      title: 'Downward Dog',
      description:
          'A yoga pose that helps stretch the body and strengthen muscles.',
    ),
    Pose(
      imageUrl:
          'https://www.peerspace.com/resources/wp-content/uploads/yoga-2959226_1280.jpg',
      title: 'Child’s Pose',
      description:
          'A resting pose that helps stretch the back and relax the body.',
    ),
    Pose(
      imageUrl:
          'https://www.peerspace.com/resources/wp-content/uploads/yoga-2959226_1280.jpg',
      title: 'Tree Pose',
      description:
          'A balancing pose that improves concentration and stability, strengthening the legs and opening the hips.',
    ),
    Pose(
      imageUrl:
          'https://www.peerspace.com/resources/wp-content/uploads/yoga-2959226_1280.jpg',
      title: 'Warrior I',
      description:
          'A powerful standing pose that strengthens the legs, opens the hips, and stretches the chest.',
    ),
    Pose(
      imageUrl:
          'https://www.peerspace.com/resources/wp-content/uploads/yoga-2959226_1280.jpg',
      title: 'Warrior II',
      description:
          'A continuation of Warrior I, improving balance, strength, and focus, while stretching the chest and legs.',
    ),
    Pose(
      imageUrl:
          'https://www.peerspace.com/resources/wp-content/uploads/yoga-2959226_1280.jpg',
      title: 'Cobra Pose',
      description:
          'A backbend that strengthens the spine, opens the chest, and stretches the abdomen.',
    ),
    Pose(
      imageUrl:
          'https://www.peerspace.com/resources/wp-content/uploads/yoga-2959226_1280.jpg',
      title: 'Lotus Pose',
      description:
          'A seated meditation pose that calms the mind and improves posture, promoting spiritual awakening.',
    ),
    Pose(
      imageUrl:
          'https://www.peerspace.com/resources/wp-content/uploads/yoga-2959226_1280.jpg',
      title: 'Bridge Pose',
      description:
          'A backbend pose that stretches the chest, spine, and hips, strengthening the legs and lower back.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SizedBox(
        height: 160,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: poses.length,
          itemBuilder: (context, index) {
            final pose = poses[index];
            return GestureDetector(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.only(right: 12),
                width: 160, // Width of each card
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: NetworkImage(pose.imageUrl),
                    // Use the pose's image URL
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      color: Color(0xFF9B6763).withOpacity(0.8),
                      child: Center(
                        child: Text(
                          pose.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
