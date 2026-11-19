import 'package:flutter/material.dart';
import '../data.dart';

// شاشة تم الطلب (تستقبل المجموع وعدد القطع من السلة)
class OrderDoneScreen extends StatelessWidget {
  final int total;
  final int count;

  const OrderDoneScreen({super.key, required this.total, required this.count});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    // رقم طلب بسيط من الوقت
    int orderNumber = DateTime.now().millisecondsSinceEpoch % 100000;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // حركة تكبير لعلامة الصح
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 700),
                curve: Curves.elasticOut,
                builder: (context, value, child) {
                  return Transform.scale(scale: value, child: child);
                },
                child: Container(
                  width: 130,
                  height: 130,
                  decoration: const BoxDecoration(
                    gradient: mainGradient,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, size: 80, color: Colors.white),
                ),
              ),
              const SizedBox(height: 28),
              const Text(
                'تم تأكيد طلبك!',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text('شكرًا لك $currentUser 💖',
                  style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 28),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: colors.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('رقم الطلب'),
                        Text('#$orderNumber',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('عدد القطع'),
                        Text('$count',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('المجموع مع التوصيل'),
                        Text('$total ريال',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 36),
              FilledButton(
                style: FilledButton.styleFrom(
                  shape: const StadiumBorder(),
                  minimumSize: const Size.fromHeight(54),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text('العودة للمتجر',
                    style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
