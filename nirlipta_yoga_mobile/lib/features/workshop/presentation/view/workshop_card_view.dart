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
          childAspectRatio: 0.75,
        ),
        itemCount: workshops.length,
        itemBuilder: (context, index) {
          var workshop = workshops[index];
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
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.network(
                      workshop["photo"],
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          workshop["title"],
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          workshop["category"],
                          style:
                              TextStyle(fontSize: 14, color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 5),
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
}
