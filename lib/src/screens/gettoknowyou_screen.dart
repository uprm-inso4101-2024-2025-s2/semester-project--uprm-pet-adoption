import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:semester_project__uprm_pet_adoption/models/user.dart';

import 'package:semester_project__uprm_pet_adoption/src/providers/match_logic.dart';
// // Step 1: Define a GlobalKey
// final GlobalKey<GetToKnowYouScreenState> _getToKnowYouScreenKey = GlobalKey<GetToKnowYouScreenState>();
class GetToKnowYouScreen extends StatefulWidget {
  const GetToKnowYouScreen({Key? key}) : super(key: key);

  @override
  State<GetToKnowYouScreen> createState() => GetToKnowYouScreenState();
}

class GetToKnowYouScreenState extends State<GetToKnowYouScreen> {
  static Map<String, dynamic> userPreferences = {};
  MatchMaker matchMaker = MatchMaker(); 
  int currentStep = 1;

  // Page 1 variables
  String? petType;
  String? ageRange;
  String? size;
  double energyLevel = 0.0;

  // Page 2 variables
  bool? hasExperience;
  bool? hasOtherPets;
  bool? hasAllergies;
  String? livingSituation;
  double timeAvailable = 0.0;

  // Page 3 variables
  String? personality;
  bool? specialCareOk;
  bool? goodWithAnimals;
  bool? goodWithKids;

  void _goNext() {
    setState(() {
      if (currentStep < 3) {
        currentStep++;
      } else {

        matchMaker.generateMatches(pets);
        context.go('/');
      }
    });
  }

  void _goBack() {
    setState(() {
      if (currentStep > 1) {
        currentStep--;
      } else {
        context.pop();
      }
    });
  }

  List<String> _getAgeOptions() {
    if (petType == 'Dog') {
      return ['Puppy', 'Young', 'Adult'];
    } else if (petType == 'Cat') {
      return ['Kitten', 'Young', 'Adult'];
    } else {
      return ['Young', 'Adult'];
    }
  }


  @override
  void initState() {
    super.initState();
    // Initialize the map with default or initial values
    userPreferences = {
      'petType': petType ?? "No pet type", // Handle null case
        'ageRange': ageRange ?? "No age range",
        'size': size ?? "No size",
        'energyLevel':energyLevel,
        'hasExperience': hasExperience ?? false,
        'hasOtherPets': hasOtherPets ?? false,
        'hasAllergies': hasAllergies ?? false,
        'livingSituation': livingSituation ?? "No living situation",
        'timeAvailable': timeAvailable,
        'personality': personality ?? "No personality",
        'specialCareOk': specialCareOk ?? false,
        'goodWithAnimals': goodWithAnimals ?? false,
        'goodWithKids': goodWithKids ?? false,
    };
  }
  Map<String, dynamic> get _userPreferences => userPreferences;

  // Function to update the map when values change
  void updateUserPreferences(String key, dynamic value) {
      setState(() {
        userPreferences[key] = value; // Update the preferences map
      });

      // matchMaker.generateMatches(pets);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade200,
        leading: IconButton(
          tooltip: 'Go back',
          icon: Image.asset(
            'assets/images/Arrow_circle_dms.png',
            width: 32,
            height: 32,
          ),
          onPressed: () {
            context.go('/auth'); // 👈 Directly navigates to the Auth screen
          },
        ),
        title: const Text(
          'Pet Preferences',
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Archivo',
              fontWeight: FontWeight.w900),
        ),
        centerTitle: true,
        actions: const [
          Icon(Icons.help_outline, color: Colors.black),
          SizedBox(width: 12),
        ],
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Progress bar
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Step $currentStep of 3',
                    style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Archivo',
                        fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: currentStep / 3,
                    minHeight: 8,
                    backgroundColor: Colors.grey.shade300,
                    color: Colors.blue.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Step content
              Expanded(
                child: _buildStepContent(),
              ),

              const SizedBox(height: 24),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _goBack,
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        side: const BorderSide(color: Colors.grey),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        'Back',
                        style: TextStyle(
                            fontFamily: 'Archivo',
                            fontWeight: FontWeight.w900,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _goNext,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade300,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                            fontFamily: 'Archivo',
                            fontWeight: FontWeight.w900,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepContent() {
    switch (currentStep) {
      case 1:
        return _buildStep1();
      case 2:
        return _buildStep2();
      case 3:
        return _buildStep3();
      default:
        return Container();
    }
  }

  Widget _buildStep1() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'What type of pet are you looking for?',
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontFamily: 'Archivo',
                fontSize: 18),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Dog card
              GestureDetector(
                onTap: () => setState(() {
                  petType = 'Dog';
                  ageRange = null;
                  updateUserPreferences('petType', 'Dog');
                }),
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: petType == 'Dog'
                          ? Colors.blue.shade300
                          : Colors.grey.shade300,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/dog_icon.png',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 8),
                      const Text('Dog',
                          style: TextStyle(
                              fontFamily: 'Archivo',
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Cat card
              GestureDetector(
                onTap: () => setState(() {
                  petType = 'Cat';
                  ageRange = null;
                  updateUserPreferences('petType', 'Cat');
                }),
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: petType == 'Cat'
                          ? Colors.blue.shade300
                          : Colors.grey.shade300,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/cat_icon.png',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 8),
                      const Text('Cat',
                          style: TextStyle(
                              fontFamily: 'Archivo',
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text('Age Range',
              style: TextStyle(
                  fontWeight: FontWeight.w900, fontFamily: 'Archivo')),
          const SizedBox(height: 8),
          _choiceGroup(_getAgeOptions(),
              selected: ageRange,
              onSelected: (val) => setState(() 
              { ageRange = val;
                updateUserPreferences('ageRange', val);
              }
              )),
          const SizedBox(height: 24),
          const Text('Size',
              style: TextStyle(
                  fontWeight: FontWeight.w900, fontFamily: 'Archivo')),
          const SizedBox(height: 8),
          _choiceGroup(['Small', 'Medium', 'Large', 'No preference'],
              selected: size, onSelected: (val) => setState(() 
              { 
                size = val;
                updateUserPreferences('size', val);
              }
              )),
          const SizedBox(height: 24),
          const Text('Energy Level',
              style: TextStyle(
                  fontWeight: FontWeight.w900, fontFamily: 'Archivo')),
          Slider(
            value: energyLevel,
            onChanged: (value) => setState(() 
            {
             energyLevel = value;
             updateUserPreferences('energyLevel', value);
              
            }
             ),
            divisions: 2,
            activeColor: const Color(0xFFFFF581),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Low', style: TextStyle(fontFamily: 'Archivo')),
              Text('Medium', style: TextStyle(fontFamily: 'Archivo')),
              Text('High', style: TextStyle(fontFamily: 'Archivo')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStep2() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _yesNoQuestion('Do you have experience with pets?', hasExperience,
              (val) => setState(() 
              {
              hasExperience = val;
              updateUserPreferences('hasExperience', val);
              }
              )),
          _yesNoQuestion('Do you have other pets at home?', hasOtherPets,
              (val) => setState(() {
                 hasOtherPets = val;
                 updateUserPreferences('hasOtherPets', val);
              })),
          _yesNoQuestion('Do you have any pet allergies?', hasAllergies,
              (val) => setState(() 
              { hasAllergies = val;
                updateUserPreferences('hasAllergies', val);
              })),
          const SizedBox(height: 16),
          const Text('What is your living situation?',
              style: TextStyle(
                  fontWeight: FontWeight.w900, fontFamily: 'Archivo')),
          const SizedBox(height: 8),
          _choiceGroup(
              ['Apartment', 'House', 'House without yard', 'Rural property'],
              selected: livingSituation,
              onSelected: (val) => setState(() 
              {
                livingSituation = val;
                updateUserPreferences('livingSituation', val);
              
              })),
          const SizedBox(height: 24),
          const Text(
            'How much time daily can you dedicate to your pet?',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontFamily: 'Archivo',
            ),
          ),

// Show the selected hour
          Text(
            '${timeAvailable.toInt()} hour${timeAvailable.toInt() == 1 ? '' : 's'}',
            style: const TextStyle(
              fontFamily: 'Archivo',
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

// Actual slider control
          Slider(
            value: timeAvailable,
            min: 0,
            max: 24,
            divisions: 24,
            label: '${timeAvailable.toInt()}',
            onChanged: (value) {
              setState(() {
                timeAvailable = value;
                updateUserPreferences('timeAvailable', value);
              });
            },
            activeColor: const Color(0xFFFFF581),
          ),

// Optional: scale below
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('0 hour', style: TextStyle(fontFamily: 'Archivo')),
              Text('24 hours', style: TextStyle(fontFamily: 'Archivo')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStep3() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('What kind of personality do you prefer in a pet?',
              style: TextStyle(
                  fontWeight: FontWeight.w900, fontFamily: 'Archivo')),
          const SizedBox(height: 8),
          _choiceGroup(
            [
              'Affectionate and cuddly',
              'Playful and energetic',
              'Calm and independent',
              'Intelligent and Trainable'
            ],
            selected: personality,
            onSelected: (val) => setState(() {

             personality = val;
             updateUserPreferences('personality', val);
            }),
          ),
          const SizedBox(height: 24),
          _yesNoQuestion(
              'Are you comfortable adopting a pet with special care?',
              specialCareOk,
              (val) => setState(() 
              {
                specialCareOk = val;
                updateUserPreferences('specialCareOk', val);
              
              })),
          _yesNoQuestion(
              'Do you want a pet that gets along with other animals?',
              goodWithAnimals,
              (val) => setState(() {
                goodWithAnimals = val;
                updateUserPreferences('goodWithAnimals', val);
              })),
          _yesNoQuestion('Do you want a pet that is good with kids?',
              goodWithKids, (val) => setState(() 
              {
                goodWithKids = val;
                updateUserPreferences('goodWithKids', val);
              })),
        ],
      ),
    );
  }

  Widget _optionCard(String title, IconData icon,
      {bool selected = false, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: selected ? Colors.blue.shade300 : Colors.grey.shade300,
              width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: const Color(0xFFFFF581)),
            const SizedBox(height: 8),
            Text(title,
                style: const TextStyle(
                    fontFamily: 'Archivo', fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  Widget _choiceGroup(List<String> options,
      {String? selected, required void Function(String) onSelected}) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: options.map((option) {
        bool isSelected = selected == option;
        return ChoiceChip(
          label: Text(option, style: const TextStyle(fontFamily: 'Archivo')),
          selected: isSelected,
          onSelected: (_) => onSelected(option),
          selectedColor: Colors.blue.shade300,
          backgroundColor: Colors.white,
        );
      }).toList(),
    );
  }

  Widget _yesNoQuestion(
      String question, bool? selected, void Function(bool) onSelected) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 16),
        Text(question,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontWeight: FontWeight.w900, fontFamily: 'Archivo')),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ChoiceChip(
              label: const Text('Yes', style: TextStyle(fontFamily: 'Archivo')),
              selected: selected == true,
              onSelected: (_) => onSelected(true),
              selectedColor: Colors.blue.shade300,
              backgroundColor: Colors.white,
            ),
            const SizedBox(width: 8),
            ChoiceChip(
              label: const Text('No', style: TextStyle(fontFamily: 'Archivo')),
              selected: selected == false,
              onSelected: (_) => onSelected(false),
              selectedColor: Colors.blue.shade300,
              backgroundColor: Colors.white,
            ),
          ],
        ),
      ],
    );
  }


   
    


}


