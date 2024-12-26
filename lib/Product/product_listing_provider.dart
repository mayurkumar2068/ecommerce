import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Models/product.dart';

// Define the provider for the product list
final productProvider = FutureProvider<List<Product>>((ref) async {
  final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));
  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((json) => Product.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load products');
  }
});

class FavoriteProductsNotifier extends StateNotifier<List<Product>> {
  FavoriteProductsNotifier() : super([]);

  // Method to add a product to the favorite list
  void toggleFavorite(Product product) {
    if (state.contains(product)) {
      state = state.where((p) => p.name != product.name).toList();
    } else {
      state = [...state, product];
    }
  }
  int getFavoriteCount(Product product) {
    return state.where((p) => p == product).length;
  }
}

// Define the provider for favorite products (only one provider is needed)
final favoriteProductsProvider =
StateNotifierProvider<FavoriteProductsNotifier, List<Product>>(
      (ref) => FavoriteProductsNotifier(),
);
final favoriteCountProvider = Provider.family<int, Product>((ref, product) {
  final favoriteProducts = ref.watch(favoriteProductsProvider);
  return favoriteProducts.where((p) => p == product).length;
});
