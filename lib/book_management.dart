import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BookManagementPage extends StatelessWidget {
  final List<Map<String, dynamic>> books = [
    {
      'title': 'Book Title 1',
      'price': 10.0,
      'count': 5,
      'imageUrl': 'assets/book1.jpg', // Image from assets
    },
    {
      'title': 'Another Book 2',
      'price': 12.0,
      'count': 3,
      'imageUrl': 'assets/book2.jpg', // Image from assets
    },
    {
      'title': 'Flutter Guide 3',
      'price': 20.0,
      'count': 7,
      'imageUrl': 'assets/book3.jpg', // Image from assets
    },
    {
      'title': 'Advanced Flutter 4',
      'price': 15.0,
      'count': 10,
      'imageUrl': 'assets/book4.jpg', // Image from assets
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Management"),
        backgroundColor: Colors.blueAccent,
        elevation: 5,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: books.length,
          itemBuilder: (context, index) {
            final book = books[index];
            return _buildBookItem(
              context,
              book['title'],
              book['price'],
              book['count'],
              book['imageUrl'],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddBookDialog(context);
        },
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.add, size: 30),
      ),
    );
  }

  Widget _buildBookItem(BuildContext context, String title, double price,
      int count, String? imageUrl) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: imageUrl != null
            ? Image.asset(imageUrl, width: 50, height: 50, fit: BoxFit.cover)
            : Icon(Icons.book, color: Colors.blueAccent, size: 40),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(
          "Price: \$${price.toStringAsFixed(2)} | Count: $count",
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit, color: Colors.orange),
              onPressed: () {
                _showEditBookDialog(context, title, price, count, imageUrl);
              },
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                // Delete book action
              },
            ),
          ],
        ),
      ),
    );
  }

  // Show dialog to add a new book
  void _showAddBookDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New Book'),
          content: AddEditBookForm(),
        );
      },
    );
  }

  // Show dialog to edit an existing book
  void _showEditBookDialog(BuildContext context, String title, double price,
      int count, String? imageUrl) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Book'),
          content: AddEditBookForm(
            title: title,
            price: price,
            count: count,
            imageUrl: imageUrl,
          ),
        );
      },
    );
  }
}

class AddEditBookForm extends StatefulWidget {
  final String? title;
  final double? price;
  final int? count;
  final String? imageUrl;

  const AddEditBookForm({this.title, this.price, this.count, this.imageUrl});

  @override
  _AddEditBookFormState createState() => _AddEditBookFormState();
}

class _AddEditBookFormState extends State<AddEditBookForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _countController = TextEditingController();
  String? _imageUrl;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    if (widget.title != null) {
      _titleController.text = widget.title!;
    }
    if (widget.price != null) {
      _priceController.text = widget.price!.toString();
    }
    if (widget.count != null) {
      _countController.text = widget.count!.toString();
    }
    if (widget.imageUrl != null) {
      _imageUrl = widget.imageUrl;
    }
  }

  // Function to pick an image from gallery or camera
  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageUrl = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: _pickImage,
            child: Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
                image: _imageUrl != null
                    ? DecorationImage(
                        image: FileImage(File(_imageUrl!)),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: _imageUrl == null
                  ? Image.asset('assets/images/book_image.png',
                      fit: BoxFit.cover)
                  : null,
            ),
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _titleController,
            decoration: InputDecoration(labelText: 'Book Title'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a book title';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _priceController,
            decoration: InputDecoration(labelText: 'Price'),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a price';
              }
              if (double.tryParse(value) == null) {
                return 'Please enter a valid number';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _countController,
            decoration: InputDecoration(labelText: 'Count'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a count';
              }
              if (int.tryParse(value) == null) {
                return 'Please enter a valid integer';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Handle form submission (e.g., add or edit book)
                String title = _titleController.text;
                double price = double.parse(_priceController.text);
                int count = int.parse(_countController.text);
                print(
                    'Book Added/Edited: $title, \$${price.toStringAsFixed(2)}, Count: $count, Image: $_imageUrl');
                Navigator.pop(context); // Close the dialog
              }
            },
            child: Text(widget.title == null ? 'Add Book' : 'Save Changes'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.blueAccent,
            ),
          ),
        ],
      ),
    );
  }
}
