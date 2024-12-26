import 'package:ecommerce/Product/Product_listing/product_detail.dart';
import 'package:ecommerce/Product/Product_listing/product_wishlist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../Models/product.dart';
import '../product_listing_provider.dart';

class ProductListingScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productAsyncValue = ref.watch(productProvider);
    final favoriteProducts = ref.watch(favoriteProductsProvider);
    final favoriteCount = favoriteProducts.length;
    return Scaffold(
      backgroundColor: CupertinoColors.systemGrey6,
      appBar: AppBar(
        title: const Text(
          'Product Listing',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: CupertinoColors.destructiveRed,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 32.0),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                IconButton(
                  onPressed: () {
                    print(("tapp"));
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductWishListingScreen(),
                      ),
                    );
                  },
                  icon: const Icon(CupertinoIcons.heart, color: Colors.white),
                ),
                if (favoriteCount > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        '$favoriteCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: productAsyncValue.when(
          data: (products) {
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                final isFavorite = favoriteProducts.contains(product);

                return Container(
                  height: 100,
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: CupertinoColors.white,
                    border: Border.all(color: Colors.black12, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8), // Apply circular radius to the image
                      child: CachedNetworkImage(
                        imageUrl: product.image,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                    ),
                    title: Text(
                      product.name,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: CupertinoColors.label),
                    ),
                    subtitle: Text('\$${product.price}'),
                    trailing: IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : null,
                      ),
                      onPressed: () {
                        // Toggle the favorite status of the product
                        ref.read(favoriteProductsProvider.notifier).toggleFavorite(product);
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailScreen(product: product),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Error: $error')),
        ),
      ),
    );
  }
}









