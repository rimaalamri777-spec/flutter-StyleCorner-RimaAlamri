import 'package:flutter/material.dart';
import '../data.dart';
import 'main_screen.dart';
import 'register_screen.dart';

// شاشة تسجيل الدخول
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  String error = '';

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    // حقل فارغ
    if (username.isEmpty || password.isEmpty) {
      setState(() {
        error = 'الرجاء تعبئة جميع الحقول';
      });
      return;
    }

    // نبحث في قائمة المستخدمين
    bool found = false;
    for (var user in users) {
      if (user['username'] == username && user['password'] == password) {
        found = true;
      }
    }

    // بيانات غير صحيحة
    if (!found) {
      setState(() {
        error = 'اسم المستخدم أو كلمة المرور غير صحيحة';
      });
      return;
    }

    currentUser = username;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // الجزء العلوي الملون
            Container(
              width: double.infinity,
              height: 280,
              decoration: const BoxDecoration(
                gradient: mainGradient,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(80),
                  bottomRight: Radius.circular(80),
                ),
              ),
              child: const SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('👜', style: TextStyle(fontSize: 70)),
                    SizedBox(height: 10),
                    Text(
                      'أهلًا بعودتك',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'سجّلي دخولك لمتابعة التسوق',
                      style: TextStyle(fontSize: 15, color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      hintText: 'اسم المستخدم',
                      prefixIcon: const Icon(Icons.person_outline),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'كلمة المرور',
                      prefixIcon: const Icon(Icons.lock_outline),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  if (error.isNotEmpty)
                    Row(
                      children: [
                        Icon(Icons.error_outline, color: colors.error),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(error,
                              style: TextStyle(color: colors.error)),
                        ),
                      ],
                    ),
                  const SizedBox(height: 20),
                  FilledButton(
                    style: FilledButton.styleFrom(
                      shape: const StadiumBorder(),
                      minimumSize: const Size.fromHeight(54),
                    ),
                    onPressed: login,
                    child: const Text('دخول', style: TextStyle(fontSize: 18)),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterScreen()),
                      );
                    },
                    child: const Text('جديدة هنا؟ أنشئي حسابًا'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
