import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cycle_resale_app/pages/info_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GalleryImagePage(),
    );
  }
}

class GalleryImagePage extends StatefulWidget {
  @override
  _GalleryImagePageState createState() => _GalleryImagePageState();
}

class _GalleryImagePageState extends State<GalleryImagePage> {
  final DatabaseReference _databaseReference =
  FirebaseDatabase.instance.reference().child('userSubmissions');

  final TextEditingController organizationController = TextEditingController();
  final TextEditingController contactPersonController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  String _imagePath = ''; // Initialize to an empty string

  // Function to pick an image from the gallery
  Future<void> _pickImageFromGallery() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
    }
  }

  // Function to take a picture from the camera
  Future<void> _takePicture() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
    }
  }
  Future<String> _uploadImageToStorage(String imagePath) async {
    File file = File(imagePath);
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference storageReference =
    storage.ref().child('user_images/${DateTime.now().millisecondsSinceEpoch}');
    UploadTask uploadTask = storageReference.putFile(file);

    try {
      await uploadTask.whenComplete(() => null); // Wait for the upload to complete
      String downloadURL = await storageReference.getDownloadURL();
      return downloadURL;
    } catch (error) {
      print('Error uploading image: $error');
      return Future.error('Image upload failed: $error');
    }
  }

  void _submitForm() async {
    try {
      if (_imagePath.isEmpty) {
        print('Please pick an image before submitting the form.');
        return;
      }

      String imageUrl = await _uploadImageToStorage(_imagePath);

      if (imageUrl.isNotEmpty) {
        await _databaseReference.push().set({
          'organizationName': organizationController.text,
          'contactPersonName': contactPersonController.text,
          'email': emailController.text,
          'phoneNumber': phoneNumberController.text,
          'imageUrl': imageUrl,
          // Add more fields as needed
        });

        print('Form submitted successfully with imageUrl: $imageUrl');

        // Navigate to InfoPage with the image URL
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => InfoPage(imageUrl: imageUrl)),
        );
      } else {
        print('Error: Image upload failed. ImageURL is empty.');
      }
    } catch (error) {
      print('Error submitting form: $error');
    }
  }
  @override
  void dispose() {
    organizationController.dispose();
    contactPersonController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD67BFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFD67BFF),
        title: Text(
          'Provide Your Cycle Information',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            key: Key('organizationName'),
            controller: organizationController,
            decoration: InputDecoration(labelText: 'Organization Name'),
          ),
          TextFormField(
            key: Key('contactPersonName'),
            controller: contactPersonController,
            decoration: InputDecoration(labelText: 'Contact Person Name'),
          ),
          TextFormField(
            key: Key('email'),
            controller: emailController,
            decoration: InputDecoration(labelText: 'Email'),
          ),
          TextFormField(
            key: Key('phoneNumber'),
            controller: phoneNumberController,
            decoration: InputDecoration(labelText: 'Phone Number'),
          ),
          ElevatedButton(
            onPressed: _pickImageFromGallery,
            style: ElevatedButton.styleFrom(
              primary: Colors.black,
            ),
            child: Text('Pick Image from Gallery'),
          ),
          ElevatedButton(
            onPressed: _takePicture,
            style: ElevatedButton.styleFrom(
              primary: Colors.black,
            ),
            child: Text('Take Picture'),
          ),
          ElevatedButton(
            onPressed: _submitForm,
            style: ElevatedButton.styleFrom(
              primary: Colors.black,
            ),
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}