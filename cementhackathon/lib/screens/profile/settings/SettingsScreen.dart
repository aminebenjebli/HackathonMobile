import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Paramètres',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Section
            Text(
              'PROFIL',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            _settingTile(
              title: 'Notifications push',
              trailing: Switch(
                value: false,
                onChanged: (value) {
                  // Handle toggle logic here
                },
              ),
            ),
            Divider(color: Colors.grey.shade300),
            _settingTile(
              title: 'Localisation',
              trailing: Switch(
                value: true,
                onChanged: (value) {
                  // Handle toggle logic here
                },
                activeColor: Colors.red,
              ),
            ),
            Divider(color: Colors.grey.shade300),
            _settingTile(
              title: 'Langue',
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Français',
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                  Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                ],
              ),
              onTap: () {
                // Navigate to language settings
              },
            ),
            SizedBox(height: 24),

            // Other Section
            Text(
              'AUTRES',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            _settingTile(
              title: 'À propos de Ticketis',
              trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              onTap: () {
                // Navigate to About Ticketis screen
              },
            ),
            Divider(color: Colors.grey.shade300),
            _settingTile(
              title: 'Politique de confidentialité',
              trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              onTap: () {
                // Navigate to Privacy Policy screen
              },
            ),
            Divider(color: Colors.grey.shade300),
            _settingTile(
              title: 'Conditions générales',
              trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              onTap: () {
                // Navigate to Terms and Conditions screen
              },
            ),
          ],
        ),
      ),
    );
  }

  // Helper for Setting Tile
  Widget _settingTile({
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
