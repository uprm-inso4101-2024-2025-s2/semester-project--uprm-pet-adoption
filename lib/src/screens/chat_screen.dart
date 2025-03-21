import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:semester_project__uprm_pet_adoption/src/widgets.dart'; // Import for navigation

// Main Screen
class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80), // height for Appbar
        child: const ChatHeader(), // use the custom ChatHeader widget
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          textDirection: TextDirection.ltr,
          children: [
            const SizedBox(
                height: 10), // adds space between header and messages
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
                  style: TextStyle(
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
                  style: TextStyle(
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
                  style: TextStyle(
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
                  style: TextStyle(
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
                  style: TextStyle(
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
      bottomNavigationBar: const BottomNavBar(selectedIndex: 1),
    );
  }
}

// Header Widget - Contains "Messages" title and "Add User" button
class ChatHeader extends StatelessWidget {
  const ChatHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 40, bottom: 5),
      color: const Color(0xFFFFF581), // Yellow background
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: Messages title + Add User button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Messages",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.person_add,
                    size: 35, color: Colors.black), // Add User to chat icon
                onPressed: () {
                  _showAddUserDialog(context); // Opens add-user popup
                },
              ),
            ],
          ),
          const SizedBox(height: 5), // space between "Messages" and "Chats"
          const Text(
            "Chats",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

// Add User Popup - Allows adding a new user by entering a username
void _showAddUserDialog(BuildContext context) {
  TextEditingController usernameController =
      TextEditingController(); // Controller for input field

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Add User to Chat"),
        content: TextField(
          controller: usernameController, // Captures user input
          decoration: const InputDecoration(hintText: "Enter username"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Close popup
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              String username = usernameController.text.trim(); // Get input
              if (username.isNotEmpty) {
                print(
                    "User added: $username"); // Placeholder for future functionality
                Navigator.pop(context); // Close popup
              }
            },
            child: const Text("Add"),
          ),
        ],
      );
    },
  );
}
