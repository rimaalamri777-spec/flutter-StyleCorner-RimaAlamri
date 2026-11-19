import 'package:flutter/material.dart';
import '../data.dart';
import '../widgets/product_row.dart';
import 'product_details_screen.dart';

// تبويب المتجر
class ShopTab extends StatelessWidget {
  final VoidCallback refresh;

  const ShopTab({super.key, required this.refresh});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    // الأكثر مبيعًا: أول 4 منتجات
    List<Product> topProducts = products.take(4).toList();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'مرحبًا $currentUser 👋',
          style: TextStyle(fontSize: 16, color: colors.outline),
        ),
        const SizedBox(height: 4),
        const Text(
          'اكتشفي أحدث المنتجات',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        // بانر العرض
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: mainGradient,
            borderRadius: BorderRadius.circular(26),
          ),
          child: const Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'خصم 20%',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'على أول طلب لك',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Text('🎁', style: TextStyle(fontSize: 60)),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'الأكثر مبيعًا',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: topProducts.length,
            itemBuilder: (context, index) {
              Product product = topProducts[index];
              return GestureDetector(
                onTap: () => openDetails(context, product, refresh),
                child: Container(
                  width: 135,
                  margin: const EdgeInsetsDirectional.only(end: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: product.color,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(product.emoji, style: const TextStyle(fontSize: 56)),
                      Column(
                        children: [
                          Text(
                            product.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            '${product.price} ريال',
                            style: const TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'كل المنتجات',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...products.map((product) {
          return ProductRow(
            product: product,
            onTap: () => openDetails(context, product, refresh),
            onHeart: () {
              toggleFavorite(product);
              refresh();
            },
          );
        }),
      ],
    );
  }
}
