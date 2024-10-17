import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(15.0),
        children: [
          _buildSettingsItem(
            icon: Icons.account_circle,
            label: 'Account',
            onTap: () {
              // Handle account settings tap
            },
          ),
          const SizedBox(height: 16.0),
          _buildSettingsItem(
            icon: Icons.notifications,
            label: 'Notifications',
            onTap: () {
              // Handle notifications settings tap
            },
          ),
          const SizedBox(height: 16.0),
          _buildSettingsItem(
            icon: Icons.security,
            label: 'Privacy & Security',
            onTap: () {
              // Handle privacy & security settings tap
            },
          ),
          const SizedBox(height: 16.0),
          _buildSettingsItem(
            icon: Icons.help,
            label: 'Help',
            onTap: () {
              // Handle help settings tap
            },
          ),
          const SizedBox(height: 16.0),
          _buildSettingsItem(
            icon: Icons.language,
            label: 'Language',
            onTap: () {
              // Navigate to LanguageSelectionPage
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LanguageSelectionPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 0.0),
      padding: const EdgeInsets.symmetric(vertical: 0.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 225, 235),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 30, color: Colors.black),
              const SizedBox(width: 10),
              Text(label, style: const TextStyle(color: Colors.black)),
            ],
          ),
        ),
        onTap: onTap,
        tileColor: Colors.transparent,
      ),
    );
  }
}

class LanguageSelectionPage extends StatelessWidget {
  const LanguageSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Select Language',
          style: TextStyle(color: Colors.white), // Set title color to white
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white), // Set icon color to white
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(15.0),
        children: [
          _buildLanguageItem(context, 'English'),
          const SizedBox(height: 16.0),
          _buildLanguageItem(context, 'Thai'),
        ],
      ),
    );
  }

  Widget _buildLanguageItem(BuildContext context, String language) {
    return ListTile(
      title: Text(language),
      onTap: () {
        // Handle language selection
        // For example, store the selection or update the UI accordingly
        Navigator.pop(context); // Go back to the settings page
      },
    );
  }
}
