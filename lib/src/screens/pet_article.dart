import 'package:flutter/material.dart';

class PetArticle extends StatelessWidget {
  final String title;
  final List<String> bulletPoints;
  final String imagePath;

  const PetArticle({
    Key? key,
    required this.title,
    required this.bulletPoints,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: [
          Image.asset(imagePath),
          Expanded(
            child: ListView.builder(
              itemCount: bulletPoints.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.pets),
                  title: Text(bulletPoints[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
