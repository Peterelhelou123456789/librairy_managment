import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; // Import for file handling

class EmployeeManagementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Employee Management"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildEmployeeItem(context, "Peter", "Librarian", null),
            _buildEmployeeItem(context, "peter", "Assistant", null),
            // Add more employee items as needed
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddEmployeeDialog(context);
        },
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.add, size: 30),
      ),
    );
  }

  // Function to build employee item list
  Widget _buildEmployeeItem(
      BuildContext context, String name, String position, String? imageUrl) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: imageUrl != null
            ? Image.network(imageUrl, width: 50, height: 50, fit: BoxFit.cover)
            : Icon(Icons.account_circle, color: Colors.blueAccent, size: 50),
        title: Text(
          name,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(
          position,
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
                _showEditEmployeeDialog(context, name, position, imageUrl);
              },
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                // Delete employee action
              },
            ),
          ],
        ),
      ),
    );
  }

  // Show dialog to add a new employee
  void _showAddEmployeeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New Employee'),
          content: AddEditEmployeeForm(),
        );
      },
    );
  }

  // Show dialog to edit an existing employee
  void _showEditEmployeeDialog(
      BuildContext context, String name, String position, String? imageUrl) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Employee'),
          content: AddEditEmployeeForm(
            name: name,
            position: position,
            imageUrl: imageUrl,
          ),
        );
      },
    );
  }
}

class AddEditEmployeeForm extends StatefulWidget {
  final String? name;
  final String? position;
  final String? imageUrl;

  const AddEditEmployeeForm({this.name, this.position, this.imageUrl});

  @override
  _AddEditEmployeeFormState createState() => _AddEditEmployeeFormState();
}

class _AddEditEmployeeFormState extends State<AddEditEmployeeForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _positionController = TextEditingController();
  String? _imageUrl;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    if (widget.name != null) {
      _nameController.text = widget.name!;
    }
    if (widget.position != null) {
      _positionController.text = widget.position!;
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
                  ? Icon(Icons.camera_alt, size: 50, color: Colors.blueAccent)
                  : null,
            ),
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Employee Name'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an employee name';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _positionController,
            decoration: InputDecoration(labelText: 'Position'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a position';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Handle form submission (e.g., add or edit employee)
                String name = _nameController.text;
                String position = _positionController.text;
                // ignore: avoid_print
                print(
                    'Employee Added/Edited: $name, Position: $position, Image: $_imageUrl');
                Navigator.pop(context); // Close the dialog
              }
            },
            child: Text(widget.name == null ? 'Add Employee' : 'Save Changes'),
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
