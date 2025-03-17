import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

//This file contains the Menu Screen class. Everything that shows up in the menu screen is managed here.
/// This class extends the Drawer widget and shows 5 items that take user to screens with the name of the item,
/// used a listView inside another one to display back arrow, MENU and drawer icon.
///
class MenuScreen extends Drawer {
  //Used Stateless widget since it is not required to change over tine.
  const MenuScreen(
      {super.key}); //This is the class constructor. Calling this, allow access to the menu's properties

  @override
  Widget build(BuildContext context) {
    return Container(
      //set the width of the drawer
      width: MediaQuery.sizeOf(context).width * .55,
      child: Drawer(
        backgroundColor: Color.fromRGBO(255, 245, 129, 1),
        child: ListView(
          children: [
            SizedBox(height: 6.0),
            //Arrow, MENU and drawer icon
            Container(
              decoration:
                  const BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0)),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  height: 40,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back)),
                      SizedBox(width: 20.0),
                      Text(
                        'MENU',
                        style: TextStyle(
                            fontSize: 32,
                            fontFamily: 'Archivo',
                            color: Colors.black),
                      ),
                      SizedBox(width: 6.0),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.menu))
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 40.0),
            Material(
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: ListTile(
                  leading: Container(
                    width: 20,
                    height: 70,
                    color: Color.fromRGBO(198, 187, 60, 1),
                  ),
                  tileColor: Color.fromRGBO(244, 233, 107, 1),
                  title: const Text(
                    'ACCOUNT',
                    style: TextStyle(
                      fontFamily: 'Archivo',
                    ),
                  ),
                  selected: false,
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Material(
              color: Color.fromRGBO(244, 233, 107, 1),
              child: ListTile(
                leading: Container(
                  width: 20,
                  height: 70,
                  color: Color.fromRGBO(198, 187, 60, 1),
                ),
                title: const Text(
                  'ABOUT US',
                  style: TextStyle(
                    fontFamily: 'Archivo',
                  ),
                ),
                selected: false,
                onTap: () {
                  // Update the state of the app
                  context.go('/login');
                },
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Material(
              color: Color.fromRGBO(244, 233, 107, 1),
              child: ListTile(
                leading: Container(
                  width: 20,
                  height: 70,
                  color: Color.fromRGBO(198, 187, 60, 1),
                ),
                title: const Text(
                  'SHELTERS',
                  style: TextStyle(
                    fontFamily: 'Archivo',
                  ),
                ),
                selected: false,
                onTap: () {
                  // Update the state of the app
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Material(
              color: Color.fromRGBO(244, 233, 107, 1),
              child: ListTile(
                leading: Container(
                  width: 20,
                  height: 70,
                  color: Color.fromRGBO(198, 187, 60, 1),
                ),
                title: const Text(
                  'SERVICES',
                  style: TextStyle(
                    fontFamily: 'Archivo',
                  ),
                ),
                selected: false,
                onTap: () {
                  // Update the state of the app
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Material(
              color: Color.fromRGBO(244, 233, 107, 1),
              child: ListTile(
                leading: Container(
                  width: 20,
                  height: 70,
                  color: Color.fromRGBO(198, 187, 60, 1),
                ),
                title: const Text(
                  'SETTINGS',
                  style: TextStyle(
                    fontFamily: 'Archivo',
                  ),
                ),
                selected: false,
                onTap: () {
                  // Update the state of the app
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * .5 - 100,
            ),
            IconButton(
                alignment: Alignment.centerRight,
                iconSize: 50,
                onPressed: () {
                  context.go('/auth');
                },
                icon: const Icon(Icons.logout)),
          ],
        ),
      ),
    );
  }
}
