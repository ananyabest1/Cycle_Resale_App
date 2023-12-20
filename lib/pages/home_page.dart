import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:cycle_resale_app/pages/gallery_images.dart';
import '../components/cycle_item_tile.dart';
import '../model/cart_model.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cycle_resale_app/pages/cart_page.dart' as CartPage;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Uint8List? _image;

  // Add this method to update the _image variable
  void setImage(Uint8List image) {
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD67BFF),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 48),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Text("Holla Guys"),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              "Revitalize Your Ride: Explore Premium Cycles for You",
              style: GoogleFonts.notoSerif(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Divider(),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              "Fresh Arrivals",
              style: GoogleFonts.notoSerif(
                fontSize: 20,
              ),
            ),
          ),
          Expanded(
            child: Consumer<CartModel>(
              builder: (context, value, child) {
                return GridView.builder(
                  padding: const EdgeInsets.all(12),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: value.shopItems.length,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 1.2,
                  ),
                  itemBuilder: (context, index) {
                    return CycleItemTile(
                      itemName: value.shopItems[index][0],
                      itemPrice: value.shopItems[index][1],
                      imagePath: value.shopItems[index][2],
                      color: value.shopItems[index][3],
                      onPressed: () => Provider.of<CartModel>(context,
                          listen: false)
                          .addItemToCart(index),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.black,
            onPressed: () async {
              // Navigate to the PickImage when the camera icon is pressed
              Uint8List? selectedImage = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GalleryImage(
                    setImage: setImage, onImageSelected: null,
                  ),
                ),
              );
              if (selectedImage != null) {
                setImage(selectedImage);
              }
            },
            child: const Icon(Icons.camera_alt),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            backgroundColor: Colors.black,
            onPressed: () {
              if (_image != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartPage.CartPage(imageBytes: _image!),
                  ),
                );

              } else {
                // Handle the case where no image is selected, show a message, or do nothing
                print("No image selected");
              }
            },
            child: const Icon(Icons.shopping_bag),
          ),
        ],
      ),
    );
  }
}
