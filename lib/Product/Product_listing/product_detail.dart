import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/Onboarding/userprofile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Models/product.dart';
import '../product_listing_provider.dart';

class ProductDetailScreen extends ConsumerWidget {
  final Product product;

  const ProductDetailScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final favoriteProducts = ref.watch(favoriteProductsProvider);

    final isFavorite = favoriteProducts.contains(product);

    return Scaffold(
      backgroundColor: CupertinoColors.white,
      appBar: AppBar(
        title: const Text(
          'Product Details',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: CupertinoColors.destructiveRed,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: CupertinoColors.white
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: MediaQuery.of(context).size.width * 0.5,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: CupertinoColors.white
                ),
                child: CachedNetworkImage(
                  imageUrl: product.image,
                  width: double.infinity,
                  height: width,
                  fit: BoxFit.scaleDown,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              SizedBox(height: width * 0.1),
              Text(
                product.name,
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18),
              ),
              SizedBox(height: width * 0.02),
              Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: TextStyle(fontWeight: FontWeight.w500, color: CupertinoColors.activeGreen, fontSize: 16),
              ),
              SizedBox(height: width * 0.05),
              Text(
                product.description,
                style: TextStyle(fontWeight: FontWeight.normal, color: CupertinoColors.label, fontSize: 15),
              ),
              SizedBox(height: width * 0.05),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailScreen(product: product),
                    ),
                  );
                },
                child: const Text('Add to Cart',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: CupertinoColors.systemRed,
                  foregroundColor: CupertinoColors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                ),
              ),
              SizedBox(height: width * 0.05),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>ProfileScreen()));
                },
                child: Text("Go to profile",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}