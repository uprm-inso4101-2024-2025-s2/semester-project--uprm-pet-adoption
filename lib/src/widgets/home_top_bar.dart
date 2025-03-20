
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semester_project__uprm_pet_adoption/src/widgets/pet_card.dart';
import 'package:semester_project__uprm_pet_adoption/src/providers/auth_provider.dart';
import 'package:semester_project__uprm_pet_adoption/src/widgets.dart';

//This file contains the Home Screen class. Everything that shows up in the home screen is managed here.

class TopNavBar extends StatelessWidget {
  /// The current index of the selected tab.
  final int selectedIndex;

  const TopNavBar({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 0,top: 0), // Extra top padding for status bar
      width:150,
      height: 150,
      
      decoration: 
        const BoxDecoration(
          color: Color.fromRGBO(130, 176, 255, 1),
          

      ),
      child: Padding(
        padding: EdgeInsets.zero,
        child:Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children:[ 
            Row(
            mainAxisAlignment: MainAxisAlignment.start,
            
            children: [
              // This makes the image bigger and ensures it doesn't get constrained
              SizedBox(
                width: 200,
                height: 100, // final visible area
                child: Stack(
                  children: [
                    Positioned(
                      top: -25, // hide top 50px
                      left: 0,
                      child: Image.asset(
                        "assets/images/sign_log.png",
                        width: 200,
                        height: 150, // taller than visible area
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 0,height: 0),
              Expanded(
                child: Row(

                  mainAxisAlignment: MainAxisAlignment.start,
                  
                  children: [
                    _buildNavItem(context, Icons.search, 0, "/search"),
                    _buildNavItem(context, Icons.lightbulb, 1, "/tips"),
                    _buildNavItem(context, Icons.favorite_border, 2, "/favorites"),
                    _buildNavItem(context, Icons.list, 3, "/menu"),
                  ],
                ),
                
            ),

          ],
        ),
          ]
      ),
    )
    );
  }

  /// Helper function to build navigation icons.
  Widget _buildNavItem(BuildContext context, IconData icon, int index, String route) {
    final isSelected = selectedIndex == index;

    return IconButton(
      icon: Icon(
        icon,
        size: 28,
        color: isSelected ? Colors.yellow : Colors.yellow[200],
      ),
      onPressed: () {
        if (GoRouterState.of(context).uri.toString() != route) {
          context.go(route); // Navigate using GoRouter
        }
      },
    );
  }
}
