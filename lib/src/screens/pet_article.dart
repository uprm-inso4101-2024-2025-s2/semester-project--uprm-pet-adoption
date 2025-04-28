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
      backgroundColor: const Color.fromRGBO(255, 255, 240, 1), // Soft background color
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 245, 129, 1),
        title: Text(
          title,
          style: const TextStyle(
            fontFamily: 'Archivo',
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Color.fromRGBO(51, 51, 51, 1),
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            child: Image.asset(
              imagePath,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: bulletPoints.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.pets,
                        color: Color.fromRGBO(130, 176, 255, 1),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          bulletPoints[index],
                          style: const TextStyle(
                            fontFamily: 'Archivo',
                            fontSize: 16,
                            color: Color.fromRGBO(51, 51, 51, 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
