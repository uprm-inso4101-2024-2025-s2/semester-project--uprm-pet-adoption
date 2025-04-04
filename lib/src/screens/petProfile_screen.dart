import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PetProfile extends StatefulWidget {
  const PetProfile({super.key});

  @override
  _PetProfileState createState() => _PetProfileState();
}

class _PetProfileState extends State<PetProfile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController breedController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  
  String selectedAge = "0";
  String selectedAgeType = "weeks";
  bool showOtherAgeField = false;
  final TextEditingController otherAgeController = TextEditingController();
  ImageProvider? petAvatarImage;

  final List<int> ageValues = List.generate(51, (index) => index + 2); // 2-52 weeks
  final List<String> ageTypes = ["weeks", "months", "years", "other"];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final fieldScale = screenHeight < 700 ? 0.8 : 1.0; // Scale factor for smaller screens

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Pet Profile',
          style: TextStyle(
            fontSize: 24 * fieldScale,
            fontWeight: FontWeight.bold,
            fontFamily: 'ArchivoBlack',
            color: Colors.black,
          ),
        ),
        backgroundColor: Color(0xFFFFF581),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.go('/'),
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
                      radius: 40 * fieldScale,
                      backgroundColor: Colors.white.withOpacity(0.8),
                      backgroundImage: petAvatarImage ?? AssetImage('assets/images/default_pet_avatar.png'),
                      child: petAvatarImage == null 
                          ? Icon(Icons.pets, size: 30 * fieldScale, color: Colors.grey)
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
                        child: Icon(Icons.camera_alt, size: 16 * fieldScale, color: Colors.black),
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
                        fontWeight: FontWeight.bold,
                        fontFamily: 'ArchivoBlack',
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
                          fontWeight: FontWeight.bold,
                          fontFamily: 'ArchivoBlack',
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
                      label: "Age",
                      value: showOtherAgeField 
                        ? otherAgeController.text 
                        : "$selectedAge $selectedAgeType",
                      onTap: () => _showAgeSelection(context),
                      fieldScale: fieldScale,
                    ),
                  ),
                  SizedBox(width: 12 * fieldScale),
                  // Breed Button
                  Expanded(
                    child: _buildButtonWithLabel(
                      label: "Breed",
                      value: breedController.text.isEmpty ? "Select" : breedController.text,
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
                  fontWeight: FontWeight.bold,
                  fontFamily: 'ArchivoBlack',
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
                    fontFamily: 'ArchivoBlack',
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
              SizedBox(height: 20 * fieldScale),
              
              // Health Documents section
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
                      icon: Icon(Icons.add, size: 24 * fieldScale, color: Colors.black),
                      onPressed: () {},
                    ),
                    SizedBox(width: 8 * fieldScale),
                    Expanded(
                      child: LinearProgressIndicator(
                        value: 0.7,
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                      ),
                    ),
                    SizedBox(width: 8 * fieldScale),
                    Text("70%", style: TextStyle(
                      fontSize: 14 * fieldScale,
                      fontFamily: 'ArchivoBlack',
                      color: Colors.black,
                    )),
                  ],
                ),
              ),
              SizedBox(height: 20 * fieldScale),
              
              // Tags section
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
              
              // Size tags
              _buildBoneTagRow(["small", "medium", "large"], fieldScale),
              SizedBox(height: 12 * fieldScale),
              
              // Personality tags
              _buildBoneTagRow(["adventurous", "chill", "family pet"], fieldScale),
              SizedBox(height: 12 * fieldScale),
              
              // Status tags
              _buildBoneTagRow(["trained", "vaccinated", "playful"], fieldScale),
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
                      fontFamily: 'ArchivoBlack',
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
                    fontFamily: 'ArchivoBlack',
                    color: Colors.black,
                  ),
                ),
                Icon(Icons.arrow_drop_down, 
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
  return GestureDetector(
    onTap: () {
      // Handle tag selection
    },
    child: BoneTag(
      text: text,
      color: color,
      scale: fieldScale,
    ),
  );
  } 


  Color _getTagColor(String tag) {
    switch (tag.toLowerCase()) {
      case 'small':
      case 'medium':
      case 'large':
        return Color(0xFF82B0FF); // Blue for size
      case 'adventurous':
      case 'chill':
      case 'family pet':
        return Color(0xFFFFA082); // Orange for personality
      case 'trained':
      case 'vaccinated':
      case 'playful':
        return Color(0xFFA0FF82); // Green for status
      default:
        return Colors.purple;
    }
  }

  void _showImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 150,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/Login_SignUp_Background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.photo_library, color: Colors.black),
                title: Text('Choose from Gallery', 
                  style: TextStyle(
                    fontFamily: 'ArchivoBlack',
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt, color: Colors.black),
                title: Text('Take a Photo', 
                  style: TextStyle(
                    fontFamily: 'ArchivoBlack',
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
          padding: EdgeInsets.all(16),
          height: 300,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/Login_SignUp_Background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              // Age type selector
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: selectedAgeType,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedAgeType = newValue!;
                      showOtherAgeField = newValue == "other";
                      if (!showOtherAgeField) {
                        selectedAge = "2";
                      }
                    });
                  },
                  items: ageTypes.map((type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                ),
              ),
              
              if (showOtherAgeField)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      controller: otherAgeController,
                      decoration: InputDecoration(
                        labelText: "Enter custom age",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      ),
                      keyboardType: TextInputType.text,
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ),
                )
              else
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListWheelScrollView(
                      itemExtent: 40,
                      perspective: 0.01,
                      diameterRatio: 1.2,
                      onSelectedItemChanged: (index) {
                        setState(() {
                          selectedAge = ageValues[index].toString();
                        });
                      },
                      children: ageValues.map((age) {
                        return Center(
                          child: Text(
                            age.toString(),
                            style: TextStyle(fontSize: 20),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFFF581),
                ),
                child: Text("Done", style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showBreedSelection(BuildContext context) {
    final commonBreeds = [
      "Labrador Retriever", "German Shepherd", "Golden Retriever",
      "Bulldog", "Beagle", "Poodle", "Rottweiler", "Other"
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

class BoneTag extends StatelessWidget {
  final String text;
  final Color color;
  final double scale;

  const BoneTag({
    required this.text,
    required this.color,
    required this.scale,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Dog bone image with color overlay
        ColorFiltered(
          colorFilter: ColorFilter.mode(
            color.withOpacity(0.3),
            BlendMode.srcATop,
          ),
          child: Image.asset(
            'assets/images/SignUpbutton.png',
            width: 100 * scale,
            height: 40 * scale,
            fit: BoxFit.contain,
          ),
        ),
        // Text on top of the bone
        Padding(
          padding: EdgeInsets.only(bottom: 4 * scale),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12 * scale,
              fontFamily: 'ArchivoBlack',
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}