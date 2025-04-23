import 'package:flutter/material.dart';
import 'package:semester_project__uprm_pet_adoption/analytics_service.dart';
import 'package:go_router/go_router.dart';
import '../widgets.dart';

class PetProfile extends StatefulWidget {
  const PetProfile({super.key});

  @override
  _PetProfileState createState() => _PetProfileState();
}

class _PetProfileState extends State<PetProfile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController breedController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String selectedAgeCategory = 'Puppy'; // Default value
  final List<String> ageCategories = [
    'Puppy (0-2 yrs)',
    'Adult (3-9 yrs)',
    'Elderly (10+ yrs)'
  ];
  ImageProvider? petAvatarImage;

  @override
  Widget build(BuildContext context) {
    AnalyticsService().logScreenView("petProfile_screen");

    final screenHeight = MediaQuery.of(context).size.height;
    final fieldScale = screenHeight < 700 ? 0.8 : 1.0; // Scale factor for smaller screens

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
        backgroundColor: Color(0xFFFFF581),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.go('/matchmaking'),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
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
              // Profile Avatar
              GestureDetector(
                onTap: () => _showImagePicker(context),
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 65 * fieldScale,
                      backgroundColor: Colors.white.withOpacity(0.8),
                      // backgroundImage: petAvatarImage ?? AssetImage('assets/images/default_pet_avatar.png'),
                      child: petAvatarImage == null
                          ? Icon(Icons.pets,
                              size: 50 * fieldScale, color: Colors.grey)
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(4 * fieldScale),
                        decoration: BoxDecoration(
                          color: Color(0xFFFFF581),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.camera_alt,
                            size: 24 * fieldScale, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12 * fieldScale),

              // Name of Pet section
              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name of Pet",
                      style: TextStyle(
                        fontSize: 16 * fieldScale,
                        // fontWeight: FontWeight.bold,
                        fontFamily: 'Archivo',
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 4 * fieldScale),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: TextField(
                        controller: nameController,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18 * fieldScale,
                          // fontWeight: FontWeight.bold,
                          // fontFamily: 'Archivo',
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          hintText: "Enter pet name",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12 * fieldScale,
                            vertical: 8 * fieldScale,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16 * fieldScale),

              // Age and Breed buttons
              Row(
                children: [
                  // Age Button
                  Expanded(
                    child: _buildButtonWithLabel(
                      label: 'Age',
                      value: selectedAgeCategory,
                      onTap: () => _showAgeSelection(context),
                      fieldScale: fieldScale,
                    ),
                  ),
                  SizedBox(width: 12 * fieldScale),
                  // Breed Button
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

              // Description section
              Text(
                "Description",
                style: TextStyle(
                  fontSize: 16 * fieldScale,
                  // fontWeight: FontWeight.bold,
                  fontFamily: 'Archivo',
                  color: Colors.black,
                ),
              ),
              Divider(color: Colors.black),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: TextField(
                  controller: descriptionController,
                  maxLines: 3,
                  style: TextStyle(
                    // fontFamily: 'ArchivoBlack',
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    hintText: "Enter pet description",
                    hintStyle: TextStyle(color: Colors.black54),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(12 * fieldScale),
                  ),
                ),
              ),
              SizedBox(height: 15 * fieldScale),

              // Health Documents section
              SizedBox(height: 20),
              Text("Health Documents",
                  style: TextStyle(
                      fontSize: 16 * fieldScale, fontFamily: 'Archivo')),
              HealthDocumentsUploader(),

              SizedBox(height: 30 * fieldScale),

              // Tags section
              Text(
                "Choose the best tags to describe the pet",
                style: TextStyle(
                  fontSize: 15 * fieldScale,
                  fontFamily: 'Archivo',
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 12 * fieldScale),

              // Size tags
              _buildBoneTagRow(["small", "medium", "large"], fieldScale),
              SizedBox(height: 12 * fieldScale),

              // Personality tags
              _buildBoneTagRow(
                  ["adventurous", "chill", "family pet"], fieldScale),
              SizedBox(height: 12 * fieldScale),

              // Status tags
              _buildBoneTagRow(
                  ["trained", "vaccinated", "playful"], fieldScale),
              SizedBox(height: 24 * fieldScale),

              // Complete Registration button
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 40 * fieldScale),
                child: ElevatedButton(
                  onPressed: () {
                    // Handle registration completion
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFFF581),
                    padding: EdgeInsets.symmetric(
                      vertical: 14 * fieldScale,
                      horizontal: 24 * fieldScale,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Complete Registration",
                    style: TextStyle(
                      fontSize: 16 * fieldScale,
                      fontFamily: 'Archivo',
                      color: Colors.black,
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
            fontFamily: 'Archivo',
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
                Icon(
                  Icons.arrow_drop_down,
                  size: 20 * fieldScale,
                  color: Colors.black,
                ),
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
    final boneWidth = 113;
    final boneHeight = 50;
    return GestureDetector(
      onTap: () {
        // Handle tag selection
      },
      child: SizedBox(
        width: boneWidth * fieldScale,
        height: boneHeight * fieldScale,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Colored bone shape

            ColorFiltered(
              colorFilter: ColorFilter.mode(
                color.withOpacity(0.6),
                BlendMode.srcATop,
              ),
              child: Image.asset(
                'assets/images/bone.png', // Your bone asset
                width: boneWidth * fieldScale,
                height: boneHeight * fieldScale,
                fit: BoxFit.contain,
                // color: Color(0xFFFFC0CB),
              ),
            ),
            // Text
            Text(
              text.toLowerCase(),
              style: TextStyle(
                fontSize: 12 * fieldScale,
                fontFamily: 'Archivo',
                color: Colors.black,
                fontWeight: FontWeight.bold,
                // shadows: [
                //   Shadow(
                //     color: Colors.white.withOpacity(0.7),
                //     blurRadius: 2,
                //     offset: Offset(1, 1),
                //   ),
                // ],
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

  void _showImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 150,
          decoration: BoxDecoration(
              //image: DecorationImage(
              //image: AssetImage('assets/images/Login_SignUp_Background.png'),
              //fit: BoxFit.cover,
              //),
              ),
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.photo_library, color: Colors.black),
                title: Text(
                  'Choose from Gallery',
                  style: TextStyle(
                    // fontFamily: 'ArchivoBlack',
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt, color: Colors.black),
                title: Text(
                  'Take a Photo',
                  style: TextStyle(
                    // fontFamily: 'ArchivoBlack',
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
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

