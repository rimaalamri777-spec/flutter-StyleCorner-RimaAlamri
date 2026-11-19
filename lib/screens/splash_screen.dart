import 'package:flutter/material.dart';
import '../data.dart';
import 'login_screen.dart';

// الشاشة الافتتاحية
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(gradient: mainGradient),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const Spacer(flex: 2),
                Container(
                  width: 150,
                  height: 150,
                  decoration: const BoxDecoration(
                    color: Colors.white24,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text('👜', style: TextStyle(fontSize: 80)),
                  ),
                ),
                const SizedBox(height: 28),
                const Text(
                  'ركن الأناقة',
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  'Style Corner',
                  style: TextStyle(
                    fontSize: 20,
                    letterSpacing: 3,
                    color: Colors.white,
                  ),
                ),
                const Spacer(flex: 2),
                const Text(
                  'إعداد الطالبة: ريما العمري',
                  style: TextStyle(fontSize: 17, color: Colors.white),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Prepared by: Rima Alamri',
                  style: TextStyle(fontSize: 15, color: Colors.white70),
                ),
                const SizedBox(height: 30),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: mainColor,
                    shape: const StadiumBorder(),
                    minimumSize: const Size(220, 54),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  },
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('ابدأ التسوق | Start',
                      style: TextStyle(fontSize: 17)),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
