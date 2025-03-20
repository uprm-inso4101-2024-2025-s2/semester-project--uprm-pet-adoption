import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

//This file contains the Menu Screen class. Everything that shows up in the menu screen is managed here.

class MenuScreen extends StatelessWidget {
  //Used Stateless widget since it is not required to change over tine.
  const MenuScreen(
      {super.key}); //This is the class constructor. Calling this, allow access to the menu's properties

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //AppBar is a prebuilt widget in Flutter
      appBar: AppBar(title: const Text('Menu Screen')),
      body: Padding(
        padding: EdgeInsets.zero,
        child: Drawer(
          backgroundColor: Color(0xFFFFF581),
          child: ListView(
            padding: EdgeInsets.all(30),
            children: [
              ListTile(
                leading: Icon(Icons.person_2_rounded,color:Colors.black),
                title: Text(
                  'Account',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                    letterSpacing: 0,
                    fontFamily: 'Archivo'
                  ),
                ),
                onTap: () {context.go('/auth');},
              ),
              ListTile(
                leading: Icon(Icons.info_outline_rounded,color:Colors.black),
                title: Text(
                  'About Us',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                    letterSpacing: 0,
                    fontFamily: 'Archivo'
                  ),
                ),
                onTap: () {context.go('/about_us');},
              ),
              ListTile(
                leading: Icon(Icons.house_sharp,color:Colors.black),
                title: Text(
                  'Shelters',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                    letterSpacing: 0,
                    fontFamily: 'Archivo'
                  ),
                ),
                onTap: () {context.go('/gettoknow');},
              ),
              ListTile(
                leading: Icon(Icons.question_mark_sharp,color:Colors.black),
                title: Text(
                  'FAQs',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                    letterSpacing: 0,
                    fontFamily: 'Archivo'
                  ),
                ),
                onTap: () {context.go('/FAQs');},
              ),
              ListTile(
                style: ListTileStyle.list,
                selectedTileColor: Colors.grey,
                minVerticalPadding: 10,
                leading: Icon(Icons.settings,color:Colors.black),
                title: Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                    letterSpacing: 0,
                    fontFamily: 'Archivo'
                  ),
                ),
                onTap: () {context.go('/settings');},
              ),
            ]
          )
        ),
      ),


    );
  }
}
