import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Custom Bottom Navigation Bar
///
/// - Displays five navigation icons: Home, Messages, Search, Location, Profile.
/// - Highlights the active tab with a yellow color.
///
/// Used in: Home, Match, and Profile Screens.
class BottomNavBar extends StatelessWidget {
  /// The current index of the selected tab.
  final int selectedIndex;

  const BottomNavBar({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(context, Icons.home, 0, "/home"),
          _buildNavItem(context, Icons.chat_bubble_outline, 1, "/chat"),
          _buildNavItem(context, Icons.search, 2, "/search"),
          _buildNavItem(context, Icons.place, 3, "/location"),
          _buildNavItem(context, Icons.person, 4, "/profile"),
        ],
      ),
    );
  }

  /// Helper function to build navigation icons.
  Widget _buildNavItem(BuildContext context, IconData icon, int index, String route) {
    final isSelected = selectedIndex == index;

    return IconButton(
      icon: Icon(icon, size: 30, color: isSelected ? Colors.yellow : Colors.yellow[200]),
      onPressed: () {
        if (GoRouterState.of(context).uri.toString() != route) {
          context.go(route); // Navigate using GoRouter
        }
      },
    );
  }
}
