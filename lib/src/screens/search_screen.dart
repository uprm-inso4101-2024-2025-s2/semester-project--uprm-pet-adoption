import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; 
import 'package:semester_project__uprm_pet_adoption/src/widgets.dart'; // Import for navigation

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    final Color appBarColor = const Color.fromRGBO(255, 245, 121, 1.0);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/Login_SignUp_Background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            // App Bar
            AppBar(
              backgroundColor: appBarColor,
              elevation: 0,
              centerTitle: false,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => context.pop(),
              ),
              title: const Text(
                'Search',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.black,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.black12),
                ),
                child: const TextField(
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search,
                      color: Color.fromRGBO(255, 245, 121, 1),
                    ),
                    suffixIcon: Icon(
                      Icons.clear,
                      color: Colors.black45,
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Tags 
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Chip(
                      label: const Text('Tag'),
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Colors.black26),
                      deleteIcon: const Icon(
                        Icons.close,
                        size: 18,
                        color: Colors.black45,
                      ),
                      onDeleted: () {
                        print("Deleted tag ${index + 1}");
                      },
                    ),
                  );
                }),
              ),
            ),

            const SizedBox(height: 24),

            // Value Box Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    5,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text(
                              'Value',
                              style: TextStyle(fontSize: 16, color: Colors.black54),
                            ),
                          ),
                          if (index < 4)
                            const Divider(color: Color(0xFF82B0FF), thickness: 1),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Search History Title
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Center(
                child: Text(
                  'Search History',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Search History Items
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 6.0),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(30),
                          right: Radius.circular(30),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                        child: Text('Dog'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 6.0),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(30),
                          right: Radius.circular(30),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                        child: Text('Shelter'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 6.0),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(30),
                          right: Radius.circular(30),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                        child: Text('Golden Retriever'),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // // Return Button
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 24.0),
            //   child: ElevatedButton(
            //     onPressed: () => context.go('/'),
            //     child: const Text('Return to Home'),
            //   ),
            // ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(
      selectedIndex: 0),
    );
  }
}
