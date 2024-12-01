import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; // For the File class


// User class to represent each user
class User {
  final String name;
  final String email;
  final String? image;

  User({required this.name, required this.email, this.image});
}

class UserManagementPage extends StatefulWidget {
  @override
  _UserManagementPageState createState() => _UserManagementPageState();
}

class _UserManagementPageState extends State<UserManagementPage> {
  List<User> users = [
    User(name: 'Peter', email: 'peter@example.com', image: null),
    User(name: 'Peter', email: 'peter@example.com', image: null),
    // Add more users as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Management"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            return _buildUserItem(context, users[index]);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddUserDialog(context);
        },
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.add, size: 30),
      ),
    );
  }

  // Function to build user item list
  Widget _buildUserItem(BuildContext context, User user) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: user.image != null
            ? Image.asset(
                user.image!, // Assuming the image is stored in the assets
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              )
            : Icon(Icons.account_circle,
                color: Colors.blueAccent, size: 50), // Default icon
        title: Text(
          user.name,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(
          user.email,
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
                _showEditUserDialog(context, user);
              },
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                // Delete user action
                setState(() {
                  users.remove(user);
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  // Show dialog to add a new user
  void _showAddUserDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New User'),
          content: AddEditUserForm(),
        );
      },
    );
  }

  // Show dialog to edit an existing user
  void _showEditUserDialog(BuildContext context, User user) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit User'),
          content: AddEditUserForm(
            name: user.name,
            email: user.email,
            image: user.image,
          ),
        );
      },
    );
  }
}

class AddEditUserForm extends StatefulWidget {
  final String? name;
  final String? email;
  final String? image;

  const AddEditUserForm({this.name, this.email, this.image});

  @override
  _AddEditUserFormState createState() => _AddEditUserFormState();
}

class _AddEditUserFormState extends State<AddEditUserForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  String? _image;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    if (widget.name != null) {
      _nameController.text = widget.name!;
    }
    if (widget.email != null) {
      _emailController.text = widget.email!;
    }
    if (widget.image != null) {
      _image = widget.image;
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
                image: _image != null
                    ? DecorationImage(
                        image: FileImage(File(_image!)),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: _image == null
                  ? Icon(Icons.camera_alt, size: 50, color: Colors.blueAccent)
                  : null,
            ),
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'User Name'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a user name';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'Email'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an email';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Handle form submission (e.g., add or edit user)
                String name = _nameController.text;
                String email = _emailController.text;
                // ignore: avoid_print
                print(
                    'User Added/Edited: $name, Email: $email, Image: $_image');
                Navigator.pop(context); // Close the dialog
              }
            },
            child: Text(widget.name == null ? 'Add User' : 'Save Changes'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.blueAccent,
            ),
          ),
        ],
      ),
    );
  }

  // Function to pick an image from gallery or camera
  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile.path;
      });
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: UserManagementPage(),
  ));
}
