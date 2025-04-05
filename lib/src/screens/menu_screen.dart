import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// This file contains the Menu Screen class. Everything that shows up in the menu screen is managed here.
// Instead of returning a Container with a Drawer, we do so directly as it extends Drawer.
// If you only want partial screen coverage when navigating to '/menu',
// consider changing this to a StatelessWidget and wrapping it in a Scaffold instead.

class MenuScreen extends Drawer {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // Set the width of the drawer
      width: MediaQuery.sizeOf(context).width * 0.55, // Adjust as desired
      child: Drawer(
        backgroundColor: const Color.fromRGBO(255, 245, 129, 1),
        child: ListView(
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
                          // Navigate to Home
                          context.go('/');
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
                        ),
                      ),
                      const SizedBox(width: 6.0),
                      // Three-bar menu icon -> Closes the drawer
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.menu),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40.0),

            // Box 1 (empty)
            Material(
              child: InkWell(
                onTap: () {
                  context.go('/profile');
                },
                child: ListTile(
                  leading: Container(
                      width: 25,
                      height: 70,
                      color: Color.fromRGBO(198, 187, 60, 1),
                      child: Icon(Icons.person_2_rounded,color:Colors.black)
                  ),
                  tileColor: const Color.fromRGBO(244, 233, 107, 1),
                  title: const Text(
                    'Account', //***name of button widget goes here***
                    style: TextStyle(
                      fontFamily: 'Archivo',
                    ),
                  ),
                  selected: false,
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Box 2 (empty)
            // Material(
            //   color: const Color.fromRGBO(244, 233, 107, 1),
            //   child: ListTile(
            //     leading: Container(
            //       width: 25,
            //       height: 70,
            //       color: const Color.fromRGBO(198, 187, 60, 1),
            //     ),
            //     title: const Text(
            //       '',
            //       style: TextStyle(fontFamily: 'Archivo'),
            //     ),
            //     selected: false,
            //   ),
            // ),
            // const SizedBox(height: 8),

            // 3) FAQ Box -> "FAQ"
            Material(
              color: const Color.fromRGBO(244, 233, 107, 1),
              child: InkWell(
                onTap: () {
                  // Navigate to FAQ screen
                  context.go('/faq');
                },
                child: ListTile(
                  leading: Container(
                      width: 25,
                      height: 70,
                      color: const Color.fromRGBO(198, 187, 60, 1),
                      child: Icon(Icons.question_mark_sharp)
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

            // Box 4 (empty)
            Material(
              color: const Color.fromRGBO(244, 233, 107, 1),
              child: ListTile(
                leading: Container(
                    width: 25,
                    height: 70,
                    color: Color.fromRGBO(198, 187, 60, 1),
                    child: Icon(Icons.info_outlined)
                ),
                title: const Text(
                  'About Us', //***name of button widget goes here***
                  style: TextStyle(
                    fontFamily: 'Archivo',
                  ),
                ),
                selected: false,
                // ***button goes here*** onTap
                onTap: () {context.go('/about_us');},
              ),
            ),
            const SizedBox(height: 8),

            // Box 5 (empty)
            Material(
              color: Color.fromRGBO(244, 233, 107, 1),
              child: ListTile(
                leading: Container(
                    width: 25,
                    height: 70,
                    color: Color.fromRGBO(198, 187, 60, 1),
                    child: Icon(Icons.house_sharp,color:Colors.black)
                ),
                //name of tag
                title: const Text(
                  'Shelters', //***name of button widget goes here***
                  style: TextStyle(
                    fontFamily: 'Archivo',
                  ),
                ),
                selected: false,
                //***button goes here, use onTap***
                onTap: () {context.go('/shelter-info');},
              ),
            ),

            // Spacer
            SizedBox(
              height: 8,
            ),

            // SETTINGS
          Material(
            color: const Color.fromRGBO(244, 233, 107, 1),
            child: ListTile(
              leading: Container(
                width: 20,
                height: 70,
                color: const Color.fromRGBO(198, 187, 60, 1),
              ),
              title: const Text(
              'SETTINGS',
                style: TextStyle(
                  fontFamily: 'Archivo',
                  fontWeight: FontWeight.bold,

           
                ),
              ),
                selected: false,

                onTap: () {
                  context.go('/settings'); 
                  },

              ),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * .5 - 100,
            ),

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