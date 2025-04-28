import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:semester_project__uprm_pet_adoption/src/screens/pet_article.dart';


class PetTips extends StatefulWidget {
  const PetTips({Key? key}) : super(key: key);

  @override
  _PetTipsState createState() => _PetTipsState();
}

class _PetTipsState extends State<PetTips> {
  bool _showFavorites = false;
  bool _isFiltered = false;
  final TextEditingController _searchController = TextEditingController();

  // Four tips, two articles
  final List<_PetItem> _allItems = [
    // TIPS
    _PetItem(
      id: 'grooming',
      title: 'GROOMING',
      imagePath: 'assets/images/grooming.png',
      bulletPoints: [
        'Brush your dog’s coat daily to remove dirt, dead hair, and tangles.',
        'Bathe your dog every four weeks, or more often if they get muddy.',
        'Trim your dog’s nails regularly to prevent pain and permanent damage to their toes.',
        'Use a cotton ball and a few drops of cleaning solution to wipe away dirt and wax from your dog’s ears.',
      ],
      itemType: _ItemType.tip,
    ),
    _PetItem(
      id: 'nutrition',
      title: 'NUTRITION',
      imagePath: 'assets/images/nutrition.png',
      bulletPoints: [
        'Provide a balanced diet with proteins, healthy fats, and essential vitamins.',
        'Ensure fresh water is always available.',
        'Avoid toxic foods like chocolate, grapes, onions, and xylitol.',
        'Include fiber-rich veggies and fruits in moderation. Supplement with omega-3 for a healthy coat.',
      ],
      itemType: _ItemType.tip,
    ),
    _PetItem(
      id: 'training',
      title: 'TRAINING',
      imagePath: 'assets/images/training.png',
      bulletPoints: [
        'Reward your dog with praise, treats, or petting immediately after they perform a desired behavior.',
        'Limit training sessions to 15 minutes, or less for adult dogs.',
        'Set a training schedule and stick to it.',
        'Be patient—some skills take time to learn.',
      ],
      itemType: _ItemType.tip,
    ),
    _PetItem(
      id: 'health',
      title: 'HEALTH',
      imagePath: 'assets/images/health.png',
      bulletPoints: [
        'Give your cat a healthy, protein-rich diet that’s low in carbohydrates.',
        'Monitor your cat’s weight and keep it at a healthy level.',
        'Regularly check and treat for parasites, especially if your cat goes outside.',
        'Maintain clean, well-kept litter boxes to prevent issues.',
      ],
      itemType: _ItemType.tip,
    ),

    // ARTICLES
    _PetItem(
      id: 'house_training',
      title: 'HOUSE TRAINING',
      imagePath: 'assets/images/house_training.png',
      bulletPoints: [
        'House training a shelter dog requires consistency, supervision and positive reinforcement.',
        'Establishing a feeding and potty break routine helps predict when your dog needs to go out, while supervision and containment reduce accidents.',
      ],
      itemType: _ItemType.article,
    ),
    _PetItem(
      id: 'helping_shy_dog',
      title: 'HELPING YOUR SHY DOG',
      imagePath: 'assets/images/helping_your_dog.png',
      bulletPoints: [
        'Adopting a fearful or shy dog requires patience and understanding.',
        'Provide a gentle, safe space for your dog to settle, avoid overwhelming them with attention, and use high value treats to encourage confidence.',
      ],
      itemType: _ItemType.article,
    ),
  ];

  // Currently favorited item IDs
  final Set<String> _favoriteIds = {};

  void _toggleFavoriteView() {
    setState(() => _showFavorites = !_showFavorites);
  }

  void _toggleFavorite(String itemId) {
    setState(() {
      if (_favoriteIds.contains(itemId)) {
        _favoriteIds.remove(itemId);
      } else {
        _favoriteIds.add(itemId);
      }
    });
  }

  void _toggleFilter() {
    setState(() => _isFiltered = !_isFiltered);
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {});
  }

  List<_PetItem> _filterItems(List<_PetItem> items) {
    var filtered = items;
    if (_showFavorites) {
      filtered = filtered.where((it) => _favoriteIds.contains(it.id)).toList();
    }
    if (_isFiltered) {
      
    }
    final query = _searchController.text.trim().toLowerCase();
    if (query.isNotEmpty) {
      filtered = filtered.where((item) {
        final inTitle = item.title.toLowerCase().contains(query);
        final inBullets = item.bulletPoints.any((bp) => bp.toLowerCase().contains(query));
        return inTitle || inBullets;
      }).toList();
    }
    return filtered;
  }

  @override
  Widget build(BuildContext context) {

    const mainYellow = Color(0xFFFFF581);

    final displayedItems = _filterItems(_allItems);

    
    final tipItems = displayedItems.where((i) => i.itemType == _ItemType.tip).toList();
    final articleItems = displayedItems.where((i) => i.itemType == _ItemType.article).toList();

    return Scaffold(
      // Large "Pet Tips" text
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 245, 129, 1),
        leading: IconButton(
          icon: Image.asset(
            'assets/images/Arrow_Circle_dms.png',
            width: 30,
            height: 30,
          ),
          onPressed: () => context.go('/'),
        ),
        title: const Text(
          'Pet Tips',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            fontFamily: 'Archivo',
            color: Colors.black,
          ),
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: Container(
        
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/images/paw_pattern.png'),
            fit: BoxFit.cover,
            repeat: ImageRepeat.repeat,
          ),
        ),
        child: Column(
          children: [
         
            Container(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.search, color: Colors.black),
                    onPressed: () {},
                  ),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: 'Search for a pet tip or article',
                        hintStyle: TextStyle(color: Colors.black54),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 0, top: 8),
                      ),
                      style: const TextStyle(color: Colors.black),
                      onChanged: (val) => setState(() {}),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.black),
                    onPressed: _clearSearch,
                  ),
                  IconButton(
                    icon: const Icon(Icons.tune, color: Colors.black),
                    onPressed: _toggleFilter,
                  ),
                  IconButton(
                    icon: const Icon(Icons.bookmark, color: Colors.black),
                    onPressed: _toggleFavoriteView,
                  ),
                ],
              ),
            ),

            if (_showFavorites && _favoriteIds.isEmpty)
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'No favorites yet!',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  children: [
                    // Show tip cards first
                    for (final tip in tipItems)
                      _buildTipCard(
                        item: tip,
                        isFavorited: _favoriteIds.contains(tip.id),
                        onFavoriteToggle: () => _toggleFavorite(tip.id),
                      ),

                    // A centered "Articles" heading (based on your request)
                    if (articleItems.isNotEmpty)
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 12),
                        alignment: Alignment.center,
                        child: const Text(
                          'Articles',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Archivo',
                            color: Colors.black,
                          ),
                        ),
                      ),

                    
                    for (final article in articleItems)
                      _buildArticleCard(
                        item: article,
                        isFavorited: _favoriteIds.contains(article.id),
                        onFavoriteToggle: () => _toggleFavorite(article.id),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

 
  Widget _buildTipCard({
    required _PetItem item,
    required bool isFavorited,
    required VoidCallback onFavoriteToggle,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 244,129, 1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ArrowLabel(
                  label: item.title,
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                  arrowSide: ArrowSide.right,
                ),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // The image
                    Container(
                      width: 120,
                      height: 120,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(255, 255, 255, 1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: Image.asset(
                        item.imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Bullets
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: item.bulletPoints.map(
                          (bp) => _BulletText(text: bp, alignCenter: false),
                        ).toList(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Favorite heart icon
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: onFavoriteToggle,
              child: Icon(
                isFavorited ? Icons.favorite : Icons.favorite_border,
                color: isFavorited ? Colors.red : Colors.black,
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }

  
  Widget _buildArticleCard({
    required _PetItem item,
    required bool isFavorited,
    required VoidCallback onFavoriteToggle,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(130, 176, 255, 1), 
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: Stack(
        children: [
          Padding(
           padding: const EdgeInsets.all(16),
         
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
              
               _ArrowLabel(
                 label: item.title,
                 backgroundColor: Colors.white,
                 textColor: Colors.black,
                 arrowSide: ArrowSide.left,
               ),
               const SizedBox(height: 12),
               Row(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   // The image container
                   Container(
                     width: 120,
                     height: 120,
                     clipBehavior: Clip.antiAlias,
                     decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: BorderRadius.circular(12),
                       border: Border.all(color: Colors.black, width: 2),
                     ),
                     child: Image.asset(
                       item.imagePath,
                       fit: BoxFit.cover,
                     ),
                   ),
                   const SizedBox(width: 16),
                   // Bullets
                   Expanded(
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: item.bulletPoints.map(
                         (bp) => _BulletText(
                           text: bp,
                           alignCenter: false,
                         ),
                       ).toList(),
                     ),
                   ),
                 ],
               ),
               const SizedBox(height: 12),
               // "Read more ->"  botton
               Align(
                 alignment: Alignment.centerRight,
                 child: TextButton(
                   style: TextButton.styleFrom(
                     backgroundColor: const Color.fromRGBO(255, 245, 129, 1),
                     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                   ),
                   onPressed: () {
                     Navigator.push(
                       context,
                       MaterialPageRoute(
                         builder: (context) => PetArticle(
                           title: item.title,
                           bulletPoints: item.bulletPoints,
                           imagePath: item.imagePath,
                         ),
                       ),
                     );
                   },
                   child: const Text("Read More"),
                  //   style: TextStyle(
                  //      color: Color.fromRGBO(0, 0, 0, 1),
                  //      fontWeight: FontWeight.bold,
                  //      fontFamily: 'Archivo',
                  //    ),
                  //  ),
                 
               ),)]
               
           ),
          ),
        ],
      ),
    );
  }
}


// DATA MODELS

enum _ItemType { tip, article }

class _PetItem {
  final String id;
  final String title;
  final String imagePath;
  final List<String> bulletPoints;
  final _ItemType itemType;

  const _PetItem({
    required this.id,
    required this.title,
    required this.imagePath,
    required this.bulletPoints,
    required this.itemType,
  });
}


// ARROW LABEL WIDGET

enum ArrowSide { left, right }

class _ArrowLabel extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final ArrowSide arrowSide;

  const _ArrowLabel({
    Key? key,
    required this.label,
    required this.backgroundColor,
    required this.textColor,
    required this.arrowSide,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          margin: EdgeInsets.only(
            left: arrowSide == ArrowSide.left ? 20 : 0,
            right: arrowSide == ArrowSide.right ? 20 : 0,
          ),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        Positioned(
          top: 0,
          bottom: 0,
          left: arrowSide == ArrowSide.left ? 0 : null,
          right: arrowSide == ArrowSide.right ? 0 : null,
          child: CustomPaint(
            size: const Size(24, 0),
            painter: _ArrowPainter(
              color: backgroundColor,
              borderColor: Colors.black,
              arrowSide: arrowSide,
            ),
          ),
        ),
      ],
    );
  }
}

class _ArrowPainter extends CustomPainter {
  final Color color;
  final Color borderColor;
  final ArrowSide arrowSide;

  _ArrowPainter({
    required this.color,
    required this.borderColor,
    required this.arrowSide,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paintFill = Paint()..color = color;
    final path = Path();

    if (arrowSide == ArrowSide.left) {
      path.moveTo(size.width, 0);
      path.lineTo(0, size.height / 2);
      path.lineTo(size.width, size.height);
    } else {
      path.moveTo(0, 0);
      path.lineTo(size.width, size.height / 2);
      path.lineTo(0, size.height);
    }
    path.close();
    canvas.drawPath(path, paintFill);

    final paintBorder = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawPath(path, paintBorder);
  }

  @override
  bool shouldRepaint(_ArrowPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.borderColor != borderColor ||
        oldDelegate.arrowSide != arrowSide;
  }
}


// BULLET TEXT

class _BulletText extends StatelessWidget {
  final String text;
  final bool alignCenter;

  const _BulletText({
    Key? key,
    required this.text,
    this.alignCenter = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Text(
        '•  $text',
        textAlign: alignCenter ? TextAlign.center : TextAlign.left,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
      ),
    );
  }
}