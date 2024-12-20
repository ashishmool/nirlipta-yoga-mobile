import 'package:flutter/material.dart';
import 'package:nirlipta_yoga_mobile/models/pose.dart';

class PoseSection extends StatefulWidget {
  const PoseSection({super.key});

  @override
  State<PoseSection> createState() => _ExploreYogaSectionState();
}

class _ExploreYogaSectionState extends State<PoseSection> {
  final List<Pose> poses = [
    Pose(
      imageUrl:
          'https://cdn.yogajournal.com/wp-content/uploads/2021/11/Downward-Facing-Dog-Pose_Andrew-Clark_2400x1350.jpeg',
      title: 'Downward Dog',
      description:
          'A yoga pose that helps stretch the body and strengthen muscles.',
    ),
    Pose(
      imageUrl:
          'https://www.theyogacollective.com/wp-content/uploads/2019/10/4143473057707883372_IMG_8546-2-1200x800.jpg',
      title: 'Child’s Pose',
      description:
          'A resting pose that helps stretch the back and relax the body.',
    ),
    Pose(
      imageUrl:
          'https://cdn.prod.website-files.com/61384703bca2db472ca04cfa/65166404fa404f0e059fa402_HowToDoTreePose.jpg',
      title: 'Tree Pose',
      description:
          'A balancing pose that improves concentration and stability, strengthening the legs and opening the hips.',
    ),
    Pose(
      imageUrl:
          'https://www.theyogacollective.com/wp-content/uploads/2019/10/Warrior-1-for-Pose-Page-e1572145174937.jpeg',
      title: 'Warrior I',
      description:
          'A powerful standing pose that strengthens the legs, opens the hips, and stretches the chest.',
    ),
    Pose(
      imageUrl:
          'https://liforme.com/cdn/shop/articles/warrior-2-blog-2_1024x.webp?v=1711715812',
      title: 'Warrior II',
      description:
          'A continuation of Warrior I, improving balance, strength, and focus, while stretching the chest and legs.',
    ),
  ];

  List<Pose> filteredPoses = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredPoses = poses; // Initial: Show All Poses
  }

  void _filterPoses(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredPoses = poses;
      } else {
        filteredPoses = poses
            .where((pose) =>
                pose.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: _filterPoses,
                decoration: InputDecoration(
                  hintText: 'Search Yoga Poses...',
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Yoga Pose List
            Expanded(
              child: filteredPoses.isEmpty
                  ? const Center(
                      child: Text(
                        'No poses found',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: filteredPoses.length,
                      itemBuilder: (context, index) {
                        final pose = filteredPoses[index];
                        return GestureDetector(
                          onTap: () {},
                          child: Container(
                            margin: const EdgeInsets.only(right: 12),
                            width: 160, // Width of each card
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: NetworkImage(pose.imageUrl),
                                fit: BoxFit.cover,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 4,
                                  offset: const Offset(2, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                // Empty Space for Title in Botoom
                                Expanded(
                                  child: Container(),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  width: double.infinity, // Full width
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF9B6763)
                                        .withOpacity(0.8),
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(15),
                                      bottomRight: Radius.circular(15),
                                    ),
                                  ),
                                  child: Text(
                                    pose.title,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
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
          ],
        ),
      ),
    );
  }
}
