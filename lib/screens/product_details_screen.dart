import 'package:flutter/material.dart';
import '../data.dart';

// نفتح شاشة التفاصيل وننقل لها المنتج المختار، وبعد الرجوع نحدث الشاشة الرئيسية
Future<void> openDetails(
    BuildContext context, Product product, VoidCallback refresh) async {
  await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ProductDetailsScreen(product: product),
    ),
  );
  refresh();
}

// شاشة تفاصيل المنتج
class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    Product product = widget.product;
    final colors = Theme.of(context).colorScheme;
    bool fav = isFavorite(product);

    return Scaffold(
      body: Column(
        children: [
          // الجزء العلوي: صورة المنتج
          Container(
            width: double.infinity,
            height: 330,
            decoration: BoxDecoration(
              color: product.color,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            child: SafeArea(
              child: Stack(
                children: [
                  Center(
                    child: Text(product.emoji,
                        style: const TextStyle(fontSize: 130)),
                  ),
                  PositionedDirectional(
                    top: 8,
                    start: 12,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back,
                            color: Colors.black87),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                  PositionedDirectional(
                    top: 8,
                    end: 12,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: Icon(
                          fav ? Icons.favorite : Icons.favorite_border,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          setState(() {
                            toggleFavorite(product);
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          product.name,
                          style: const TextStyle(
                              fontSize: 26, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        '${product.price} ريال',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: colors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    product.description,
                    style: const TextStyle(fontSize: 16, height: 1.6),
                  ),
                  const SizedBox(height: 24),
                  // اختيار الكمية
                  Row(
                    children: [
                      const Text('الكمية',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const Spacer(),
                      IconButton.filledTonal(
                        onPressed: () {
                          if (quantity > 1) {
                            setState(() {
                              quantity--;
                            });
                          }
                        },
                        icon: const Icon(Icons.remove),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text('$quantity',
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold)),
                      ),
                      IconButton.filledTonal(
                        onPressed: () {
                          setState(() {
                            quantity++;
                          });
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // الزر ثابت في الأسفل
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
            child: FilledButton(
              style: FilledButton.styleFrom(
                shape: const StadiumBorder(),
                minimumSize: const Size.fromHeight(56),
              ),
              onPressed: () {
                addToCart(product, quantity);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تمت الإضافة إلى السلة')),
                );
                Navigator.pop(context);
              },
              child: Text(
                'أضيفي إلى السلة  •  ${product.price * quantity} ريال',
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
