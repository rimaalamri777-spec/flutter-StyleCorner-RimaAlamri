import 'package:flutter/material.dart';
import '../data.dart';
import 'account_tab.dart';
import 'cart_tab.dart';
import 'favorites_tab.dart';
import 'shop_tab.dart';

// الشاشة الرئيسية: فيها شريط التنقل السفلي بين 4 تبويبات
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  // نعيد بناء الشاشة لتتحدث الأرقام والقوائم
  void refresh() {
    setState(() {});
  }

  void goToShop() {
    setState(() {
      currentIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      ShopTab(refresh: refresh),
      FavoritesTab(refresh: refresh),
      CartTab(refresh: refresh, goToShop: goToShop),
      AccountTab(refresh: refresh),
    ];

    return Scaffold(
      body: SafeArea(child: pages[currentIndex]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.storefront_outlined),
            selectedIcon: Icon(Icons.storefront),
            label: 'المتجر',
          ),
          NavigationDestination(
            icon: Badge(
              label: Text('${favorites.length}'),
              isLabelVisible: favorites.isNotEmpty,
              child: const Icon(Icons.favorite_border),
            ),
            selectedIcon: const Icon(Icons.favorite),
            label: 'المفضلة',
          ),
          NavigationDestination(
            icon: Badge(
              label: Text('${cartCount()}'),
              isLabelVisible: cartCount() > 0,
              child: const Icon(Icons.shopping_bag_outlined),
            ),
            selectedIcon: const Icon(Icons.shopping_bag),
            label: 'السلة',
          ),
          const NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'حسابي',
          ),
        ],
      ),
    );
  }
}
