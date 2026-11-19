import 'package:flutter/material.dart';
import '../data.dart';

// شاشة إنشاء حساب
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  String error = '';

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void register() {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    // حقل فارغ
    if (username.isEmpty || password.isEmpty) {
      setState(() {
        error = 'الرجاء تعبئة جميع الحقول';
      });
      return;
    }

    // اسم المستخدم مسجل من قبل
    for (var user in users) {
      if (user['username'] == username) {
        setState(() {
          error = 'اسم المستخدم مسجّل مسبقًا، اختاري اسمًا آخر';
        });
        return;
      }
    }

    users.add({'username': username, 'password': password});

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم إنشاء الحساب بنجاح، سجّلي دخولك الآن')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 220,
              decoration: const BoxDecoration(
                gradient: mainGradient,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(80),
                  bottomRight: Radius.circular(80),
                ),
              ),
              child: SafeArea(
                child: Stack(
                  children: [
                    // زر الرجوع
                    PositionedDirectional(
                      top: 4,
                      start: 8,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('✨', style: TextStyle(fontSize: 50)),
                          SizedBox(height: 6),
                          Text(
                            'حساب جديد',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
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
                    onPressed: register,
                    child: const Text('إنشاء الحساب',
                        style: TextStyle(fontSize: 18)),
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
