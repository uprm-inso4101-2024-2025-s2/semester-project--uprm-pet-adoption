import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:semester_project__uprm_pet_adoption/analytics_service.dart';
import 'package:semester_project__uprm_pet_adoption/src/widgets.dart'; // Import for navigation

// Custom ChatHeader widget
class ChatHeader extends StatelessWidget {
  const ChatHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AnalyticsService().logScreenView("chat_screen");

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
            //Create the container for chat widgets
            InkWell(
              onTap: () {
                context.go('/dms');
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.95,
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.horizontal(),
                  shape: BoxShape.rectangle,
                ),
                child: Row(
                  children: [
                    // Profile icon
                    CircleAvatar(
                        foregroundColor: Color(0xFF82B0FF),
                        backgroundColor: Color(0xFF82B0FF),
                        radius: 20,
                        child: Icon(
                          Icons.person_2_sharp,
                          color: Colors.black,
                        )
                    ),
                    SizedBox(width: 16,),
                    Expanded(
                        child: Container(
                          color: Colors.white,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //Chat name
                                Text("Name",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'Archivo',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 6,),
                                //Button with message preview
                                Text(
                                    "Message preview",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w100,
                                      fontFamily: 'Archivo',
                                    )
                                )
                              ]
                          ),
                        )
                    ),
                    // Message time (temporary time added)
                    Text("11:59 am", style: TextStyle(fontSize : 15)),
                  ],
                ),
              ),
            ),
            // Add more chat containers
            InkWell(
              onTap: () {
                context.go('/dms');
              },
              child:  Container(
                width: MediaQuery.of(context).size.width * 0.95,
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.horizontal(),
                  shape: BoxShape.rectangle,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                        foregroundColor: Color(0xFF82B0FF),
                        backgroundColor: Color(0xFF82B0FF),
                        radius: 20,
                        child: Icon(
                          Icons.person_2_sharp,
                          color: Colors.black,
                        )
                    ),
                    SizedBox(width: 16,),
                    Expanded(
                        child: Container(
                          color: Colors.white,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Name",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'Archivo',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 6,),
                                Text(
                                    "Message preview",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w100,
                                      fontFamily: 'Archivo',
                                    )
                                )
                              ]
                          ),
                        )
                    ),
                    Text("12:00 pm", style: TextStyle(fontSize : 15)),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                context.go('/dms');
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.95,
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.horizontal(),
                  shape: BoxShape.rectangle,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                        foregroundColor: Color(0xFF82B0FF),
                        backgroundColor: Color(0xFF82B0FF),
                        radius: 20,
                        child: Icon(
                          Icons.person_2_sharp,
                          color: Colors.black,
                        )
                    ),
                    SizedBox(width: 16,),
                    Expanded(
                        child: Container(
                          color: Colors.white,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Name",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'Archivo',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 6,),
                                Text(
                                    "Message preview",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w100,
                                      fontFamily: 'Archivo',
                                    )
                                )
                              ]
                          ),
                        )
                    ),
                    Text("4:57 pm", style: TextStyle(fontSize : 15)),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                context.go('/dms');
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.95,
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.horizontal(),
                  shape: BoxShape.rectangle,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                        foregroundColor: Color(0xFF82B0FF),
                        backgroundColor: Color(0xFF82B0FF),
                        radius: 20,
                        child: Icon(
                          Icons.person_2_sharp,
                          color: Colors.black,
                        )
                    ),
                    SizedBox(width: 16,),
                    Expanded(
                        child: Container(
                          color: Colors.white,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Name",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'Archivo',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 6,),
                                Text(
                                    "Message preview",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w100,
                                      fontFamily: 'Archivo',
                                    )
                                )
                              ]
                          ),
                        )
                    ),
                    Text("5:00 pm", style: TextStyle(fontSize : 15)),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                context.go('/dms');
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.95,
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.horizontal(),
                  shape: BoxShape.rectangle,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                        foregroundColor: Color(0xFF82B0FF),
                        backgroundColor: Color(0xFF82B0FF),
                        radius: 20,
                        child: Icon(
                          Icons.person_2_sharp,
                          color: Colors.black,
                        )
                    ),
                    SizedBox(width: 16,),
                    Expanded(
                        child: Container(
                          color: Colors.white,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Name",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'Archivo',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 6,),
                                Text(
                                    "Message preview",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w100,
                                      fontFamily: 'Archivo',
                                    )
                                )
                              ]
                          ),
                        )
                    ),
                    Text("Yesterday", style: TextStyle(fontSize : 15)),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                context.go('/dms');
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.95,
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.horizontal(),
                  shape: BoxShape.rectangle,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                        foregroundColor: Color(0xFF82B0FF),
                        backgroundColor: Color(0xFF82B0FF),
                        radius: 20,
                        child: Icon(
                          Icons.person_2_sharp,
                          color: Colors.black,
                        )
                    ),
                    SizedBox(width: 16,),
                    Expanded(
                        child: Container(
                          color: Colors.white,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Name",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'Archivo',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 6,),
                                Text(
                                    "Message preview",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w100,
                                      fontFamily: 'Archivo',
                                    )
                                )
                              ]
                          ),
                        )
                    ),
                    Text("Yesterday", style: TextStyle(fontSize : 15)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 1),
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