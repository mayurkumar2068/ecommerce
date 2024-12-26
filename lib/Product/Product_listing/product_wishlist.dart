import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/Onboarding/onboarding.dart';
import 'package:ecommerce/Onboarding/userprofile.dart';
import 'package:ecommerce/Product/Product_listing/product_detail.dart';
import 'package:ecommerce/Product/Product_listing/product_listing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../product_listing_provider.dart';

class ProductWishListingScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productAsyncValue = ref.watch(productProvider);
    final favoriteProducts = ref.watch(favoriteProductsProvider);
    final favoriteCount = favoriteProducts.length;

    return Scaffold(
      backgroundColor: CupertinoColors.systemGrey6,
      appBar: AppBar(
        title: const Text(
          'Product Wishlist',
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
            padding: const EdgeInsets.only(right: 12.0),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(),
                      ),
                    );
                  },
                  icon: const Icon(CupertinoIcons.profile_circled, color: Colors.white),
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
            final favoriteItems = products.where((product) => favoriteProducts.contains(product)).toList();

            // Check if favorites are being shown
            if (favoriteItems.isEmpty) {
              return const Center(
                child: Text(
                  'No favorite items yet.',
                  style: TextStyle(fontSize: 16, color: CupertinoColors.inactiveGray),
                ),
              );
            }

            return ListView.builder(
              itemCount: favoriteItems.length,
              itemBuilder: (context, index) {
                final product = favoriteItems[index];
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
                      borderRadius: BorderRadius.circular(8),
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
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: CupertinoColors.label),
                    ),
                    subtitle: Text('\$${product.price}'),
                    trailing: IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : null,
                      ),
                      onPressed: () {
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