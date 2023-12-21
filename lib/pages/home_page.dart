import 'package:cycle_resale_app/pages/gallery_images.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../components/cycle_item_tile.dart';
import '../model/cart_model.dart';
import 'cart_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD67BFF),
      body: Stack(
        children: [
          Column(
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
          Positioned(
            bottom: 16,
            left: 16,
            child: FloatingActionButton(
              backgroundColor: Colors.black,
              onPressed: () {
                // Navigate to the GalleryPage when camera icon is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GalleryImage(),
                  ),
                );
              },
              child: const Icon(Icons.camera_alt),
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              backgroundColor: Colors.black,
              onPressed: () {
                // Navigate to the CartPage when shopping bag icon is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartPage(),
                  ),
                );
              },
              child: const Icon(Icons.shopping_bag),
            ),
          ),
        ],
      ),
    );
  }
}