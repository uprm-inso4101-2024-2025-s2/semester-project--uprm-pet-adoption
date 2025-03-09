import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:semester_project__uprm_pet_adoption/src/widgets.dart'; // Import for navigation

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Messages", selectionColor: Colors.black), 
        //foregroundColor: Color(0xFFFFF581),
        backgroundColor: Color(0xFFFFF581),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          textDirection: TextDirection.ltr,
          children: [
            const Text(
              "Chats",
              textAlign: TextAlign.start,
              textDirection: TextDirection.ltr,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900,color: Colors.black),
            ),
            //const SizedBox(height: 30,width: 60), // Spacing between text and button
            Container(
              width: MediaQuery.of(context).size.width * 0.95,
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.horizontal(),
                shape: BoxShape.rectangle,
              ),
              child: TextButton.icon(
                onPressed: () {
                context.go('/dms'); // Navigate to Messages screen
                }, 
                label: Text(
                  "message",
                  style:  TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Archivo',
                      color: Colors.black,
                  ),
                ),
                icon: CircleAvatar(
                  foregroundColor: Color(0xFF82B0FF),
                  backgroundColor: Color(0xFF82B0FF),
                  radius: 20,
                  /*child: Image.asset(
                  'icons/Icon-192.png',
                  fit: BoxFit.cover,
                  )*/
                ),
                iconAlignment: IconAlignment.start,
                
              ),
          ),
          Container(
              width: MediaQuery.of(context).size.width * 0.95,
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.horizontal(),
                shape: BoxShape.rectangle,
              ),
              child: TextButton.icon(
                onPressed: () {
                context.go('/dms'); // Navigate to Messages screen
                }, 
                label: Text(
                  "message",
                  style:  TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Archivo',
                      color: Colors.black,
                  ),
                ),
                icon: CircleAvatar(
                  foregroundColor: Color(0xFF82B0FF),
                  backgroundColor: Color(0xFF82B0FF),
                  radius: 20,
                  /*child: Image.asset(
                  'icons/Icon-192.png',
                  fit: BoxFit.cover,
                  )*/
                ),
                iconAlignment: IconAlignment.start,
                
              ),
          ),
          Container(
              width: MediaQuery.of(context).size.width * 0.95,
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.horizontal(),
                shape: BoxShape.rectangle,
              ),
              child: TextButton.icon(
                onPressed: () {
                context.go('/dms'); // Navigate to Messages screen
                }, 
                label: Text(
                  "message",
                  style:  TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Archivo',
                      color: Colors.black,
                  ),
                ),
                icon: CircleAvatar(
                  foregroundColor: Color(0xFF82B0FF),
                  backgroundColor: Color(0xFF82B0FF),
                  radius: 20,
                  /*child: Image.asset(
                  'icons/Icon-192.png',
                  fit: BoxFit.cover,
                  )*/
                ),
                iconAlignment: IconAlignment.start,
                
              ),
          ),
          Container(
              width: MediaQuery.of(context).size.width * 0.95,
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.horizontal(),
                shape: BoxShape.rectangle,
              ),
              child: TextButton.icon(
                onPressed: () {
                context.go('/dms'); // Navigate to Messages screen
                }, 
                label: Text(
                  "message",
                  style:  TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Archivo',
                      color: Colors.black,
                  ),
                ),
                icon: CircleAvatar(
                  foregroundColor: Color(0xFF82B0FF),
                  backgroundColor: Color(0xFF82B0FF),
                  radius: 20,
                  /*child: Image.asset(
                  'icons/Icon-192.png',
                  fit: BoxFit.cover,
                  )*/
                ),
                iconAlignment: IconAlignment.start,
                
              ),
          ),
          Container(
              width: MediaQuery.of(context).size.width * 0.95,
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.horizontal(),
                shape: BoxShape.rectangle,
              ),
              child: TextButton.icon(
                onPressed: () {
                context.go('/dms'); // Navigate to Messages screen
                }, 
                label: Text(
                  "message",
                  style:  TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Archivo',
                      color: Colors.black,
                  ),
                ),
                icon: CircleAvatar(
                  foregroundColor: Color(0xFF82B0FF),
                  backgroundColor: Color(0xFF82B0FF),
                  radius: 20,
                  /*child: Image.asset(
                  'icons/Icon-192.png',
                  fit: BoxFit.cover,
                  )*/
                ),
                iconAlignment: IconAlignment.start,
                
              ),
          ),
        ],
      ),
    ),
    bottomNavigationBar: const BottomNavBar(
      selectedIndex: 0),
  );
  }
}
