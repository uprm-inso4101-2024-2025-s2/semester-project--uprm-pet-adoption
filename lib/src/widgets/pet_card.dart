import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as legacy_provider;
import 'package:semester_project__uprm_pet_adoption/src/preference_manager.dart';

/// PetCard Widget
/// -----------------
/// This widget represents a pet card with a picture carousel that supports
/// left and right swipe interactions.
/// ```dart
/// PetCard(
/// required this.petName,
/// required this.petBreed,
/// required this.petAge,
/// required this.petImages,
/// required this.petDescription,
/// required this.petTags,
/// required this.isFavorite,
/// required this.onFavoriteToggle,
/// required this.onAdopt,
/// required this.onAccept,
/// required this.onReject,
/// ```
///
/// **Key Notes:**
/// - `PetCard` is a **widget**, not a full screen.
/// - Any layout modifications should be made in the screen where it is used, not here.
/// - It supports interactive features like toggling favorites and swipe actions.

/*class PetCard extends StatefulWidget {
  final String petName;
  final String petBreed;
  final String petAge;
  final List<String> petImages;
  final String petDescription;
  final List<String> petTags;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;
  final VoidCallback onAdopt;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const PetCard({
    Key? key,
    required this.petName,
    required this.petBreed,
    required this.petAge,
    required this.petImages,
    required this.petDescription,
    required this.petTags,
    required this.isFavorite,
    required this.onFavoriteToggle,
    required this.onAdopt,
    required this.onAccept,
    required this.onReject,
  }) : super(key: key);

  @override
  _PetCardState createState() => _PetCardState();
}

class _PetCardState extends State<PetCard> with SingleTickerProviderStateMixin {
  late PageController _pageController;
  int _currentPage = 0;
  bool _isFavorite = false;
  Offset _dragOffset = Offset.zero;
  double _opacity = 1.0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _isFavorite = widget.isFavorite;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
    widget.onFavoriteToggle();
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    setState(() {
      _dragOffset += details.delta;

      _opacity = (1.0 - (_dragOffset.dx.abs() / 200)).clamp(0.0, 1.0);
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    if (_dragOffset.dx > 100) {
      widget.onAccept(); // Swipe right - Accept
    } else if (_dragOffset.dx < -100) {
      widget.onReject(); // Swipe left - Reject
    }
    setState(() {
      _dragOffset = Offset.zero;
      _opacity = 1.0;
      
    });
  }


  @override
  Widget build(BuildContext context) {
     // Access preferences
    final preferences =  legacy_provider.Provider.of<PreferenceManager>(context, listen: false);
    final preferredAge = preferences.preferredAge;
    final preferredBreed = preferences.preferredBreed;

    // Check if pet matches preferences
    final bool matchesPreferences = 
      (preferredAge == null || widget.petAge.contains(preferredAge)) &&
      (preferredBreed == null || widget.petBreed.contains(preferredBreed));
    return GestureDetector(
     onHorizontalDragUpdate: _onHorizontalDragUpdate,
     onHorizontalDragEnd: _onHorizontalDragEnd,
     child: AnimatedOpacity(
     duration: Duration(milliseconds: 200),
     opacity: _opacity,
     child: Transform.translate(
      offset: _dragOffset,
      child: Card(
        color: matchesPreferences 
            ? Colors.yellow[100]?.withOpacity(0.8) // Highlight matches
            : Colors.yellow[100], // Regular color
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: matchesPreferences
              ? BorderSide(color: Colors.blue, width: 2) // Blue border for matches
              : BorderSide.none,),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    'Suggested for you',
                    style:
                    TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Stack(
                    children: [
                      // Image Slider
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: SizedBox(
                          height: 250,
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: widget.petImages.length,
                            onPageChanged: (index) {
                              setState(() => _currentPage = index);
                            },
                            itemBuilder: (context, index) {
                              return Image.asset(
                                widget.petImages[index],
                                width: double.infinity,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                      ),

                       // Add this new Positioned widget for the preference badge
                      if (matchesPreferences)
                          Positioned(
                            top: 10,
                            left: 10,
                            child: Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                      ),

                      // Favorite Button (Top Right)
                      Positioned(
                        top: 10,
                        right: 10,
                        child: GestureDetector(
                          onTap: _toggleFavorite,
                          child: Icon(
                            _isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: _isFavorite ? Colors.pinkAccent : Colors.pinkAccent,
                            size: 30,
                          ),
                        ),
                      ),

                      // Pet Tags
                      Positioned(
                        top: 15,
                        left: -10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: widget.petTags.map((tag) {
                            return Container(
                              margin: EdgeInsets.only(bottom: 5),
                              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 3,
                                    offset: Offset(2, 2),
                                  ),
                                ],
                              ),
                              child: Text(
                                tag,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),

                      // Pet Description Overlay
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                          ),
                          child: Text(
                            widget.petDescription,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Page Indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(widget.petImages.length, (index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 3, vertical: 5),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentPage == index ? Colors.blue : Colors.grey,
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  
}*/

class PetCard extends ConsumerStatefulWidget {
  // ... rest of your PetCard properties
  final String petName;
  final String petBreed;
  final String petAge;
  final List<String> petImages;
  final String petDescription;
  final List<String> petTags;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;
  final VoidCallback onAdopt;
  final VoidCallback onAccept;
  final VoidCallback onReject;
  
  const PetCard({
    Key? key,
    required this.petName,
    required this.petBreed,
    required this.petAge,
    required this.petImages,
    required this.petDescription,
    required this.petTags,
    required this.isFavorite,
    required this.onFavoriteToggle,
    required this.onAdopt,
    required this.onAccept,
    required this.onReject,
  }) : super(key: key);

  @override
  ConsumerState<PetCard> createState() => _PetCardState();
}

class _PetCardState extends ConsumerState<PetCard> with SingleTickerProviderStateMixin {
  // ... rest of your existing state code
  late PageController _pageController;
  int _currentPage = 0;
  bool _isFavorite = false;
  Offset _dragOffset = Offset.zero;
  double _opacity = 1.0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _isFavorite = widget.isFavorite;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
    widget.onFavoriteToggle();
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    setState(() {
      _dragOffset += details.delta;

      _opacity = (1.0 - (_dragOffset.dx.abs() / 200)).clamp(0.0, 1.0);
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    if (_dragOffset.dx > 100) {
      widget.onAccept(); // Swipe right - Accept
    } else if (_dragOffset.dx < -100) {
      widget.onReject(); // Swipe left - Reject
    }
    setState(() {
      _dragOffset = Offset.zero;
      _opacity = 1.0;
      
    });
  }

  @override
  Widget build(BuildContext context) {
    // Access preferences using Riverpod
    final preferences = ref.watch(preferenceManagerProvider);
    final preferredAge = preferences.preferredAge;
    final preferredBreed = preferences.preferredBreed;

    // Check if pet matches preferences
    final bool matchesPreferences = 
      (preferredAge == null || widget.petAge.contains(preferredAge)) &&
      (preferredBreed == null || widget.petBreed.contains(preferredBreed));
      return GestureDetector(
     onHorizontalDragUpdate: _onHorizontalDragUpdate,
     onHorizontalDragEnd: _onHorizontalDragEnd,
     child: AnimatedOpacity(
     duration: Duration(milliseconds: 200),
     opacity: _opacity,
     child: Transform.translate(
      offset: _dragOffset,
      child: Card(
        color: matchesPreferences 
            ? Colors.yellow[100]?.withOpacity(0.8) // Highlight matches
            : Colors.yellow[100], // Regular color
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: matchesPreferences
              ? BorderSide(color: Colors.blue, width: 2) // Blue border for matches
              : BorderSide.none,),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    'Suggested for you',
                    style:
                    TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Stack(
                    children: [
                      // Image Slider
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: SizedBox(
                          height: 250,
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: widget.petImages.length,
                            onPageChanged: (index) {
                              setState(() => _currentPage = index);
                            },
                            itemBuilder: (context, index) {
                              return Image.asset(
                                widget.petImages[index],
                                width: double.infinity,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                      ),

                       // Add this new Positioned widget for the preference badge
                      if (matchesPreferences)
                          Positioned(
                            top: 10,
                            left: 10,
                            child: Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                      ),

                      // Favorite Button (Top Right)
                      Positioned(
                        top: 10,
                        right: 10,
                        child: GestureDetector(
                          onTap: _toggleFavorite,
                          child: Icon(
                            _isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: _isFavorite ? Colors.pinkAccent : Colors.pinkAccent,
                            size: 30,
                          ),
                        ),
                      ),

                      // Pet Tags
                      Positioned(
                        top: 15,
                        left: -10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: widget.petTags.map((tag) {
                            return Container(
                              margin: EdgeInsets.only(bottom: 5),
                              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 3,
                                    offset: Offset(2, 2),
                                  ),
                                ],
                              ),
                              child: Text(
                                tag,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),

                      // Pet Description Overlay
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                          ),
                          child: Text(
                            widget.petDescription,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Page Indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(widget.petImages.length, (index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 3, vertical: 5),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentPage == index ? Colors.blue : Colors.grey,
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

