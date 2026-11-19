import 'package:flutter/material.dart';
import '../data.dart';
import 'login_screen.dart';

// تبويب حسابي
class AccountTab extends StatelessWidget {
  final VoidCallback refresh;

  const AccountTab({super.key, required this.refresh});

  void logout(BuildContext context) {
    currentUser = '';
    cart.clear();
    favorites.clear();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    // أول حرف من اسم المستخدم
    String firstLetter = currentUser.isNotEmpty ? currentUser[0] : '?';

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'حسابي',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24),
        Center(
          child: CircleAvatar(
            radius: 48,
            backgroundColor: mainColor,
            child: Text(
              firstLetter,
              style: const TextStyle(fontSize: 40, color: Colors.white),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: Text(
            currentUser,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 24),
        Container(
          decoration: BoxDecoration(
            color: colors.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.favorite),
                title: const Text('المنتجات المفضلة'),
                trailing: Text('${favorites.length}'),
              ),
              ListTile(
                leading: const Icon(Icons.shopping_bag),
                title: const Text('القطع في السلة'),
                trailing: Text('${cartCount()}'),
              ),
              SwitchListTile(
                secondary: const Icon(Icons.dark_mode),
                title: const Text('الوضع الليلي'),
                value: isDark,
                onChanged: (value) {
                  themeMode.value = value ? ThemeMode.dark : ThemeMode.light;
                  refresh();
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        OutlinedButton.icon(
          style: OutlinedButton.styleFrom(
            shape: const StadiumBorder(),
            minimumSize: const Size.fromHeight(52),
          ),
          onPressed: () => logout(context),
          icon: const Icon(Icons.logout),
          label: const Text('تسجيل الخروج', style: TextStyle(fontSize: 17)),
        ),
      ],
    );
  }
}
