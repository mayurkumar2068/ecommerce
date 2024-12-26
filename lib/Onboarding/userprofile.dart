import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController fullname = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  bool _isObscured = true;
  File? _image;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // Load data from SharedPreferences
  _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    fullname.text = prefs.getString('fullname') ?? '';
    email.text = prefs.getString('email') ?? '';
    phone.text = prefs.getString('phone') ?? '';
    String? imagePath = prefs.getString('profileImage');
    if (imagePath != null) {
      _image = File(imagePath);
    }
    setState(() {});
  }

  // Save data to SharedPreferences
  _saveUserData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('fullname', fullname.text);
    prefs.setString('email', email.text);
    prefs.setString('phone', phone.text);
    if (_image != null) {
      prefs.setString('profileImage', _image!.path);
    }
  }

  // Method to validate text fields
  void validateTextfield() {
    if (fullname.text.isEmpty && email.text.isEmpty && phone.text.isEmpty) {
      print("Invalid data");
    } else if (fullname.text.isEmpty) {
      print("Enter full name");
    } else if (!email.text.contains('@')) {
      print("Enter email");
    } else if (phone.text.length != 10) {
      print("Enter phone number");
    } else {
      print("Profile Updated Successfully");
      _saveUserData();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Profile updated")));
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    if (source == ImageSource.camera) {
      await Permission.camera.request();
    } else if (source == ImageSource.gallery) {
      await Permission.photos.request();
    }

    if (await Permission.camera.isGranted || await Permission.photos.isGranted) {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: source);

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Permission denied')),
      );
    }
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Take a Photo'),
              onTap: () {
                _pickImage(ImageSource.camera);
                Navigator.of(ctx).pop();
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Choose from Gallery'),
              onTap: () {
                _pickImage(ImageSource.gallery);
                Navigator.of(ctx).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        backgroundColor: Colors.red,
        leading: IconButton(icon: Icon(Icons.chevron_left,color: Colors.white,),onPressed: (){
          Navigator.of(context).pop();
        },),
        title: Text(
          "Profile",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: CupertinoColors.white,
            fontSize: 18,
            fontStyle: FontStyle.normal,
            textBaseline: TextBaseline.alphabetic,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(height: width * 0.12),
            Container(
              width: width,
              height: width * 1.6,
              child: Column(
                children: [
                  SizedBox(height: width * 0.12),
                  Container(
                    padding: EdgeInsets.all(8),
                    width: width * 0.9,
                    height: width * 0.4,
                    child: GestureDetector(
                      onTap: _showImagePickerOptions,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Profile Photo",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: width * 0.1),
                          Row(
                            children: [
                              SizedBox(width: 70),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.grey,
                                backgroundImage: _image != null ? FileImage(_image!) : null,
                                child: _image == null
                                    ? Icon(Icons.person, size: 50, color: Colors.white)
                                    : null,
                              ),
                              SizedBox(width: width * 0.1),
                              Expanded(
                                child: Text(
                                  'Upload photo',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: CupertinoColors.lightBackgroundGray)
                    ),
                  ),
                  SizedBox(height: width * 0.06),
                  _buildTextField("Full name", fullname),
                  SizedBox(height: width * 0.05),
                  _buildTextField("Email", email),
                  SizedBox(height: width * 0.05),
                  _buildTextField("Phone no", phone),
                  SizedBox(height: width * 0.08),
                  ElevatedButton(
                    onPressed: validateTextfield,
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(width * 0.5, 48),
                      backgroundColor: CupertinoColors.systemYellow,
                    ),
                    child: Text(
                      "Save Changes",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: CupertinoColors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),

                ],
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.elliptical(40, 40),
                  bottomRight: Radius.elliptical(180, 100),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build text fields
  Widget _buildTextField(String labelText, TextEditingController controller) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
          fillColor: Colors.white,
          filled: true,
        ),
      ),
    );
  }
}
