import 'dart:io';
import 'dart:typed_data';
import 'package:cycle_resale_app/pages/camera_image_cart_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GalleryImage extends StatefulWidget {
  const GalleryImage({Key? key}) : super(key: key);

  @override
  State<GalleryImage> createState() => _GalleryImageState();
}

class _GalleryImageState extends State<GalleryImage> {
  Uint8List? _image;
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Center(
        child: Stack(
          children: [
            InkWell(
              onTap: () {
                if (_image != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CameraImagePage(image: _image!),
                    ),
                  );
                } else {
                  showImagePickerOption(context);
                }
              },
              child: _image != null
                  ? CircleAvatar(
                  radius: 100, backgroundImage: MemoryImage(_image!))
                  : const CircleAvatar(
                radius: 100,
                backgroundImage: NetworkImage(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQFQT9u0pMwBgm8tygo_5_DnAS0E4XXylKSOh83T9Qk940d1u4JtojNe71wVHTm-IFhVDM&usqp=CAU"),
              ),
            ),
            Positioned(
              bottom: -0,
              left: 140,
              child: IconButton(
                onPressed: () {
                  showImagePickerOption(context);
                },
                icon: Icon(Icons.add_a_photo),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.blue[100],
      context: context,
      builder: (builder) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4.5,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _pickImageFromGallery();
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.image,
                          size: 70,
                        ),
                        Text("Gallery"),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _pickImageFromCamera();
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.image,
                          size: 70,
                        ),
                        Text("Camera"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Gallery
  Future _pickImageFromGallery() async {
    final returnImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    Navigator.of(context).pop(); // close the modal sheet
  }

  // Camera
  Future _pickImageFromCamera() async {
    final returnImage =
    await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    Navigator.of(context).pop();
  }
}

