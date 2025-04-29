import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:semester_project__uprm_pet_adoption/analytics_service.dart';
import 'package:semester_project__uprm_pet_adoption/services/auth_service.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:semester_project__uprm_pet_adoption/supabase/upload.dart';
import '../widgets.dart';

class PetProfile extends StatefulWidget {
  const PetProfile({Key? key}) : super(key: key);

  @override
  _PetProfileState createState() => _PetProfileState();
}

class _PetProfileState extends State<PetProfile> {
  final AuthService authService = AuthService();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController breedController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String? petPictureFileName;
  Uint8List? _imageBytes;
  String? _localImagePath;
  String selectedAgeCategory = 'Puppy (0-2 yrs)';

  final List<String> ageCategories = [
    'Puppy (0-2 yrs)',
    'Adult (3-9 yrs)',
    'Elderly (10+ yrs)',
  ];

  final List<String> selectedTags = [];
  final List<String> allTags = [
    "small",
    "medium",
    "large",
    "adventurous",
    "chill",
    "family pet",
    "trained",
    "vaccinated",
    "playful",
  ];

  File? _selectedImage;
  String? imageUrl;
  bool _isUploading = false;

  Future<void> _uploadNewPetProfilePicture() async {
    if (_isUploading) return;
    setState(() => _isUploading = true);

    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1080,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        final bytes = await pickedFile.readAsBytes();

        if (kIsWeb) {
          setState(() {
            _imageBytes = bytes;
            _localImagePath = null;
          });
        } else {
          setState(() {
            _localImagePath = pickedFile.path;
            _imageBytes = null;
          });
        }

        String? fileName =
            await StorageService().petPictureUpload(fileBytes: bytes);
        if (fileName != null && mounted) {
          setState(() {
            imageUrl = getSupabaseImageUrl(fileName);
            petPictureFileName = fileName;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Profile picture updated successfully')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString().split('\n').first}')),
        );
        setState(() {
          _imageBytes = null;
          _localImagePath = null;
        });
      }
    } finally {
      if (mounted) setState(() => _isUploading = false);
    }
  }

  String getSupabaseImageUrl(String fileName) {
    return 'https://csrsmxmhiqwcalunugzf.supabase.co/storage/v1/object/public/uploads/$fileName';
  }

  @override
  Widget build(BuildContext context) {
    AnalyticsService().logScreenView("petProfile_screen");
    final screenHeight = MediaQuery.of(context).size.height;
    final fieldScale = screenHeight < 700 ? 0.8 : 1.0;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('New Pet Profile',
            style: TextStyle(
                fontSize: 24 * fieldScale,
                fontFamily: 'Archivo',
                color: Colors.black)),
        backgroundColor: const Color(0xFFFFF581),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.go('/matchmaking'),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Login_SignUp_Background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0 * fieldScale),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: _uploadNewPetProfilePicture,
                child: ClipOval(
                  child: SizedBox(
                      width: 100, height: 100, child: _buildProfileImage()),
                ),
              ),
              SizedBox(height: 12 * fieldScale),
              _buildTextInput(
                  "Name of Pet", "Enter pet name", nameController, fieldScale),
              SizedBox(height: 16 * fieldScale),
              Row(
                children: [
                  Expanded(
                    child: _buildButtonWithLabel(
                      label: 'Age',
                      value: selectedAgeCategory,
                      onTap: () => _showAgeSelection(context),
                      fieldScale: fieldScale,
                    ),
                  ),
                  SizedBox(width: 12 * fieldScale),
                  Expanded(
                    child: _buildButtonWithLabel(
                      label: "Breed",
                      value: breedController.text.isEmpty
                          ? "Select"
                          : breedController.text,
                      onTap: () => _showBreedSelection(context),
                      fieldScale: fieldScale,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20 * fieldScale),
              _buildTextInput("Description", "Enter pet description",
                  descriptionController, fieldScale,
                  maxLines: 3),
              SizedBox(height: 20 * fieldScale),
              Text("Choose the best tags to describe the pet",
                  style: TextStyle(
                      fontSize: 16 * fieldScale,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'ArchivoBlack',
                      color: Colors.black)),
              SizedBox(height: 12 * fieldScale),
              _buildBoneTagRows(fieldScale),
              SizedBox(height: 24 * fieldScale),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40 * fieldScale),
                  child: ElevatedButton(
                    onPressed: () async {
                      await authService.petsSignUp(
                        medicalDocument: 'fileName For medicalDocument',
                        petPicture:
                            petPictureFileName ?? 'fileName For petPicture',
                        petAge: selectedAgeCategory,
                        petBreed: breedController.text,
                        petDescription: descriptionController.text,
                        petName: nameController.text,
                        petShelter: '',
                        petTags: selectedTags.join(', '),
                      );
                      context.go('/');
                      AnalyticsService().addPetsSignUp();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFF581),
                      padding: EdgeInsets.symmetric(vertical: 14 * fieldScale),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Text("Complete Registration",
                        style: TextStyle(
                            fontSize: 16 * fieldScale,
                            fontFamily: 'ArchivoBlack',
                            color: Colors.black)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 0),
    );
  }

  Widget _buildBoneTagRows(double fieldScale) {
    return Column(
      children: [
        for (int i = 0; i < allTags.length; i += 3)
          Padding(
            padding: EdgeInsets.only(bottom: 12 * fieldScale),
            child: _buildBoneTagRow(
                allTags.sublist(i, (i + 3).clamp(0, allTags.length)),
                fieldScale),
          ),
      ],
    );
  }

  Widget _buildBoneTagRow(List<String> tags, double fieldScale) {
    return Wrap(
      spacing: 12 * fieldScale,
      runSpacing: 12 * fieldScale,
      alignment: WrapAlignment.center,
      children: tags.map((tag) => _buildBoneTag(tag, fieldScale)).toList(),
    );
  }

  Widget _buildBoneTag(String text, double fieldScale) {
    final color = _getTagColor(text);
    final isSelected = selectedTags.contains(text);

    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected ? selectedTags.remove(text) : selectedTags.add(text);
        });
      },
      child: AnimatedScale(
        scale: isSelected ? 0.93 : 1.0,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
        child: Container(
          width: 110 * fieldScale,
          height: 48 * fieldScale,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage('assets/images/bone.png'),
              fit: BoxFit.contain,
              colorFilter: ColorFilter.mode(
                HSLColor.fromColor(color)
                    .withLightness(isSelected ? 0.5 : 0.7)
                    .toColor()
                    .withOpacity(0.9),
                BlendMode.srcATop,
              ),
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: Offset(0, 1),
                      blurRadius: 2,
                      spreadRadius: -1,
                    ),
                  ]
                : [],
          ),
          alignment: Alignment.center,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              text.toLowerCase(),
              style: TextStyle(
                fontSize: 10 * fieldScale,
                fontFamily: 'ArchivoBlack',
                fontWeight: FontWeight.bold,
                color: Colors.black,
                shadows: [
                  Shadow(
                    color: Colors.white.withOpacity(0.7),
                    blurRadius: 1.5,
                    offset: const Offset(1, 1),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getTagColor(String tag) {
    switch (tag.toLowerCase()) {
      case 'small':
        return Color(0xFFFFC0CB);
      case 'medium':
        return Color(0xFF00FFFF);
      case 'large':
        return Color(0xFFE6E6FA);
      case 'adventurous':
        return Color(0xFF006400);
      case 'chill':
        return Color(0xFFF5F5DC);
      case 'family pet':
        return Color(0xFFFF7F50);
      case 'trained':
        return Color(0xFF800080);
      case 'vaccinated':
        return Color(0xFFFFA500);
      case 'playful':
        return Color(0xFFFF00FF);
      default:
        return Colors.grey;
    }
  }

  Widget _buildProfileImage() {
    if (_isUploading) return const Center(child: CircularProgressIndicator());
    if (kIsWeb && _imageBytes != null) {
      return Image.memory(_imageBytes!, fit: BoxFit.cover);
    } else if (!kIsWeb && _localImagePath != null) {
      return Image.file(File(_localImagePath!), fit: BoxFit.cover);
    } else if (imageUrl != null) {
      return Image.network(imageUrl!, fit: BoxFit.cover);
    } else {
      return _buildDefaultImage();
    }
  }

  Widget _buildDefaultImage() {
    return Image.asset('assets/images/Account_Circle_blue_dms.png',
        fit: BoxFit.cover);
  }

  Widget _buildTextInput(
      String label, String hint, TextEditingController controller, double scale,
      {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(
                fontSize: 16 * scale,
                fontFamily: 'ArchivoBlack',
                color: Colors.black)),
        SizedBox(height: 4 * scale),
        Container(
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(4)),
          child: TextField(
            controller: controller,
            maxLines: maxLines,
            style: TextStyle(
                fontSize: 18 * scale,
                fontFamily: 'ArchivoBlack',
                color: Colors.black),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.black54),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(12 * scale),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButtonWithLabel(
      {required String label,
      required String value,
      required VoidCallback onTap,
      required double fieldScale}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(
                fontSize: 14 * fieldScale,
                fontFamily: 'ArchivoBlack',
                color: Colors.black)),
        SizedBox(height: 4 * fieldScale),
        InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: 10 * fieldScale, horizontal: 12 * fieldScale),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(value,
                    style: TextStyle(
                        fontSize: 14 * fieldScale, color: Colors.black)),
                Icon(Icons.arrow_drop_down, size: 20 * fieldScale),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showAgeSelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView.builder(
          itemCount: ageCategories.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(ageCategories[index]),
              onTap: () {
                setState(() => selectedAgeCategory = ageCategories[index]);
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }

  void _showBreedSelection(BuildContext context) {
    final commonBreeds = [
      "Labrador Retriever",
      "German Shepherd",
      "Golden Retriever",
      "Bulldog",
      "Beagle",
      "Poodle",
      "Rottweiler",
      "Other"
    ];

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView.builder(
          itemCount: commonBreeds.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(commonBreeds[index]),
              onTap: () {
                setState(() => breedController.text = commonBreeds[index]);
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }
}
