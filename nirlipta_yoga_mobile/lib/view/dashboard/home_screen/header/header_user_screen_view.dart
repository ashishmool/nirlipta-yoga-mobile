import 'package:flutter/material.dart';

class HeaderUserScreenView extends StatelessWidget {
  final String userName;
  final String userRole;
  final String userProfilePicture;
  final int stepsToday;

  const HeaderUserScreenView({
    super.key,
    required this.userName,
    required this.userRole,
    required this.userProfilePicture,
    required this.stepsToday,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Welcome Message with Footsteps Count
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.directions_walk, // Footsteps Icon
                      size: 20,
                      color: Colors.black87,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '$stepsToday steps', // Display steps count
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // User Info and Profile Picture
            Row(
              children: [
                // User Info (Name and Role)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      userName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      userRole,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                // Profile Picture
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(userProfilePicture),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
