import 'package:flutter/material.dart';

// Primary and Secondary Colour for Branding
const Color primaryColor = Color(0xFF9B6763);
const Color secondaryColor = Color(0xFFB8978C);

class WorkshopCard extends StatelessWidget {
  final String title;
  final String category;
  final String? photo;
  final String? description;
  final double price;
  final double? discountPrice;
  final VoidCallback onTap;

  const WorkshopCard({
    Key? key,
    required this.title,
    required this.category,
    required this.price,
    this.discountPrice,
    this.photo,
    this.description,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
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
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            width: double.infinity,
                            height: 120,
                            color: Colors.grey[300],
                            child: const Icon(
                              Icons.image,
                              size: 50,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      : Container(
                          width: double.infinity,
                          height: 120,
                          color: Colors.grey[300],
                          child: const Icon(
                            Icons.image,
                            size: 50,
                            color: Colors.grey,
                          ),
                        ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      width: 100, // 🔥 Half the width of the card
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: const BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          category,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
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
                  Text(title,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Text(
                    description != null
                        ? (description!.length > 25
                            ? "${description!.substring(0, 25)}..."
                            : description!)
                        : "", // ✅ Truncate description
                    style: const TextStyle(color: Colors.grey),
                    overflow:
                        TextOverflow.ellipsis, // ✅ Prevent overflow issues
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "\$ ${discountPrice ?? price}",
                    style: TextStyle(
                      color:
                          discountPrice != null ? Colors.green : primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      decoration: discountPrice != null
                          ? TextDecoration
                              .lineThrough // Strike-through if discount exists
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
