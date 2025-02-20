import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semester_project__uprm_pet_adoption/src/providers/auth_provider.dart';


class LogInScreen extends ConsumerWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //This section shows the background image for this screen
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'images/Login_SignUp_Background.png',
          ),
          fit: BoxFit.cover,
        ),
      ),
      
      child: Scaffold(
        //As scaffold makes is opaque by default set backgroundcolor to transaparent
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
               padding:
                    EdgeInsets.only(bottom: 30), // Adjust vertical positioning 
              child: const Text('log in',style: TextStyle(fontSize: 40, 
              fontWeight: FontWeight.w900, 
              fontFamily: 'Archivo')
              ),
              ),

              Container (
              height: 295,
              width: MediaQuery.of(context).size.width * 0.8, 
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white, 
                borderRadius: BorderRadius.circular(50), 
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(), 
                    blurRadius: 10, 
                    spreadRadius: 2, 
                    offset: const Offset(0, 5), 
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Username Field
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black,width: 3.0,)
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2.0),
                      ),
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Archivo',
                        color: Colors.black,
                      ),
                      labelText: "Username",
                      suffixIcon: Icon(Icons.person_outline_sharp, color: Color(0xFF5D5793)),
                    ),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Archivo',
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),
                  // Password Field
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 3.0)
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2.0),
                      ),
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Archivo',
                        color: Colors.black,
                      ),
                      labelText: "Password",
                      suffixIcon: Icon(Icons.lock_outline),
                    ),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Archivo',
                      color: Colors.black,
                    ),
                  ),
                  // Forgot Password Button
                  Row(
                    children: [
                      SizedBox(width: MediaQuery.of(context).size.width / 120), // Adjust left spacing
                      TextButton(
                        onPressed: () => 1,
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero, // Removes extra padding
                          minimumSize: Size.zero, // Removes default button constraints
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Shrinks to text size
                        ),
                        child: const Text(
                          'Forgot password?',
                          style: TextStyle(
                            fontSize: 10,
                            fontFamily: 'Archivo',
                            color: Color(0xFF7E96CA),
                            fontWeight: FontWeight.bold,
                            
                          ),
                        ),
                      ),
                    ]
                  ),
                  SizedBox(height: 15),
                  //Login button, not implmented yet. Code for this button should be added below 
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFC8E8FF),
                      foregroundColor: Colors.black,
                      minimumSize: Size(200,60),
                    ),
                    onPressed: () => 1, 
                    child: const Text('log in', style: TextStyle(fontFamily: 'Archivo', fontSize: 20, fontWeight: FontWeight.bold))
                  ),
                ],
              ),
            ),

            //Go back to Auth button
            SizedBox(height: 25),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFC8E8FF),
                foregroundColor: Colors.black,
                minimumSize: Size(200,60),
              ),
              onPressed: () {
                context.go('/auth'); // Go back to Auth screen
              },
              child: const Text('Return', style: TextStyle(fontFamily: 'Archivo', fontSize: 20, fontWeight: FontWeight.bold)),
            ),

            ],
          ),
        ),
      ),
    );
  }

}