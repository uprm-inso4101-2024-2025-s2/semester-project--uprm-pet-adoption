import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:semester_project__uprm_pet_adoption/src/widgets.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // Controllers to handle user input
  final TextEditingController nameController =
      TextEditingController(text: "John Doe");
  final TextEditingController emailController =
      TextEditingController(text: "johndoe@example.com");
  final TextEditingController locationController =
      TextEditingController(text: "New York, USA");
  final TextEditingController phoneController =
      TextEditingController(text: "+1 234 567 890");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: AppBar(
          backgroundColor: Color(0xFFFFF581),
          title: Align(
            alignment: Alignment.centerLeft,
            child: const Text(
              'Profile',
              style: TextStyle(
                fontFamily: 'Archivo',
                fontSize: 35,
              ),
            ),
          ),
          titleSpacing: 0,
          leading: IconButton(
            icon: Image.asset(
              'assets/images/Arrow_Circle_dms.png',
              width: 30,
              height: 30,
            ),
            onPressed: () {
              context.go('/');
            },
          ),
        ),
      ),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/Login_SignUp_Background.png',
              fit: BoxFit.cover,
            ),
          ),

          // Profile Image & Username Above White Box
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Editable Username
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: TextField(
                    controller: nameController,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'Archivo',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none, // No border
                      contentPadding: EdgeInsets.zero, // No padding
                    ),
                  ),
                ),
                SizedBox(height: 5),

                // Profile Image
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey.shade300,
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/Account_Circle_yellow_dms.png',
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.person, size: 60, color: Colors.grey);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),

          // White Box with Editable User Details & Logout Button
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.57,
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildEditableProfileField(
                      Icons.person, "Name", nameController),
                  SizedBox(height: 15),
                  _buildEditableProfileField(
                      Icons.email, "Email", emailController),
                  SizedBox(height: 15),
                  _buildEditableProfileField(
                      Icons.location_on, "Location", locationController),
                  SizedBox(height: 15),
                  _buildEditableProfileField(
                      Icons.phone, "Phone Number", phoneController),
                  Spacer(), // Push logout button to bottom

                  // Logout Button
                  Center(
                    child: SizedBox(
                      width: double.infinity, // Makes button full width
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Color(0xFFFFF581), // logout button color
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          context.go('/login'); // Redirect to login page
                        },
                        child: Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Archivo',
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 4),
    );
  }

  // Widget for Editable Profile Fields
  Widget _buildEditableProfileField(
      IconData icon, String label, TextEditingController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade100, // Light background color
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey.shade700),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none, // Removes input box border
                hintText: label,
                hintStyle: TextStyle(color: Colors.grey.shade600),
              ),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
