import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:FlutterTask/models/product.dart';
import '../services/api_service.dart';

final productProvider = FutureProvider<List<Product>>((ref) async {
  return await ApiService.fetchProducts();
});

final favoritesProvider = StateNotifierProvider<FavoritesNotifier, List<int>>((ref) {
  return FavoritesNotifier();
});

class FavoritesNotifier extends StateNotifier<List<int>> {
  FavoritesNotifier() : super([]);

  void toggleFavorite(int productId) {
    if (state.contains(productId)) {
      state = state.where((id) => id != productId).toList();
    } else {
      state = [...state, productId];
    }
  }
}
