import 'package:flutter/material.dart';
import 'package:nirlipta_yoga_mobile/models/workshop.dart';

class WorkshopScreenView extends StatelessWidget {
  final List<Workshop> workshops;

  const WorkshopScreenView({super.key, required this.workshops});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: workshops.map((workshop) {
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            leading: Image.network(workshop.imageUrl, width: 60, height: 60),
            title: Text(workshop.title),
            subtitle: Text(
              'Duration: ${workshop.duration}\nPrice: ${workshop.discountPrice ?? workshop.price}',
            ),
          ),
        );
      }).toList(),
    );
  }
}
