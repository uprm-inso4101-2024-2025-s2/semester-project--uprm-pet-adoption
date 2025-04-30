import 'package:flutter/material.dart';

class SuccessStoryCard extends StatelessWidget {
  final String petName;
  final String story;
  final ImageProvider image; // Changed from String url to ImageProvider
  final int likes;
  final int comments;
  final VoidCallback? onLike;
  final VoidCallback? onComment;
  final VoidCallback? onShare;

  const SuccessStoryCard({
    Key? key,
    required this.petName,
    required this.story,
    required this.image, // Now accepts ImageProvider
    this.likes = 0,
    this.comments = 0,
    this.onLike,
    this.onComment,
    this.onShare,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      color: Color(0xFFFFF581),
      shadowColor: Color(0xFFFFF581),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Pet Image with overlay
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image(
                  image: image, // Using the ImageProvider here
                  width: double.infinity,
                  height: 220,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 10,
                left: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    petName.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Archivo',
                      letterSpacing: 1.1,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Story Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Story Text
                Text(
                  story,
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Archivo',
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                // Interaction Row
                Row(
                  children: [
                    // Like Button
                    _buildInteractionButton(
                      icon: Icons.favorite_border,
                      activeIcon: Icons.favorite,
                      label: likes.toString(),
                      onPressed: onLike,
                    ),
                    const SizedBox(width: 16),
                    // Comment Button
                    _buildInteractionButton(
                      icon: Icons.comment_outlined,
                      label: comments.toString(),
                      onPressed: onComment,
                    ),
                    const Spacer(),
                    // Share Button
                    IconButton(
                      icon: const Icon(Icons.share_outlined),
                      color: Colors.grey[700],
                      onPressed: onShare,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInteractionButton({
    required IconData icon,
    IconData? activeIcon,
    required String label,
    VoidCallback? onPressed,
  }) {
    return TextButton.icon(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: Colors.grey[700],
      ),
      icon: Icon(icon, size: 20),
      label: Text(
        label,
        style: const TextStyle(
          fontFamily: 'Archivo',
          fontSize: 14,
        ),
      ),
    );
  }
}