import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:semester_project__uprm_pet_adoption/src/screens/add_success_story.dart';
import 'package:semester_project__uprm_pet_adoption/src/widgets/success_story_card.dart'; 

class SuccessStoriesScreen extends StatelessWidget {
  const SuccessStoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample data for success stories
    final List<Map<String, dynamic>> successStories = [
      {
        'name': 'COCO',
        'story': 'After months in the shelter, Coco found her forever home with the Morales family through Pawfect Match. She now spends her days playing in their big backyard.',
        'image': 'assets/images/training.png',
        'likes': 42,
        'comments': 8,
      },
      {
        'name': 'WHISKERS',
        'story': 'Whisker was rescued from the streets and found his perfect family via Pawfect Match. He\'s now living a cozy life full of love and cuddles.',
        'image': 'assets/images/temp_dog_img2.jpg',
        'likes': 36,
        'comments': 5,
      },
      {
        'name': 'MAX',
        'story': 'Max found his adventure-loving family through Pawfect Match! They take him on bikes, beach trips, and road trips across the country.',
        'image': 'assets/images/temp_dog_img.jpg',
        'likes': 58,
        'comments': 12,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Success Stories',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Archivo',
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFFFF581),
                ),
                child: const Icon(
                  Icons.add_circle_outline,
                  color: Colors.black,
                  size: 30,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddStoryScreen(),
                  ),
                );
              },
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFFFF581),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            context.go('/');
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Success Stories',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Archivo',
              ),
            ),
            const SizedBox(height: 20),
            ...successStories.map((story) => SuccessStoryCard(
                  petName: story['name'],
                  story: story['story'],
                  image: AssetImage(story['image']),
                  likes: story['likes'],
                  comments: story['comments'],
                  onLike: () {
                    // Handle like action
                  },
                  onComment: () {
                    // Handle comment action
                  },
                  onShare: () {
                    // Handle share action
                  },
                )),
          ],
        ),
      ),
    );
  }
}