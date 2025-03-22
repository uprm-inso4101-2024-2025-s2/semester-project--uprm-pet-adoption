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
                            //***button goes here Navigator.pop(context);***
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
                //***button goes here, use onTap***
                onTap: () {
                  context.go('/auth');
                },
                child: ListTile(
                  leading: Container(
                    width: 20,
                    height: 70,
                    color: Color.fromRGBO(198, 187, 60, 1),
                    child: Icon(Icons.person_2_rounded,color:Colors.black)
                  ),
                  tileColor: Color.fromRGBO(244, 233, 107, 1),
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
                  child: Icon(Icons.question_mark_sharp)
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
                onTap: () {context.go('/gettoknow');},
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
                  child: Icon(Icons.question_mark_sharp,color:Colors.black)
                ),
                title: const Text(
                  'FAQs', //***name of button widget goes here***
                  style: TextStyle(
                    fontFamily: 'Archivo',
                  ),
                ),
                selected: false,
                //***button goes here, use onTap***
                onTap: () {context.go('/FAQs');},
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
                  child: Icon(Icons.settings,color:Colors.black),
                ),
                title: const Text(
                  'Settings', //***name of button widget goes here***
                  style: TextStyle(
                    fontFamily: 'Archivo',
                  ),
                ),
                selected: false,
                //***button goes here, use onTap***
                onTap: () {context.go('/settings');},
              ),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * .5 - 100,
            ),
            SizedBox(
              width: 20,
              child: IconButton(
                  alignment: Alignment.centerRight,
                  iconSize: 50,
                  onPressed: () {
                    context.go('/auth');
                  },
                  icon: const Icon(Icons.logout)),
            ),
          ],
        ),
      ),


    );
  }
}
