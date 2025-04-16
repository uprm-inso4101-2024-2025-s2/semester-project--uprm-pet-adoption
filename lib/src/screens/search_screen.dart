import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:semester_project__uprm_pet_adoption/analytics_service.dart';
import 'package:semester_project__uprm_pet_adoption/src/widgets.dart'; // Your custom BottomNavBar

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _selectedFilters = [];
  final List<String> _searchHistory = [];

  final List<String> _allFilters = [
    'Dog',
    'Cat',
    'Shelter',
    'Large',
    'Medium',
    'Small',
    'Adopted',
    'Available',
    'Adventurous',
    'Chill',
    'Playful',
  ];

  void _showFilterPopup() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Filter Options'),
          content: SingleChildScrollView(
            child: Column(
              children: _allFilters.map((filter) {
                final isSelected = _selectedFilters.contains(filter);
                return CheckboxListTile(
                  title: Text(
                    filter,
                    style: const TextStyle(
                      fontFamily: 'Archivo',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  value: isSelected,
                  onChanged: (value) {
                    setState(() {
                      if (value == true) {
                        _selectedFilters.add(filter);
                      } else {
                        _selectedFilters.remove(filter);
                      }
                    });
                    Navigator.pop(context);
                    _showFilterPopup(); // Reopen for smoother UX
                  },
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Done'),
            ),
          ],
        );
      },
    );
  }

  void _removeFilter(String filter) {
    setState(() {
      _selectedFilters.remove(filter);
    });
  }

  void _addToSearchHistory(String query) {
    if (query.trim().isEmpty) return;
    setState(() {
      _searchHistory.remove(query); // avoid duplicates
      _searchHistory.insert(0, query); // latest first
    });
  }

  @override
  Widget build(BuildContext context) {
    AnalyticsService().logScreenView("search_screen");
    
    final Color appBarColor = const Color.fromRGBO(255, 245, 121, 1.0);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/Login_SignUp_Background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            // AppBar
            AppBar(
              backgroundColor: appBarColor,
              elevation: 0,
              centerTitle: false,
              titleSpacing: 0,
              leading: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: appBarColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 2.0),
                  ),
                  child: Center(
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back,
                          size: 18, color: Colors.black),
                      padding: EdgeInsets.zero,
                      onPressed: () => context.go('/'),
                    ),
                  ),
                ),
              ),
              title: const Text(
                'Search',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Archivo',
                    fontSize: 25,
                    color: Colors.black),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.filter_list, color: Colors.black),
                  onPressed: _showFilterPopup,
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.black12),
                ),
                child: TextField(
                  controller: _searchController,
                  onSubmitted: (value) {
                    _addToSearchHistory(value);
                    _searchController.clear();
                  },
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    border: InputBorder.none,
                    prefixIcon: const Icon(Icons.search,
                        color: Color.fromRGBO(255, 245, 121, 1)),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear, color: Colors.black45),
                      onPressed: () => _searchController.clear(),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Selected Filters as Chips
            if (_selectedFilters.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Wrap(
                  spacing: 8.0,
                  children: _selectedFilters.map((filter) {
                    return Chip(
                      label: Text(filter),
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Colors.black26),
                      deleteIcon: const Icon(Icons.close,
                          size: 18, color: Colors.black45),
                      onDeleted: () => _removeFilter(filter),
                    );
                  }).toList(),
                ),
              ),

            const SizedBox(height: 24),

            // Placeholder Search Results Box
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    5,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text('Search Result Placeholder',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black54)),
                          ),
                          if (index < 4)
                            const Divider(
                                color: Color(0xFF82B0FF), thickness: 1),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Center(
                child: Text(
                  'Search History',
                  style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Archivo'),
                ),
              ),
            ),

            // Dynamic Search History
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: ListView(
                  children: _searchHistory
                      .map((history) => _SearchHistoryItem(text: history))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 2),
    );
  }
}

// Reusable Search History Item
class _SearchHistoryItem extends StatelessWidget {
  final String text;
  const _SearchHistoryItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(30),
            right: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
          child: Text(text),
        ),
      ),
    );
  }
}
