import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // Import for navigation




//TODAS LAS IMAGENES NECESARIAS PARA LOS BOTONES SE ENCUENTRAN EN EL IMAGES/ FOLDER
class DMScreen extends StatelessWidget {
  const DMScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color color = const Color.fromRGBO(255, 245, 121, 100);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            // Setting background image
            
            image: DecorationImage(
              image: AssetImage('images/Login_SignUp_Background.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),

      appBar: AppBar(
        
        
        backgroundColor: color,
        

      ),
      
        floatingActionButton: Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 40.0, bottom: 16), // Add space from left & bottom
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.85, // 👈 Controls how wide the oval is
              child: TextField(
                readOnly: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  hintText: "Send a message...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: const Color.fromARGB(255, 207, 207, 207),
                  filled: true,
                ),
              ),
            ),
          ),
        ),
      );
    
  
  }

}
