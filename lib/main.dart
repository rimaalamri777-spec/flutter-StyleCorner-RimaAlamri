import 'package:flutter/material.dart';
import 'data.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const StyleCornerApp());
}

class StyleCornerApp extends StatelessWidget {
  const StyleCornerApp({super.key});

  @override
  Widget build(BuildContext context) {
    // نسمع لتغيير الوضع الليلي
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeMode,
      builder: (context, mode, child) {
        return MaterialApp(
          title: 'Style Corner',
          debugShowCheckedModeBanner: false,
          themeMode: mode,
          theme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: mainColor,
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: mainColor,
            brightness: Brightness.dark,
          ),
          // اتجاه التطبيق من اليمين لليسار
          builder: (context, child) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: child!,
            );
          },
          home: const SplashScreen(),
        );
      },
    );
  }
}
