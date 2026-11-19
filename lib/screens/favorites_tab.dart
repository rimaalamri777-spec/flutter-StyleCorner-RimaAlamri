import 'package:flutter/material.dart';
import '../data.dart';
import '../widgets/product_row.dart';
import 'product_details_screen.dart';

// تبويب المفضلة (الميزة الإضافية)
class FavoritesTab extends StatelessWidget {
  final VoidCallback refresh;

  const FavoritesTab({super.key, required this.refresh});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'المفضلة ❤️',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: favorites.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('🤍', style: TextStyle(fontSize: 70)),
                        SizedBox(height: 10),
                        Text('لا توجد منتجات في المفضلة',
                            style: TextStyle(fontSize: 18)),
                        SizedBox(height: 4),
                        Text('اضغطي على القلب في أي منتج لإضافته'),
                      ],
                    ),
                  )
                : ListView(
                    children: favorites.map((product) {
                      return ProductRow(
                        product: product,
                        onTap: () => openDetails(context, product, refresh),
                        onHeart: () {
                          toggleFavorite(product);
                          refresh();
                        },
                      );
                    }).toList(),
                  ),
          ),
        ],
      ),
    );
  }
}
