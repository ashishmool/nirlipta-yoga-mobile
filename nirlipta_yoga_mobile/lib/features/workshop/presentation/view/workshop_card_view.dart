import 'package:flutter/material.dart';
import 'package:nirlipta_yoga_mobile/core/theme/app_theme.dart';

class WorkshopCardView extends StatelessWidget {
  final List<dynamic> workshops;
  final Function(String) onTap;

  const WorkshopCardView(
      {super.key, required this.workshops, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.65,
        ),
        itemCount: workshops.length,
        itemBuilder: (context, index) {
          final workshop = workshops[index];
          print(workshop);
          final difficultyLevel = workshop["difficultyLevel"] ?? "beginner";
          final difficultyColor = _getDifficultyColor(difficultyLevel);
          final description = workshop["description"] ?? "No description";
          final excerpt = description.length > 50
              ? "${description.substring(0, 50)}..."
              : description;

          return GestureDetector(
            onTap: () => onTap(workshop["workshopId"]),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Workshop Image with Badge
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12)),
                        child: Image.network(
                          workshop["photo"],
                          height: 140,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: primaryColor.withValues(alpha: 0.9),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8),
                              ),
                            ),
                            child: Text(
                              workshop["category"],
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Workshop Title
                        Text(
                          workshop["title"],
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),

                        // Description Excerpt
                        Text(
                          excerpt,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),

                        // Difficulty Level with Icon
                        Row(
                          children: [
                            Icon(
                              Icons.emoji_events,
                              color: difficultyColor,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              difficultyLevel,
                              style: TextStyle(
                                fontSize: 14,
                                color: difficultyColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),

                        // Price and Discount
                        Row(
                          children: [
                            if (workshop["discountPrice"] != null &&
                                workshop["discountPrice"] > 0 &&
                                workshop["discountPrice"] <
                                    workshop["price"]) ...[
                              Text(
                                "\$${workshop["price"]}",
                                style: const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 14,
                                  color: secondaryColor,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                "\$${workshop["discountPrice"]}",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ] else ...[
                              Text(
                                "\$${workshop["price"] ?? 'N/A'}",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Helper function to get difficulty color
  Color _getDifficultyColor(String difficultyLevel) {
    switch (difficultyLevel.toLowerCase()) {
      case 'beginner':
        return Colors.green;
      case 'intermediate':
        return Colors.orange;
      case 'advanced':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
