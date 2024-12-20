import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nirlipta_yoga_mobile/models/retreat.dart';

class RetreatScreenView extends StatelessWidget {
  final List<Retreat> retreats;

  const RetreatScreenView({super.key, required this.retreats});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: retreats.length,
      itemBuilder: (context, index) {
        final retreat = retreats[index];
        final durationText =
            _calculateDuration(retreat.startDate, retreat.endDate);
        final dateRangeText =
            'From: ${_formatDate(retreat.startDate)} to ${_formatDate(retreat.endDate)}';

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Retreat Image part
            Expanded(
              child: Stack(
                children: [
                  Image.network(
                    retreat.photos?.isNotEmpty == true
                        ? retreat.photos!.first
                        : 'https://tripjive.com/wp-content/uploads/2024/10/yoga-retreats-Pokhara-1-1024x585.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.broken_image,
                          size: 100, color: Colors.grey);
                    },
                  ),
                  // duration of Retreat display
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        durationText,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  // Date Range show
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        dateRangeText,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Price and seats remaining
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _infoColumn('Price',
                      'AU\$ ${retreat.pricePerPerson.toStringAsFixed(2)}'),
                  _infoColumn('Single Room', 'Available'),
                  _infoColumn('Seats Left', '${retreat.maxParticipants ?? 0}'),
                ],
              ),
            ),
            SizedBox(height: 16),
          ],
        );
      },
    );
  }

  // Helper date formating
  String _formatDate(DateTime date) {
    return DateFormat('dd.MM.yyyy').format(date);
  }

  // Helper calculate duration
  String _calculateDuration(DateTime startDate, DateTime endDate) {
    final difference = endDate.difference(startDate);
    final nights = difference.inDays;
    final days = nights + 1;
    return '$nights Nights / $days Days';
  }

  // info columns
  Widget _infoColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.grey),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
