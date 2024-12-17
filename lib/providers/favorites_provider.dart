import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';

final favoritesProvider = StateNotifierProvider<FavoritesNotifier, List<Product>>(
      (ref) => FavoritesNotifier(),
);

class FavoritesNotifier extends StateNotifier<List<Product>> {
  FavoritesNotifier() : super([]);

  void toggleFavorite(Product product) {
    if (state.any((item) => item.id == product.id)) {
      removeFavorite(product);
    } else {
      addFavorite(product);
    }
  }

  void addFavorite(Product product) {
    state = [...state, product];
  }

  void removeFavorite(Product product) {
    state = state.where((item) => item.id != product.id).toList();
  }

  bool contains(Product product) => state.any((item) => item.id == product.id);
}
