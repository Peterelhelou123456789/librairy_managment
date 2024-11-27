import 'package:flutter/material.dart';
import 'package:project1/book_management.dart';
import 'package:project1/dashboard.dart';
import 'package:project1/employee_management.dart';
import 'package:project1/sell_or_borrowed_book.dart';
import 'package:project1/settings.dart';
import 'package:project1/user_management.dart';
import 'package:project1/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false;
  int _currentIndex = 0;

  final List<Widget> _pages = [
    DashboardPage(),
    BookManagementPage(),
    EmployeeManagementPage(),
    SellOrBorrowBookPage(),
    UserManagementPage(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    if (index == 6) {
      // Check if the logout item is tapped
      setState(() {
        _isLoggedIn = false; // Log out the user
      });
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  void _loginSuccess() {
    setState(() {
      _isLoggedIn = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _isLoggedIn
          ? Scaffold(
              body: _pages[_currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: _currentIndex,
                onTap: _onItemTapped,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.dashboard),
                    label: 'Dashboard',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.book),
                    label: 'Books',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Employees',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.sell),
                    label: 'Sell/Borrow',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'User',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: 'Settings',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.logout),
                    label: 'Logout', // Add Logout item
                  ),
                ],
                backgroundColor: Colors.blueAccent,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.grey[400],
                type: BottomNavigationBarType.fixed,
              ),
            )
          : LoginPage(
              onLoginSuccess:
                  _loginSuccess), // Pass the onLoginSuccess callback
    );
  }
}
