import 'package:flutter/material.dart';
import '../data.dart';
import 'order_done_screen.dart';

// تبويب السلة
class CartTab extends StatelessWidget {
  final VoidCallback refresh;
  final VoidCallback goToShop;

  const CartTab({super.key, required this.refresh, required this.goToShop});

  Future<void> checkout(BuildContext context) async {
    // نحفظ القيم قبل ما نفرغ السلة
    int total = cartSubtotal() + deliveryFee;
    int count = cartCount();
    cart.clear();
    refresh();

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderDoneScreen(total: total, count: count),
      ),
    );
    goToShop();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'سلة التسوق 🛍️',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: cart.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('🛒', style: TextStyle(fontSize: 70)),
                        SizedBox(height: 10),
                        Text('سلتك فارغة', style: TextStyle(fontSize: 20)),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: ListView(
                          children: cart.map((item) {
                            // نسحب العنصر لحذفه
                            return Dismissible(
                              key: ValueKey(item.product.name),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                alignment: AlignmentDirectional.centerEnd,
                                decoration: BoxDecoration(
                                  color: colors.error,
                                  borderRadius: BorderRadius.circular(22),
                                ),
                                child: const Icon(Icons.delete,
                                    color: Colors.white),
                              ),
                              onDismissed: (direction) {
                                cart.remove(item);
                                refresh();
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: colors.surfaceContainerHighest,
                                  borderRadius: BorderRadius.circular(22),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 64,
                                      height: 64,
                                      decoration: BoxDecoration(
                                        color: item.product.color,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Center(
                                        child: Text(item.product.emoji,
                                            style:
                                                const TextStyle(fontSize: 32)),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(item.product.name,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                          Text(
                                            '${item.product.price * item.quantity} ريال',
                                            style: TextStyle(
                                                color: colors.primary),
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                          Icons.remove_circle_outline),
                                      onPressed: () {
                                        if (item.quantity > 1) {
                                          item.quantity--;
                                        } else {
                                          cart.remove(item);
                                        }
                                        refresh();
                                      },
                                    ),
                                    Text('${item.quantity}',
                                        style: const TextStyle(fontSize: 17)),
                                    IconButton(
                                      icon:
                                          const Icon(Icons.add_circle_outline),
                                      onPressed: () {
                                        item.quantity++;
                                        refresh();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      // ملخص الطلب
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: colors.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('المنتجات'),
                                Text('${cartSubtotal()} ريال'),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('التوصيل'),
                                Text('$deliveryFee ريال'),
                              ],
                            ),
                            const Divider(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('المجموع',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                Text('${cartSubtotal() + deliveryFee} ريال',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            const SizedBox(height: 14),
                            FilledButton(
                              style: FilledButton.styleFrom(
                                shape: const StadiumBorder(),
                                minimumSize: const Size.fromHeight(52),
                              ),
                              onPressed: () => checkout(context),
                              child: const Text('إتمام الطلب',
                                  style: TextStyle(fontSize: 18)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
