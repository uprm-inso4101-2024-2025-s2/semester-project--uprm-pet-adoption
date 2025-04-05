import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);



  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = false;

  // Colors per your design
  final Color _backgroundColor = const Color(0xFFFFF581);  // Overall background
  final Color _tileColor = const Color(0xFFF2F2F2);        // Light gray tile background
  final Color _dividerColor = const Color(0xFFE0E0E0);      // Divider between tiles
  final Color _pastelBlueIcon = const Color(0xFF82C3FA);    // Icon color
  final Color _bottomBarColor = Colors.black;               // Bottom nav background
  final Color _bottomBarIconColor = const Color(0xFFFFF581);// Bottom nav icon color

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: _backgroundColor,

      // Top AppBar with updated font style for "Settings"
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Go back to Home screen
            context.go('/');
          },
        ),
        centerTitle: true,
        title: const Text(
          'Settings',
          style: TextStyle(
            fontSize: 32,
            // Match the style used for "MENU" (e.g., 'Archivo' font, no bold)
            fontFamily: 'Archivo',
            color: Colors.black,
          ),

      appBar: AppBar(title: const Text("Settings")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "App Settings",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20), // Spacing between text and button
            ElevatedButton(
              onPressed: () {
                context.go('/menu'); // Return to the menu screen for the moment
              },
              child: const Text("Return"),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                context.go('/chat'); // Go to chat screen
              },
              child: const Text("Message"),
            ),
          ],

        ),
      ),

      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black.withOpacity(0.5),
                    size: 24,
                  ),
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ),

          // Expanded List of Settings
          Expanded(
            child: ListView(
              children: [
                // 1) General
                _buildSettingsTile(
                  icon: Icons.settings,
                  label: 'General',
                  onTap: () {},
                ),
                // 2) Notifications Toggle
                _buildToggleTile(
                  icon: Icons.notifications,
                  label: 'Notifications',
                ),
                // 3) Privacy & Security
                _buildSettingsTile(
                  icon: Icons.lock,
                  label: 'Privacy & Security',
                  onTap: () {},
                ),
                // 4) Terms & Conditions
                _buildSettingsTile(
                  icon: Icons.article,
                  label: 'Terms & Conditions',
                  onTap: () {},
                ),
                // 5) Contacts
                _buildSettingsTile(
                  icon: Icons.contacts,
                  label: 'Contacts',
                  onTap: () {},
                ),
                // 6) Recent Activity
                _buildSettingsTile(
                  icon: Icons.history,
                  label: 'Recent Activity',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: _bottomBarColor,
        selectedItemColor: _bottomBarIconColor,
        unselectedItemColor: _bottomBarIconColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline, size: 32),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, size: 32),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on, size: 32),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 32),
            label: '',
          ),
        ],
      ),
    );
  }

  // Standard Settings Tile
  Widget _buildSettingsTile({
    required IconData icon,
    required String label,
    VoidCallback? onTap,
  }) {
    return Column(
      children: [
        Container(
          color: _tileColor,
          child: ListTile(
            leading: Icon(icon, color: _pastelBlueIcon, size: 28),
            title: Text(label, style: const TextStyle(fontSize: 16)),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
              size: 18,
            ),
            onTap: onTap,
          ),
        ),
        Divider(height: 1, thickness: 1, color: _dividerColor),
      ],
    );
  }

  // Notifications Toggle Tile
  Widget _buildToggleTile({
    required IconData icon,
    required String label,
  }) {
    return Column(
      children: [
        Container(
          color: _tileColor,
          child: ListTile(
            leading: Icon(icon, color: _pastelBlueIcon, size: 28),
            title: Text(label, style: const TextStyle(fontSize: 16)),
            trailing: SizedBox(
              width: 90,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Switch(
                    value: _notificationsEnabled,
                    onChanged: (bool value) {
                      setState(() {
                        _notificationsEnabled = value;
                      });
                    },
                    activeColor: Colors.white,
                    activeTrackColor: Colors.blue,
                    inactiveTrackColor: Colors.grey,
                  ),
                  Text(
                    _notificationsEnabled ? 'ON' : 'OFF',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _notificationsEnabled ? Colors.white : Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Divider(height: 1, thickness: 1, color: _dividerColor),
      ],
    );
  }
}