import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class GalleryImage extends StatefulWidget {
  const GalleryImage({Key? key}) : super(key: key);

  @override
  State<GalleryImage> createState() => _GalleryImageState();
}

class _GalleryImageState extends State<GalleryImage> {
  File? file;
  ImagePicker image = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyApp(
        file: file,
        getgall: getgall,
        getcam: getcam,
      ),
    );
  }
  void main() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Request camera permission
    await Permission.camera.request();

    runApp(MaterialApp());
  }


  void getcam() async {
    var img = await image.pickImage(source: ImageSource.camera);
    setState(() {
      file = File(img!.path);
    });
  }

  void getgall() async {
    var img = await image.pickImage(source: ImageSource.gallery);
    setState(() {
      file = File(img!.path);
    });
  }
}

class MyApp extends StatelessWidget {
  final File? file;
  final void Function() getgall;
  final void Function() getcam;

  const MyApp({
    Key? key,
    required this.file,
    required this.getgall,
    required this.getcam,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD67BFF),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (file == null)
              Icon(
                Icons.image,
                size: 50,
                color: Colors.black12,
              )
            else
              Image.file(
                file!,
                fit: BoxFit.fill,
              ),
            SizedBox(height: 20),
            MaterialButton(
              onPressed: getgall,
              color: Colors.white,
              child: Text(
                "Take From Gallery",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            MaterialButton(
              onPressed: getcam,
              color: Colors.white,
              child: Text(
                "Take From Camera",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}