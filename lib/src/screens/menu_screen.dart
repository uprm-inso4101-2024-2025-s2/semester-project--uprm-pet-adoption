import 'package:flutter/material.dart';
import 'package:semester_project__uprm_pet_adoption/analytics_service.dart';
import 'package:go_router/go_router.dart';

// This file contains the Menu Screen class. Everything that shows up in the menu screen is managed here.
// Instead of returning a Container with a Drawer, we do so directly as it extends Drawer.
// If you only want partial screen coverage when navigating to '/menu',
// consider changing this to a StatelessWidget and wrapping it in a Scaffold instead.

class MenuScreen extends Drawer {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AnalyticsService().logScreenView("menu_screen");  //log screen view for analytics tracking

    return Container(
      // Set the width of the drawer
      width: MediaQuery.sizeOf(context).width * 0.65, // Adjust as needed - currently at 65% of the screen width
      child: Drawer(
        backgroundColor: const Color.fromRGBO(255, 245, 129, 1),
        child: ListView(  //list of navigable menu options, each with its own icon and route
          children: [
            const SizedBox(height: 6.0),
            // Arrow, MENU, and drawer icon
            Container(
              decoration: const BoxDecoration(color: Colors.transparent),
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 40,
                  child: ListView( 
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      // Back arrow -> Goes to Home screen
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.arrow_back),
                      ),
                      const SizedBox(width: 20.0),
                      const Text(
                        'MENU',
                        style: TextStyle(
                          fontSize: 32,
                          fontFamily: 'Archivo',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 6.0),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40.0),
            // Menu items start here: each leads to a different screen
            // Box 1: Account
            Material(
              child: InkWell(
                onTap: () {
                  context.go('/profile');
                },
                child: ListTile(
                  leading: Container(
                    width: 25,
                    height: 70,
                    color: const Color.fromRGBO(198, 187, 60, 1),
                    child: const Icon(
                      Icons.person_2_rounded,
                      color: Colors.black,
                    ),
                  ),
                  tileColor: const Color.fromRGBO(244, 233, 107, 1),
                  title: const Text(
                    'Account',
                    style: TextStyle(
                      fontFamily: 'Archivo',
                    ),
                  ),
                  selected: false,
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Box 2: FAQ  
            Material(
              color: const Color.fromRGBO(244, 233, 107, 1),
              child: InkWell(
                onTap: () {
                  context.go('/faq');
                },
                child: ListTile(
                  leading: Container(
                    width: 25,
                    height: 70,
                    color: const Color.fromRGBO(198, 187, 60, 1),
                    child: const Icon(Icons.question_mark_sharp),
                  ),
                  title: const Text(
                    'FAQ',
                    style: TextStyle(fontFamily: 'Archivo'),
                  ),
                  selected: false,
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Box 3: About Us  
            Material(
              color: const Color.fromRGBO(244, 233, 107, 1),
              child: ListTile(
                leading: Container(
                  width: 25,
                  height: 70,
                  color: const Color.fromRGBO(198, 187, 60, 1),
                  child: const Icon(Icons.info_outlined),
                ),
                title: const Text(
                  'About Us',
                  style: TextStyle(
                    fontFamily: 'Archivo',
                  ),
                ),
                selected: false,
                onTap: () {
                  context.go('/about_us');
                },
              ),
            ),
            const SizedBox(height: 8),

            // Box 4: Shelters  
            Material(
              color: const Color.fromRGBO(244, 233, 107, 1),
              child: ListTile(
                leading: Container(
                  width: 25,
                  height: 70,
                  color: const Color.fromRGBO(198, 187, 60, 1),
                  child: const Icon(
                    Icons.house_sharp,
                    color: Colors.black,
                  ),
                ),
                title: const Text(
                  'Shelters',
                  style: TextStyle(
                    fontFamily: 'Archivo',
                  ),
                ),
                selected: false,
                onTap: () {
                  context.go('/shelter-info');
                },
              ),
            ),
            const SizedBox(height: 8),

            // Box 5: Success Stories Screen
            Material(
              color: const Color.fromRGBO(244, 233, 107, 1),
              child: InkWell(
                onTap: () {
                  context.go('/success-stories');
                },
                child: ListTile(
                  leading: Container(
                    width: 25,
                    height: 70,
                    color: const Color.fromRGBO(198, 187, 60, 1),
                    child: const Icon(Icons.star, color: Colors.black),
                  ),
                  title: const Text(
                    'Success Stories',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(fontFamily: 'Archivo'),
                  ),
                  selected: false,
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Box 6: Settings
            Material(
              color: const Color.fromRGBO(244, 233, 107, 1),
              child: ListTile(
                leading: Container(
                  width: 25,
                  height: 70,
                  color: const Color.fromRGBO(198, 187, 60, 1),
                  child: const Icon(Icons.settings),
                ),
                title: const Text(
                  'Settings',
                  style: TextStyle(
                    fontFamily: 'Archivo',
                  ),
                ),
                selected: false,
                onTap: () {
                  context.go('/settings');
                },
              ),
            ),
            const SizedBox(height: 8),

            // Logout icon
            SizedBox(
              width: 20,
              child: IconButton(
                alignment: Alignment.centerRight,
                iconSize: 50,
                onPressed: () {
                  context.go('/auth');
                },
                icon: const Icon(Icons.logout),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
