import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:semester_project__uprm_pet_adoption/src/widgets.dart';
import 'package:semester_project__uprm_pet_adoption/supabase/retrieval.dart';
import 'package:semester_project__uprm_pet_adoption/supabase/upload.dart';
import 'package:semester_project__uprm_pet_adoption/analytics_service.dart';
import '../services/storage_service.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final ProfilePictureService profilePictureService = ProfilePictureService();

  final TextEditingController nameController =
      TextEditingController(text: "John Doe");
  final TextEditingController emailController =
      TextEditingController(text: "johndoe@example.com");
  final TextEditingController locationController =
      TextEditingController(text: "New York, USA");
  final TextEditingController phoneController =
      TextEditingController(text: "+1 234 567 890");

  String? profilePicUrl;

  @override
  void initState() {
    super.initState();
    _loadProfilePicture();
    AnalyticsService().logScreenView("user_profile_screen");
  }

  Future<void> _loadProfilePicture() async {
    try {
      String? url = await profilePictureService.getProfilePictureUrl();
      if (mounted) {
        setState(() {
          profilePicUrl = url;
        });
      }
    } catch (e) {
      print('Error loading profile picture: $e');
      if (mounted) {
        setState(() {
          profilePicUrl = null; // Explicitly set to null on error
        });
      }
    }
  }

  Future<void> _uploadNewProfilePicture() async {
    String? newFilename = await StorageService().pictureUpload();
    if (newFilename != null) {
      await _loadProfilePicture(); // Refresh profile picture
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('File uploaded successfully')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: AppBar(
          backgroundColor: const Color(0xFFFFF581),
          title: const Align(
            alignment: Alignment.centerLeft,
            child: Text(
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
          Positioned.fill(
            child: Image.asset(
              'assets/images/Login_SignUp_Background.png',
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: TextField(
                    controller: nameController,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 25,
                      fontFamily: 'Archivo',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                GestureDetector(
                  onTap: _uploadNewProfilePicture,
                  child: ClipOval(
                    child: SizedBox(
                      width: 100, // Set the width you need
                      height: 100, // Set the height you need
                      child: profilePicUrl != null && profilePicUrl!.isNotEmpty
                          ? Image.network(
                              profilePicUrl!,
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child; // Image is loaded, show it
                                } else {
                                  return const Center(child: CircularProgressIndicator());
                                }
                              },
                              errorBuilder: (context, error, stackTrace) {
                                // In case of an error, show a default image
                                return const Image(
                                  image: AssetImage('assets/images/Account_Circle_blue_dms.png'),
                                  fit: BoxFit.cover,
                                );
                              },
                            )
                          : const Image(
                              image: AssetImage('assets/images/Account_Circle_blue_dms.png'),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),

              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.57,
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white, // Add this to make the container visible
                borderRadius: const BorderRadius.vertical(
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
                  _buildEditableProfileField(Icons.person, "Name", nameController),
                  const SizedBox(height: 15),
                  _buildEditableProfileField(Icons.email, "Email", emailController),
                  const SizedBox(height: 15),
                  _buildEditableProfileField(Icons.location_on, "Location", locationController),
                  const SizedBox(height: 15),
                  _buildEditableProfileField(Icons.phone, "Phone Number", phoneController),
                  const Spacer(),
                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFF581),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          context.go('/login');
                        },
                        child: const Text(
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
      bottomNavigationBar: const BottomNavBar(selectedIndex: 0),
    );
  }

  Widget _buildEditableProfileField(
      IconData icon, String label, TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade100,
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey.shade700),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: label,
                hintStyle: TextStyle(color: Colors.grey.shade600),
              ),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}