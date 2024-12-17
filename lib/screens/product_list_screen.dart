import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:FlutterTask/widgets/product_card.dart';
import '../providers/product_provider.dart';
import '../utils/strings.dart';

class ProductListScreen extends ConsumerWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productProvider);

    return Scaffold(
      body: productsAsync.when(
        data: (products) {
          return LayoutBuilder(
            builder: (context, constraints) {
              // Adjust the number of columns based on screen width
              int crossAxisCount = constraints.maxWidth > 1200
                  ? 5 // Large screen (desktop)
                  : constraints.maxWidth > 800
                  ? 3 // Medium screen (tablet)
                  : 2; // Small screen (mobile)

              return GridView.builder(
                padding: const EdgeInsets.all(8.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.7,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  var product_ = products[index];
                  return ProductCard(product: product_);
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Text(
            AppStrings.errorLoadingProducts,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
