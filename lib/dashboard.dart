import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dashboard",
        ),
        backgroundColor: Colors.blueAccent,
        elevation: 5,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: (screenWidth - 48) / 2,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "User Count",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "100", // User count value
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: (screenWidth - 48) / 2,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Book Count",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "500", // Book count value
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: Image.asset('assets/book1.jpg',
                          width: 50, height: 50, fit: BoxFit.cover),
                      title: Text("Book Title 1"),
                      subtitle: Text("Price: \$10, Count: 5"),
                      onTap: () {
                        // Handle book tap (e.g., navigate to book details)
                      },
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: Image.asset('assets/book2.jpg',
                          width: 50, height: 50, fit: BoxFit.cover),
                      title: Text("Book Title 2"),
                      subtitle: Text("Price: \$15, Count: 3"),
                      onTap: () {
                        // Handle book tap (e.g., navigate to book details)
                      },
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: Image.asset('assets/book3.jpg',
                          width: 50, height: 50, fit: BoxFit.cover),
                      title: Text("Book Title 3"),
                      subtitle: Text("Price: \$20, Count: 8"),
                      onTap: () {
                        // Handle book tap (e.g., navigate to book details)
                      },
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: Image.asset('assets/book4.jpg',
                          width: 50, height: 50, fit: BoxFit.cover),
                      title: Text("Book Title 4"),
                      subtitle: Text("Price: \$12, Count: 2"),
                      onTap: () {
                        // Handle book tap (e.g., navigate to book details)
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
