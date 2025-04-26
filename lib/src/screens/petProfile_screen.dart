import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:semester_project__uprm_pet_adoption/analytics_service.dart';
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
  final TextEditingController nameController = TextEditingController();
  final TextEditingController breedController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();


  Uint8List? _imageBytes;
  String? _localImagePath;
  String selectedAgeCategory = 'Puppy (0-2 yrs)';
  
  final List<String> ageCategories = [
    'Puppy (0-2 yrs)',
    'Adult (3-9 yrs)',
    'Elderly (10+ yrs)',
  ];

  File? _selectedImage;
  String? imageUrl;
  bool _isUploading = false;
  final List<String> selectedTags = [];

  Future<void> _uploadNewPetProfilePicture() async {
    if (_isUploading) return;
    
    setState(() => _isUploading = true);
    
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        requestFullMetadata: false, // Important for iOS
        maxWidth: 1080, // Optional: limit image size
        maxHeight: 1080, // Optional: limit image size
        imageQuality: 85, // Optional: reduce quality for smaller files
      );
      
      if (pickedFile != null) {
        
        final bytes = await pickedFile.readAsBytes();
       
        // Platform-specific handling
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

        // Upload the bytes directly
        String? fileName = await StorageService().petPictureUpload(fileBytes: bytes);
        
        if (fileName != null && mounted) {
          setState(() {
            imageUrl = getSupabaseImageUrl(fileName);
            
          });
          
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile picture updated successfully')),
          );
        }
      }
    } catch (e, stackTrace) {
      print('Full error details: $e\n$stackTrace');
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

  Widget _buildProfileImage() {
    if (_isUploading) {
      return const Center(child: CircularProgressIndicator());
    }  // Web platform - use memory image
    if (kIsWeb && _imageBytes != null) {
      return ClipOval(
        child: Image.memory(
          _imageBytes!,
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
      );
    }
    // Mobile platform - use file image
    else if (!kIsWeb && _localImagePath != null) {
      return ClipOval(
        child: Image.file(
          File(_localImagePath!),
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
      );
    }
    // Show uploaded image from URL
    else if (imageUrl != null) {
      return ClipOval(
        child: Image.network(
          imageUrl!,
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
      );
    }
    // Default image
    else {
      return _buildDefaultImage();
    }
  }

  Widget _buildDefaultImage() {
    return ClipOval(
      child: Image.asset(
        'assets/images/Account_Circle_blue_dms.png',
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    AnalyticsService().logScreenView("petProfile_screen");

    final screenHeight = MediaQuery.of(context).size.height;
    final fieldScale = screenHeight < 700 ? 0.8 : 1.0;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'New Pet Profile',
          style: TextStyle(
            fontSize: 24 * fieldScale,
            // fontWeight: FontWeight.bold,
            fontFamily: 'Archivo',
            color: Colors.black,
          ),
        ),
        backgroundColor: const Color(0xFFFFF581),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.go('/'),
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

              Stack(
                alignment: Alignment.center,
                children: [
                  GestureDetector(
                    onTap: _uploadNewPetProfilePicture,
                    child: ClipOval(
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: _buildProfileImage(),
                      ),
                    ),
                  ),
                  if (!_isUploading)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(4 * fieldScale),
                        decoration: const BoxDecoration(
                          color: Color(0xFFFFF581),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.camera_alt,

                            size: 16 * fieldScale, color: Colors.black),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 12 * fieldScale),

              _buildTextInput("Name of Pet", "Enter pet name", nameController, fieldScale),
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
                  descriptionController, fieldScale, maxLines: 3),
              SizedBox(height: 20 * fieldScale),
              Text(
                "Health Documents",
                style: TextStyle(
                  fontSize: 16 * fieldScale,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'ArchivoBlack',
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8 * fieldScale),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.all(8 * fieldScale),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.add, size: 24 * fieldScale),
                      onPressed: () {
                        // Add upload PDF functionality here
                      },
                    ),
                    SizedBox(width: 8 * fieldScale),
                    const Expanded(
                      child: LinearProgressIndicator(
                        value: 0.7,
                        backgroundColor: Colors.grey,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                      ),
                    ),
                    SizedBox(width: 8 * fieldScale),
                    Text("70%",
                        style: TextStyle(
                          fontSize: 14 * fieldScale,
                          fontFamily: 'ArchivoBlack',
                          color: Colors.black,
                        )),
                  ],
                ),
              ),
              SizedBox(height: 20 * fieldScale),
              Text(
                "Choose the best tags to describe the pet",
                style: TextStyle(
                  fontSize: 16 * fieldScale,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'ArchivoBlack',
                  color: Colors.black,
                ),
              ),
              
              SizedBox(height: 12 * fieldScale),
              _buildBoneTagRow(["small", "medium", "large"], fieldScale),
              SizedBox(height: 12 * fieldScale),
              _buildBoneTagRow(["adventurous", "chill", "family pet"], fieldScale),
              SizedBox(height: 12 * fieldScale),
              _buildBoneTagRow(["trained", "vaccinated", "playful"], fieldScale),
              SizedBox(height: 24 * fieldScale),
              SizedBox(

                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40 * fieldScale),
                  child: ElevatedButton(
                    onPressed: () {
                      // Submit logic here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFF581),
                      padding: EdgeInsets.symmetric(
                        vertical: 14 * fieldScale,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Complete Registration",
                      style: TextStyle(
                        fontSize: 16 * fieldScale,
                        fontFamily: 'ArchivoBlack',
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
    );
  }

  Widget _buildTextInput(String label, String hint, TextEditingController controller,
      double scale, {int maxLines = 1}) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16 * scale,
              fontWeight: FontWeight.bold,
              fontFamily: 'ArchivoBlack',
              color: Colors.black,
            ),
          ),
          SizedBox(height: 4 * scale),
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(4),
            ),
            child: TextField(
              controller: controller,
              maxLines: maxLines,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 18 * scale,
                fontWeight: FontWeight.bold,
                fontFamily: 'ArchivoBlack',
                color: Colors.black,
              ),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(color: Colors.black54),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(12 * scale),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonWithLabel({
    required String label,
    required String value,
    required VoidCallback onTap,
    required double fieldScale,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14 * fieldScale,

            fontFamily: 'ArchivoBlack',

            color: Colors.black,
          ),
        ),
        SizedBox(height: 4 * fieldScale),
        InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 10 * fieldScale,
              horizontal: 12 * fieldScale,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14 * fieldScale,
                    // fontFamily: 'Archivo',
                    color: Colors.black,
                  ),
                ),

                Icon(Icons.arrow_drop_down, size: 20 * fieldScale),

              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBoneTagRow(List<String> tags, double fieldScale) {
    return Wrap(
      spacing: 8 * fieldScale,
      runSpacing: 8 * fieldScale,
      children: tags.map((tag) => _buildBoneTag(tag, fieldScale)).toList(),
    );
  }

  Widget _buildBoneTag(String text, double fieldScale) {
    final color = _getTagColor(text);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (selectedTags.contains(text)) {
            selectedTags.remove(text);
          } else {
            selectedTags.add(text);
          }
        });
      },
      child: SizedBox(
        width: 120 * fieldScale,
        height: 50 * fieldScale,
        child: Stack(
          alignment: Alignment.center,
          children: [
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                selectedTags.contains(text) 
                  ? color.withOpacity(0.9)
                  : color.withOpacity(0.6),
                BlendMode.srcATop,
              ),
              child: Image.asset(
                'assets/images/bone.png',
                width: 120 * fieldScale,
                height: 50 * fieldScale,
                fit: BoxFit.contain,
              ),
            ),
            Text(
              text.toLowerCase(),
              style: TextStyle(
                fontSize: 9 * fieldScale,
                fontFamily: 'Archivo',
                color: Colors.black,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    color: Colors.white.withOpacity(0.7),
                    blurRadius: 2,
                    offset: const Offset(1, 1),
                  )
                ]
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getTagColor(String tag) {
    switch (tag.toLowerCase()) {
      case 'small':
        return Color(0xFFFFC0CB); // Pink
      case 'medium':
        return Color(0xFF00FFFF); // Cyan
      case 'large':
        return Color(0xFFE6E6FA); // Lavender
      case 'adventurous':
        return Color(0xFF006400); // Dark Green
      case 'chill':
        return Color(0xFFF5F5DC); // Beige
      case 'family pet':
        return Color(0xFFFF7F50); // Coral
      case 'trained':
        return Color(0xFF800080); // Purple
      case 'vaccinated':
        return Color(0xFFFFA500); // Orange
      case 'playful':
        return Color(0xFFFF00FF); // Fuchsia
      default:
        return Colors.grey; // Fallback color

    }
  }

  void _showAgeSelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Select Age Category',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'ArchivoBlack',
                    color: Colors.black,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: ageCategories.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        ageCategories[index],
                        style: TextStyle(
                          fontFamily: 'ArchivoBlack',
                          color: Colors.black,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          selectedAgeCategory = ageCategories[index];
                        });
                        Navigator.pop(context);
                      },
                      tileColor: selectedAgeCategory == ageCategories[index]
                          ? Color(0xFFFFF581).withOpacity(0.3)
                          : null,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }


  // Rest of your existing methods (_showAgeSelection, _showBreedSelection) remain the same...
  void _showAgeSelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Select Age Category',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'ArchivoBlack',
                    color: Colors.black,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: ageCategories.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        ageCategories[index],
                        style: TextStyle(
                          fontFamily: 'ArchivoBlack',
                          color: Colors.black,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          selectedAgeCategory = ageCategories[index];
                        });
                        Navigator.pop(context);
                      },
                      tileColor: selectedAgeCategory == ageCategories[index]
                          ? Color(0xFFFFF581).withOpacity(0.3)
                          : null,
                    );
                  },
                ),
              ),
            ],
          ),
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
        return Container(
          height: 300,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/Login_SignUp_Background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Search breeds",
                      prefixIcon: Icon(Icons.search),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    ),
                    onChanged: (value) {
                      // Implement search functionality if needed
                    },
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                  ),
                  child: ListView.builder(
                    itemCount: commonBreeds.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(commonBreeds[index]),
                        onTap: () {
                          setState(() {
                            breedController.text = commonBreeds[index];
                          });
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

