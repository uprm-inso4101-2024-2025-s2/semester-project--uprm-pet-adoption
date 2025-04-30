import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:semester_project__uprm_pet_adoption/src/widgets/success_story_card.dart';
import 'dart:io';

class SuccessStoriesScreen extends StatefulWidget {
  const SuccessStoriesScreen({Key? key}) : super(key: key);

  @override
  State<SuccessStoriesScreen> createState() => _SuccessStoriesScreenState();
}

class _SuccessStoriesScreenState extends State<SuccessStoriesScreen> {
  final List<Map<String, dynamic>> successStories = [
    {
      'name': 'COCO',
      'story':
          'After months in the shelter, Coco found her forever home with the Morales family. She now spends her days playing in their big backyard',
      'image': 'assets/images/training.png',
      'likes': 42,
      'comments': 8,
    },
    {
      'name': 'WHISKERS',
      'story':
          'Whisker was rescued from the streets and is now living a cozy life full of love and cuddles with me',
      'image': 'assets/images/temp_dog_img2.jpg',
      'likes': 36,
      'comments': 5,
    },
    {
      'name': 'MAX',
      'story':
          'Max found a home where adventure never ended! We take him on bikes, beach trips, and road trips across the country.',
      'image': 'assets/images/temp_dog_img.jpg',
      'likes': 58,
      'comments': 12,
    },
  ];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _storyController = TextEditingController();
  File? _image;
  bool _showAddForm = false;

  Future<void> _getImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _addStory() {
    if (_nameController.text.isNotEmpty && _storyController.text.isNotEmpty) {
      setState(() {
        successStories.insert(0, {
          'name': _nameController.text.toUpperCase(),
          'story': _storyController.text,
          'image': _image != null ? _image : 'assets/images/default_pet.png',
          'likes': 0,
          'comments': 0,
        });
        _nameController.clear();
        _storyController.clear();
        _image = null;
        _showAddForm = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Success Stories',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Archivo',
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFFFF581),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            context.go('/');
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline, color: Colors.black),
            onPressed: () {
              setState(() {
                _showAddForm = !_showAddForm;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Add Story Form (shown when _showAddForm is true)
          if (_showAddForm)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Add Success Story',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Archivo',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name of Pet',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _storyController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Story:',
                      border: OutlineInputBorder(),
                      alignLabelWithHint: true,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: _getImage,
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: _image != null
                              ? Image.file(_image!, fit: BoxFit.cover)
                              : const Icon(Icons.add_a_photo),
                        ),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: _addStory,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFF581),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          'Done!',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Archivo',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 24),
                ],
              ),
            ),
          // Stories List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ...successStories.map((story) => SuccessStoryCard(
                      petName: story['name'],
                      story: story['story'],
                      image: story['image'] is String
                          ? AssetImage(story['image'])
                          : FileImage(story['image']) as ImageProvider,
                      likes: story['likes'],
                      comments: story['comments'],
                      onLike: () {
                        setState(() {
                          story['likes']++;
                        });
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
        ],
      ),
    );
  }
}