import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class GalleryImage extends StatefulWidget {
  const GalleryImage({Key? key, required  onImageSelected, required void Function(Uint8List image) setImage}) : super(key: key);

  @override
  State<GalleryImage> createState() => _GalleryImageState();
}

class _GalleryImageState extends State<GalleryImage> {
  Uint8List? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD67BFF),
      body: Center(
        child: Stack(
          children: [
            _buildProfileImage(),
            Positioned(
              bottom: 0,
              left: 140,
              child: Column(
                children: [
                  _buildAddPhotoButton(),
                  if (_image != null) _buildGoToCartButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return _image != null
        ? CircleAvatar(radius: 100, backgroundImage: MemoryImage(_image!))
        : const CircleAvatar(
      radius: 100,
      backgroundImage: NetworkImage(
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQFQT9u0pMwBgm8tygo_5_DnAS0E4XXylKSOh83T9Qk940d1u4JtojNe71wVHTm-IFhVDM&usqp=CAU"),
    );
  }

  Widget _buildAddPhotoButton() {
    return IconButton(
      onPressed: () {
        showImagePickerOption(context);
      },
      icon: const Icon(Icons.add_a_photo),
    );
  }

  Widget _buildGoToCartButton() {
    return ElevatedButton(
      onPressed: () {
        if (_image != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CartPage(imageBytes: _image!),
            ),
          );
        }
      },
      child: const Text('Go to Cart'),
    );
  }

  void showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
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
                      _pickImageFromGallery(context);
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.image,
                          size: 70,
                        ),
                        const Text("Gallery"),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _pickImageFromCamera(context);
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.camera_alt,
                          size: 70,
                        ),
                        const Text("Camera"),
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

  Future<void> _pickImageFromGallery(BuildContext context) async {
    final pickedImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return;

    final selectedImage = File(pickedImage.path);
    final imageBytes = await selectedImage.readAsBytes();

    setState(() {
      _image = imageBytes;
    });

    Navigator.of(context).pop(); // Close the modal sheet
  }

  Future<void> _pickImageFromCamera(BuildContext context) async {
    final pickedImage =
    await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage == null) return;

    final selectedImage = File(pickedImage.path);
    final imageBytes = await selectedImage.readAsBytes();

    setState(() {
      _image = imageBytes;
    });

    Navigator.of(context).pop(); // Close the modal sheet
  }
}

class CartPage extends StatelessWidget {
  final Uint8List imageBytes;

  const CartPage({Key? key, required this.imageBytes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Page'),
      ),
      body: Center(
        child: Image.memory(imageBytes),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: GalleryImage(onImageSelected: null, setImage: (Uint8List image) {  },),
  ));
}
