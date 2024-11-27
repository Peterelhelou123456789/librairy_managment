import 'package:flutter/material.dart';

class SellOrBorrowBookPage extends StatefulWidget {
  @override
  _SellOrBorrowBookPageState createState() => _SellOrBorrowBookPageState();
}

class _SellOrBorrowBookPageState extends State<SellOrBorrowBookPage> {
  // Variables to hold the selected values
  String? _selectedBook;
  String? _selectedUser;
  String _action = 'Sell'; // Default action is Sell

  // Sample data for books and users
  final List<String> _books = [
    'The Great Gatsby',
    '1984',
    'To Kill a Mockingbird'
  ];
  final List<String> _users = ['Ahmad', 'Peter', 'Nour'];

  // GlobalKey for the form to validate
  final _formKey = GlobalKey<FormState>();

  // Method to handle form submission
  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // You can submit the form data or show a success message
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Form Submitted')));
    }
  }

  @override
  Widget build(BuildContext context) {
    // MediaQuery to get screen size
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Check screen size and apply different styles based on it
    bool isLargeScreen = screenWidth > 600;

    return Scaffold(
      appBar: AppBar(
        title: Text("Sell or Borrow Book"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: isLargeScreen
            ? const EdgeInsets.all(32.0) // Larger padding for larger screens
            : const EdgeInsets.all(16.0), // Default padding for smaller screens
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Manage Books',
              style: TextStyle(
                fontSize:
                    isLargeScreen ? 32 : 28, // Larger font for larger screens
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 20),

            // Form for selling or borrowing a book
            Form(
              key: _formKey,
              child: Column(
                children: [
                  // Dropdown for book selection
                  DropdownButtonFormField<String>(
                    value: _selectedBook,
                    decoration: InputDecoration(
                      labelText: 'Select Book',
                      border: OutlineInputBorder(),
                    ),
                    items: _books.map((book) {
                      return DropdownMenuItem<String>(
                        value: book,
                        child: Text(book),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedBook = newValue;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a book';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),

                  // Dropdown for user selection
                  DropdownButtonFormField<String>(
                    value: _selectedUser,
                    decoration: InputDecoration(
                      labelText: 'Select User',
                      border: OutlineInputBorder(),
                    ),
                    items: _users.map((user) {
                      return DropdownMenuItem<String>(
                        value: user,
                        child: Text(user),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedUser = newValue;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a user';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),

                  // Dropdown for action selection (Sell or Borrow)
                  DropdownButtonFormField<String>(
                    value: _action,
                    decoration: InputDecoration(
                      labelText: 'Action (Sell or Borrow)',
                      border: OutlineInputBorder(),
                    ),
                    items: ['Sell', 'Borrow'].map((action) {
                      return DropdownMenuItem<String>(
                        value: action,
                        child: Text(action),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _action = newValue!;
                      });
                    },
                  ),
                  SizedBox(height: 20),

                  // Submit Button with dynamic size
                  ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent, // Button color
                      padding: EdgeInsets.symmetric(
                        vertical: isLargeScreen ? 16 : 12,
                        horizontal: isLargeScreen ? 40 : 20,
                      ),
                    ),
                    child: Text('Submit',
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),

            // Table of borrowed books with better styling
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowHeight: 56,
                columns: [
                  DataColumn(
                    label: Text(
                      "Book",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: isLargeScreen ? 18 : 16,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Borrowed By",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: isLargeScreen ? 18 : 16,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Actions",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: isLargeScreen ? 18 : 16,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                ],
                rows: [
                  DataRow(cells: [
                    DataCell(Text("The Great Gatsby")),
                    DataCell(Text("Peter")),
                    DataCell(Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.check, color: Colors.green),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.shopping_cart, color: Colors.orange),
                          onPressed: () {},
                        ),
                      ],
                    )),
                  ]),
                  // Add more rows here as needed
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
