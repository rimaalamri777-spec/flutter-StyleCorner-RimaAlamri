import 'package:flutter/material.dart';

// كل البيانات في الذاكرة فقط (بدون قاعدة بيانات)

// ألوان التطبيق
const Color mainColor = Color(0xFFEE5A7C);

const LinearGradient mainGradient = LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  colors: [Color(0xFFEE5A7C), Color(0xFFFF9A8B)],
);

class Product {
  final String name;
  final String emoji;
  final int price;
  final String description;
  final Color color;

  Product({
    required this.name,
    required this.emoji,
    required this.price,
    required this.description,
    required this.color,
  });
}

class CartItem {
  final Product product;
  int quantity;

  CartItem(this.product, this.quantity);
}

// المستخدمين المسجلين (كل مستخدم Map فيه username و password)
List<Map<String, String>> users = [];

// المستخدم الحالي
String currentUser = '';

// السلة والمفضلة
List<CartItem> cart = [];
List<Product> favorites = [];

// رسوم التوصيل
const int deliveryFee = 15;

// الوضع الليلي
ValueNotifier<ThemeMode> themeMode = ValueNotifier(ThemeMode.light);

bool isFavorite(Product product) {
  return favorites.contains(product);
}

void toggleFavorite(Product product) {
  if (favorites.contains(product)) {
    favorites.remove(product);
  } else {
    favorites.add(product);
  }
}

// إضافة منتج للسلة بالكمية المحددة، ولو موجود نزيد عليه
void addToCart(Product product, int quantity) {
  for (var item in cart) {
    if (item.product == product) {
      item.quantity += quantity;
      return;
    }
  }
  cart.add(CartItem(product, quantity));
}

// عدد القطع في السلة
int cartCount() {
  int count = 0;
  for (var item in cart) {
    count += item.quantity;
  }
  return count;
}

// مجموع المنتجات بدون التوصيل
int cartSubtotal() {
  int total = 0;
  for (var item in cart) {
    total += item.product.price * item.quantity;
  }
  return total;
}

// المنتجات
List<Product> products = [
  Product(
    name: 'حذاء رياضي',
    emoji: '👟',
    price: 280,
    description: 'حذاء خفيف ومريح للمشي والرياضة اليومية، بنعل مرن يمتص الصدمات.',
    color: Color(0xFFFFD6E0),
  ),
  Product(
    name: 'حقيبة يد',
    emoji: '👜',
    price: 220,
    description: 'حقيبة يد أنيقة بتصميم عصري، تتسع للجوال والمحفظة وأغراضك اليومية.',
    color: Color(0xFFFFE5B4),
  ),
  Product(
    name: 'عطر فاخر',
    emoji: '🧴',
    price: 190,
    description: 'عطر برائحة هادئة تدوم طويلًا، يناسب الاستخدام اليومي والمناسبات.',
    color: Color(0xFFD6E6FF),
  ),
  Product(
    name: 'وشاح حريري',
    emoji: '🧣',
    price: 95,
    description: 'وشاح ناعم بألوان جميلة يضيف لمسة أنيقة لأي إطلالة.',
    color: Color(0xFFE0D4FF),
  ),
  Product(
    name: 'نظارة شمسية',
    emoji: '🕶️',
    price: 120,
    description: 'نظارة شمسية بعدسات تحمي العين، وبإطار خفيف وعصري.',
    color: Color(0xFFD4F5E3),
  ),
  Product(
    name: 'ساعة أنيقة',
    emoji: '⌚',
    price: 340,
    description: 'ساعة يد بتصميم كلاسيكي وسوار مريح، مقاومة للماء.',
    color: Color(0xFFFFF3B8),
  ),
  Product(
    name: 'صندوق هدايا',
    emoji: '🎁',
    price: 150,
    description: 'صندوق هدايا جاهز بتغليف جميل، مناسب للأعياد والمناسبات.',
    color: Color(0xFFFFD1C1),
  ),
  Product(
    name: 'قبعة صيفية',
    emoji: '👒',
    price: 60,
    description: 'قبعة واسعة وخفيفة تحميك من الشمس في الرحلات.',
    color: Color(0xFFD1F0F5),
  ),
];
