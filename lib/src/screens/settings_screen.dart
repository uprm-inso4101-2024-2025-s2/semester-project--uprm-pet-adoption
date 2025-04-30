import 'package:flutter/material.dart';
import 'package:semester_project__uprm_pet_adoption/analytics_service.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = false;

  final Color _backgroundColor = const Color(0xFFFFF581);
  final Color _tileColor = const Color(0xFFF2F2F2);
  final Color _dividerColor = const Color(0xFFE0E0E0);
  final Color _pastelBlueIcon = const Color(0xFF82C3FA);
  final Color _bottomBarColor = Colors.black;
  final Color _bottomBarIconColor = const Color(0xFFFFF581);

  @override
  Widget build(BuildContext context) {
    AnalyticsService().logScreenView("settings_screen");
    
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
          size: 18, color: Colors.black),
          padding: EdgeInsets.zero,
          onPressed: () => context.go('/?openMenu=true'),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(
            fontSize: 25,
            fontFamily: 'Archivo',
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
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
          // List of Settings Options
          Expanded(
            child: ListView(
              children: [
                _buildSettingsTile(icon: Icons.settings, label: 'General'),
                _buildToggleTile(icon: Icons.notifications, label: 'Notifications'),
                _buildSettingsTile(icon: Icons.lock, label: 'Privacy & Security'),
                _buildSettingsTile(icon: Icons.article, label: 'Terms & Conditions'),
                _buildSettingsTile(icon: Icons.contacts, label: 'Contacts'),
                _buildSettingsTile(icon: Icons.history, label: 'Recent Activity'),
              ],
            ),
          ),
        ],
      ),
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
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black, size: 18),
            onTap: onTap,
          ),
        ),
        Divider(height: 1, thickness: 1, color: _dividerColor),
      ],
    );
  }

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
