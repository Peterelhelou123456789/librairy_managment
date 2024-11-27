import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback onLoginSuccess;

  const LoginPage({super.key, required this.onLoginSuccess});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true; // Variable to toggle password visibility

  // Focus node to manage keyboard focus
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return Scaffold(
      backgroundColor: Colors.blueAccent[50],
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 16 : 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: isSmallScreen ? 40 : 50,
                backgroundColor: Colors.blueAccent,
                child: Icon(
                  Icons.library_books,
                  size: isSmallScreen ? 40 : 50,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: isSmallScreen ? 16 : 24),
              Text(
                "Welcome to Library Manager",
                style: TextStyle(
                  fontSize: isSmallScreen ? 20 : 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent[800],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: isSmallScreen ? 6 : 8),
              Text(
                "Please sign in to continue",
                style: TextStyle(
                  fontSize: isSmallScreen ? 14 : 16,
                  color: Colors.blueAccent[400],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: isSmallScreen ? 24 : 32),
              TextField(
                decoration: InputDecoration(
                  labelText: "Email",
                  prefixIcon: Icon(Icons.email, color: Colors.blueAccent),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: isSmallScreen ? 12 : 15,
                    horizontal: isSmallScreen ? 16 : 20,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                // Move focus to password when user presses enter
                onSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_passwordFocusNode);
                },
              ),
              SizedBox(height: isSmallScreen ? 12 : 16),
              TextField(
                focusNode:
                    _passwordFocusNode, // Attach focus node to the password field
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: Icon(Icons.lock, color: Colors.blueAccent),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: isSmallScreen ? 12 : 15,
                    horizontal: isSmallScreen ? 16 : 20,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: Colors.blueAccent,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText; // Toggle the visibility
                      });
                    },
                  ),
                ),
                obscureText: _obscureText,
                // Trigger the login action when "Enter" is pressed
                onSubmitted: (_) {
                  widget.onLoginSuccess(); // Call the login function
                },
              ),
              SizedBox(height: isSmallScreen ? 18 : 24),
              ElevatedButton(
                onPressed: widget
                    .onLoginSuccess, // Trigger login when button is pressed
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(
                    horizontal: isSmallScreen ? 80 : 100,
                    vertical: isSmallScreen ? 12 : 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontSize: isSmallScreen ? 16 : 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: isSmallScreen ? 12 : 16),
            ],
          ),
        ),
      ),
    );
  }
}
