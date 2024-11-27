import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // MediaQuery for responsive layout
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen =
        screenWidth < 600; // Check if the screen is small (for mobile)

    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Email Section
            ListTile(
              leading: Icon(Icons.email, color: Colors.blueAccent),
              title: Text("Email",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              subtitle:
                  Text("user@example.com", style: TextStyle(fontSize: 16)),
            ),
            Divider(),

            // Change Password Section
            ListTile(
              leading: Icon(Icons.lock, color: Colors.blueAccent),
              title: Text("Change Password",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              onTap: () {
                // Show the dialog to change the password
                _showChangePasswordDialog(context);
              },
            ),
            Divider(),

            // Settings Section
            ListTile(
              leading: Icon(Icons.settings, color: Colors.blueAccent),
              title: Text("App Settings",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              onTap: () {
                // Handle settings
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("App Settings tapped")));
              },
            ),
            Divider(),

            // Save Settings Button
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Method to show the Change Password dialog
  void _showChangePasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Change Password"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Old password input field
              TextField(
                decoration: InputDecoration(
                  labelText: "Old Password",
                  prefixIcon: Icon(Icons.lock_outline),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 16),
              // New password input field
              TextField(
                decoration: InputDecoration(
                  labelText: "New Password",
                  prefixIcon: Icon(Icons.lock_outline),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 16),
              // Confirm new password input field
              TextField(
                decoration: InputDecoration(
                  labelText: "Confirm New Password",
                  prefixIcon: Icon(Icons.lock_outline),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
            ],
          ),
          actions: [
            // Cancel Button
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            // Submit Button
            ElevatedButton(
              onPressed: () {
                // Submit password change logic here
                Navigator.of(context).pop(); // Close the dialog
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Password Changed Successfully")));
              },
              child: Text("Submit"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent, // Button background color
                foregroundColor: Colors.white, // Text color
              ),
            ),
          ],
        );
      },
    );
  }
}
