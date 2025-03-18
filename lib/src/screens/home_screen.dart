import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semester_project__uprm_pet_adoption/src/widgets/pet_card.dart';
import 'package:semester_project__uprm_pet_adoption/src/providers/auth_provider.dart';
import 'package:semester_project__uprm_pet_adoption/src/widgets.dart';
import 'package:semester_project__uprm_pet_adoption/src/widgets/home_top_bar.dart';

//This file contains the Home Screen class. Everything that shows up in the home screen is managed here.
class PetStackNotifier extends StateNotifier<List<PetCard>> {
  PetStackNotifier() : super(_initialPets());
  static List<PetCard> _initialPets() => [
        PetCard(

                        petName: "Ronnie",
                        petBreed: "Labrador",
                        petAge: "Puppy",
                        petImages: [
                          "assets/images/temp_dog_img.jpg",
                          "assets/images/temp_dog_img2.jpg",
                        ],
                        petDescription:
                            "My name is Ronnie and I am looking for a loving home!",
                        petTags: ["Labrador", "Puppy"],
                        isFavorite: false,
                        onFavoriteToggle: () {
                          print("Favorite toggled!");
                        },
                        onAdopt: () {
                          print("Adoption started!");
                        },
                        onAccept: () {
                          print("Pet Accepted!");
                        },
                        onReject: () {
                          print("Pet Rejected!");
                        },
                      ),
          PetCard(
            petName: "Luna",
            petBreed: "Golden Retriever",
            petAge: "Young Adult",
            petImages: [
              "assets/images/pet_placeholder.png",
              
            ],
            petDescription: "Hi, I'm Luna! I'm a playful and friendly dog who loves belly rubs.",
            petTags: ["Golden Retriever", "Young Adult"],
            isFavorite: true,
            onFavoriteToggle: () {
              print("Luna favorite toggled!");
            },
            onAdopt: () {
              print("Adoption started for Luna!");
            },
            onAccept: () {
              print("Luna Accepted!");
            },
            onReject: () {
              print("Luna Rejected!");
            },
          ),          
          PetCard(
            petName: "Ronnie",
                        petBreed: "Labrador",
                        petAge: "Puppy",
                        petImages: [
                          "assets/images/temp_dog_img.jpg",
                          "assets/images/temp_dog_img2.jpg",
                        ],
                        petDescription: "My name is Ronnie and I am looking for a loving home!",
                        petTags: ["Labrador", "Puppy"],
                        isFavorite: false,
                        onFavoriteToggle: () {
                          print("Favorite toggled!");
                        },
                        onAdopt: () {
                          print("Adoption started!");
                        },
                        onAccept: () {
                          print("Pet Accepted!");
                        },
                        onReject: () {
                          print("Pet Rejected!");
                        },
          ),
          PetCard(
            petName: "Luna",
            petBreed: "Golden Retriever",
            petAge: "Young Adult",
            petImages: [
              "assets/images/pet_placeholder.png",
              "assets/images/temp_dog_img.jpg",
            ],
            petDescription: "Hi, I'm Luna! I'm a playful and friendly dog who loves belly rubs.",
            petTags: ["Golden Retriever", "Young Adult"],
            isFavorite: true,
            onFavoriteToggle: () {
              print("Luna favorite toggled!");
            },
            onAdopt: () {
              print("Adoption started for Luna!");
            },
            onAccept: () {
              print("Luna Accepted!");
            },
            onReject: () {
              print("Luna Rejected!");
            },
          ),
      ];

  void removeTopPet() {
    if (state.isNotEmpty) {
      state = [...state]..removeLast();
    }
  }

  PetCard? get currentPet => state.isNotEmpty ? state.last : null;
}

final petStackProvider =
    StateNotifierProvider<PetStackNotifier, List<PetCard>>((ref) {
  return PetStackNotifier();
});
class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  final petCardIndexProvider = StateProvider<int>((ref) => 0);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final petList = ref.watch(petStackProvider);
    final currentPet = petList.isNotEmpty ? petList.last : null;
    return Scaffold(
      //Header
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80), // Set desired height
        child: TopNavBar(selectedIndex: 0), // Pass the current selected index
      ),

      body: SafeArea(
        child: Container(
        // Background
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Login_SignUp_Background.png'),
            fit: BoxFit.cover,
          ),
        ),

        // Main layout: Column with header, middle content, and footer
        child: Column(
          children: [
       


            // Middle content centered in remaining space
            Expanded(
              child: Center(
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(10),
                  color: Colors.orangeAccent.withOpacity(0.4),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Suggested Pet Placeholder",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 15),
                      // AnimatedSwitcher to switch between cards
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 5),

                        child: currentPet != null
                            ? PetCard(
                                key: ValueKey(currentPet.petName), // 👈 THIS is important!
                                petName: currentPet.petName,
                                petBreed: currentPet.petBreed,
                                petAge: currentPet.petAge,
                                petImages: currentPet.petImages,
                                petDescription: currentPet.petDescription,
                                petTags: currentPet.petTags,
                                isFavorite: currentPet.isFavorite,
                                onFavoriteToggle: () {

                                  print("${currentPet.petName} favorite toggled: ${currentPet.isFavorite}");
                                  ref.invalidate(petCardIndexProvider); // Force rebuild if needed
                                },
                                onAdopt: () {
                                  print("Adoption started for ${currentPet.petName}!");
                                },
                                onAccept: () {
                                  
                                  print("${currentPet.petName} Accepted!");
                                  ref.read(petStackProvider.notifier).removeTopPet();
                                  
                                  
                                  
                                },
                                onReject: () {
                                  
                                  print("${currentPet.petName} Rejected!");

                                   ref.read(petStackProvider.notifier).removeTopPet();
                                   //ref.read(petCardIndexProvider.notifier).state++;
                                  
                                  
                                },
                              )
                            : const Text("No more pets to show!",style: TextStyle(fontSize: 20,),),
                      ),
                      const SizedBox(height: 30),
                      TextButton(
                        onPressed: () => context.go('/matchmaking'),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          backgroundColor: Colors.transparent,
                        ),
                        child: Image.asset(
                          'assets/images/Find_Pawfect_Match_button.png',
                          width: 300,
                          height: 120,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
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
}





// <<<<<<< HEAD
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//         // Background
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('assets/images/Login_SignUp_Background.png'),
//             fit: BoxFit.cover,
//           ),
//         ),

//         // Main layout: Column with header, middle content, and footer
//         child: Column(
//           children: [
//             // Header
//             Container(
//               height: 80,
//               width: double.infinity,
//               color: Colors.white.withOpacity(0.8),
//               alignment: Alignment.center,
//               child: const Text(
//                 "Header Placeholder",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//             ),

//             // Middle content centered in remaining space
//             Expanded(
//               child: Center(
//                 child: Container(
//                   width: double.infinity,
//                   margin: const EdgeInsets.symmetric(horizontal: 20),
//                   padding: const EdgeInsets.all(10),
//                   color: Colors.orangeAccent.withOpacity(0.4),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       const Text(
//                         "Suggested Pet Placeholder",
//                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(height: 15),
//                       PetCard(
// =======

 
// class HomeScreen extends ConsumerWidget {
//    HomeScreen({super.key});

//  final petCardIndexProvider = StateProvider<int>((ref) => 0);




// // final List<PetCard> petList = [
// //           PetCard(
// //                         petName: "Ronnie",
// //                         petBreed: "Labrador",
// //                         petAge: "Puppy",
// //                         petImages: [
// //                           "assets/images/temp_dog_img.jpg",
// //                           "assets/images/temp_dog_img2.jpg",
// //                         ],
// //                         petDescription: "My name is Ronnie and I am looking for a loving home!",
// //                         petTags: ["Labrador", "Puppy"],
// //                         isFavorite: false,
// //                         onFavoriteToggle: () {
// //                           print("Favorite toggled!");
// //                         },
// //                         onAdopt: () {
// //                           print("Adoption started!");
// //                         },
// //                         onAccept: () {
// //                           print("Pet Accepted!");
// //                         },
// //                         onReject: () {
// //                           print("Pet Rejected!");
// //                         },
// //                       ),
// //           PetCard(
// //             petName: "Luna",
// //             petBreed: "Golden Retriever",
// //             petAge: "Young Adult",
// //             petImages: [
// //               "assets/images/pet_placeholder.png",
              
// //             ],
// //             petDescription: "Hi, I'm Luna! I'm a playful and friendly dog who loves belly rubs.",
// //             petTags: ["Golden Retriever", "Young Adult"],
// //             isFavorite: true,
// //             onFavoriteToggle: () {
// //               print("Luna favorite toggled!");
// //             },
// //             onAdopt: () {
// //               print("Adoption started for Luna!");
// //             },
// //             onAccept: () {
// //               print("Luna Accepted!");
// //             },
// //             onReject: () {
// //               print("Luna Rejected!");
// //             },
// //           ),          
// //           PetCard(
// //             petName: "Ronnie",
// //                         petBreed: "Labrador",
// //                         petAge: "Puppy",
// //                         petImages: [
// //                           "assets/images/temp_dog_img.jpg",
// //                           "assets/images/temp_dog_img2.jpg",
// //                         ],
// //                         petDescription: "My name is Ronnie and I am looking for a loving home!",
// //                         petTags: ["Labrador", "Puppy"],
// //                         isFavorite: false,
// //                         onFavoriteToggle: () {
// //                           print("Favorite toggled!");
// //                         },
// //                         onAdopt: () {
// //                           print("Adoption started!");
// //                         },
// //                         onAccept: () {
// //                           print("Pet Accepted!");
// //                         },
// //                         onReject: () {
// //                           print("Pet Rejected!");
// //                         },
// //           ),
// //           PetCard(
// //             petName: "Luna",
// //             petBreed: "Golden Retriever",
// //             petAge: "Young Adult",
// //             petImages: [
// //               "assets/images/pet_placeholder.png",
// //               "assets/images/temp_dog_img.jpg",
// //             ],
// //             petDescription: "Hi, I'm Luna! I'm a playful and friendly dog who loves belly rubs.",
// //             petTags: ["Golden Retriever", "Young Adult"],
// //             isFavorite: true,
// //             onFavoriteToggle: () {
// //               print("Luna favorite toggled!");
// //             },
// //             onAdopt: () {
// //               print("Adoption started for Luna!");
// //             },
// //             onAccept: () {
// //               print("Luna Accepted!");
// //             },
// //             onReject: () {
// //               print("Luna Rejected!");
// //             },
// //           ),
// // ];



//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // final currentIndex = ref.watch(petCardIndexProvider);
//     final petList = ref.watch(petStackProvider);
//     final currentPet = petList.isNotEmpty ? petList.last : null;
//     // final currentPet = currentIndex < petList.length ? petList[currentIndex] : null;
//     // PetCard currentPet = petList.removeLast();
//     print("removed1");

//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('assets/images/Login_SignUp_Background.png'),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             // Header
//             Container(
//               height: 80,
//               width: double.infinity,
//               color: Colors.white.withOpacity(0.8),
//               alignment: Alignment.center,
//               child: const Text(
//                 "Header Placeholder",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//             ),

//             // Middle content
//             Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Container(
//                   width: double.infinity,
//                   margin: const EdgeInsets.symmetric(horizontal: 20),
//                   padding: const EdgeInsets.all(10),
//                   color: Colors.orangeAccent.withOpacity(0.4),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       const Text(
//                         "Suggested Pet Placeholder",
//                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(height: 15),

//                       // AnimatedSwitcher to switch between cards
//                       AnimatedSwitcher(
//                         duration: const Duration(milliseconds: 5),

//                         child: currentPet != null
//                             ? PetCard(
//                                 key: ValueKey(currentPet.petName), // 👈 THIS is important!
//                                 petName: currentPet.petName,
//                                 petBreed: currentPet.petBreed,
//                                 petAge: currentPet.petAge,
//                                 petImages: currentPet.petImages,
//                                 petDescription: currentPet.petDescription,
//                                 petTags: currentPet.petTags,
//                                 isFavorite: currentPet.isFavorite,
//                                 onFavoriteToggle: () {

//                                   print("${currentPet.petName} favorite toggled: ${currentPet.isFavorite}");
//                                   ref.invalidate(petCardIndexProvider); // Force rebuild if needed
//                                 },
//                                 onAdopt: () {
//                                   print("Adoption started for ${currentPet.petName}!");
//                                 },
//                                 onAccept: () {
                                  
//                                   print("${currentPet.petName} Accepted!");
//                                   ref.read(petStackProvider.notifier).removeTopPet();
                                  
                                  
                                  
//                                 },
//                                 onReject: () {
                                  
//                                   print("${currentPet.petName} Rejected!");

//                                    ref.read(petStackProvider.notifier).removeTopPet();
//                                    //ref.read(petCardIndexProvider.notifier).state++;
                                  
                                  
//                                 },
//                               )
//                             : const Text("No more pets to show!",style: TextStyle(fontSize: 20,),),
//                       ),

//                       const SizedBox(height: 30),

// >>>>>>> Home_screen_integrate_PetCard
//                       TextButton(
//                         onPressed: () => context.go('/matchmaking'),
//                         style: TextButton.styleFrom(
//                           padding: EdgeInsets.zero,
//                           backgroundColor: Colors.transparent,
//                         ),
//                         child: Image.asset(
//                           'assets/images/Find_Pawfect_Match_button.png',
//                           width: 300,
//                           height: 120,
//                           fit: BoxFit.contain,
//                         ),
//                       ),
// <<<<<<< HEAD
// =======

// >>>>>>> Home_screen_integrate_PetCard
//                       const SizedBox(height: 20),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
            

//         ),
//       ),
//       bottomNavigationBar: const BottomNavBar(selectedIndex: 0),

//     );
//     // return Scaffold(
//     //   body: Container(
//     //     // Background
//     //     decoration: const BoxDecoration(
//     //       image: DecorationImage(
//     //         image: AssetImage('assets/images/Login_SignUp_Background.png'),
//     //         fit: BoxFit.cover,
//     //       ),
//     //     ),

//     //     // Main layout: Column with header, middle content, and footer
//     //     child: Column(
//     //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     //       children: [
//     //         // Header
//     //         Container(
//     //           height: 80,
//     //           width: double.infinity,
//     //           color: Colors.white.withOpacity(0.8),
//     //           alignment: Alignment.center,
//     //           child: const Text(
//     //             "Header Placeholder",
//     //             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//     //           ),
//     //         ),

//     //         // Middle content
//     //         Column(
//     //           mainAxisSize: MainAxisSize.min,
//     //           children: [
//     //             // "Suggested Pet" placeholder
//     //             Container(
//     //               width: double.infinity,
//     //               margin: const EdgeInsets.symmetric(horizontal: 20),
//     //               padding: const EdgeInsets.all(10),
//     //               color: Colors.orangeAccent.withOpacity(0.4),
//     //               child: Column(
//     //                 mainAxisSize: MainAxisSize.min,
//     //                 children: [
//     //                   const Text(
//     //                     "Suggested Pet Placeholder",
//     //                     style: TextStyle(
//     //                         fontSize: 18, fontWeight: FontWeight.bold),
//     //                   ),
//     //                   const SizedBox(height: 15),
//     //                   /// **Displays a pet card with swipe-based interaction**
//     //                   ///
//     //                   /// - Swiping **right** triggers `onAccept` (Pet is accepted).
//     //                   /// - Swiping **left** triggers `onReject` (Pet is rejected).
//     //                   /// - Clicking the heart icon toggles the **favorite status**.
//     //                   /// - The card includes an **image carousel** for browsing pet pictures.
//     //                   AnimatedSwitcher(
//     //                     duration: const Duration(milliseconds: 300),
//     //                     child: currentPet != null
//     //                         ? PetCard(
//     //                             key: ValueKey(currentPet.petName),
//     //                             petName: currentPet.petName,
//     //                             petBreed: currentPet.petBreed,
//     //                             petAge: currentPet.petAge,
//     //                             petImages: currentPet.petImages,
//     //                             petDescription: currentPet.petDescription,
//     //                             petTags: currentPet.petTags,
//     //                             isFavorite: currentPet.isFavorite,
//     //                             onFavoriteToggle: () {
                                  
//     //                               print("${currentPet.petName} favorite toggled: ${currentPet.isFavorite}");
//     //                             },
//     //                             onAdopt: () {
//     //                               print("Adoption started for ${currentPet.petName}!");
//     //                             },
//     //                             onAccept: () {
//     //                               print("removed2");
                                  
//     //                               print("${currentPet.petName} Accepted!");
//     //                               print(currentIndex);
//     //                               // ref.read(petCardIndexProvider.notifier).state++;
//     //                               print(currentIndex);
//     //                               setState() {ref.read(petCardIndexProvider.notifier).state++;};
//     //                             },
//     //                             onReject: () {
//     //                               print("removed3");
                                  
//     //                               print("${currentPet.petName} Rejected!");
//     //                               setState() {ref.read(petCardIndexProvider.notifier).state++;};
//     //                               // ref.read(petCardIndexProvider.notifier).state++;
//     //                             },


//     //                           )
//     //                         : const Text("No more pets to show!"),
                                                           
//     //                   ),

//     //                   const SizedBox(height: 30),
                    

//     //             // "Find Pawfect Match" button - navigates to match_making_screen.dart
//     //             TextButton(
//     //               onPressed: () => context.go('/matchmaking'),
//     //               style: TextButton.styleFrom(
//     //                 padding: EdgeInsets.zero,
//     //                 backgroundColor: Colors.transparent,
//     //               ),
//     //               child: Image.asset(
//     //                 'assets/images/Find_Pawfect_Match_button.png',
//     //                 width: 300, // Increase or decrease as needed
//     //                 height: 120, // Increase or decrease as needed
//     //                 fit: BoxFit.contain,
//     //               ),
//     //             ),

//     //             const SizedBox(height: 20),
//     //                 ],
//     //               ),
//     //             ),
//     //           ],
//     //         ),

//     //         // Footer
//     //         Container(
//     //           height: 60,
//     //           width: double.infinity,
//     //           color: Colors.white.withOpacity(0.8),
//     //           alignment: Alignment.center,
//     //           child: const Text(
//     //             "Footer Placeholder",
//     //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//     //           ),
//     //         ),
//     //       ],
//     //     ),
//     //   ),
//     // );
//   }
// }
