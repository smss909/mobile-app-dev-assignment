import 'dart:io'; // مكتبة التعامل مع الملفات
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'home_page.dart';
import 'signup_page.dart'; // لتحديد مسار التخزين

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  // دالة تسجيل الدخول وقراءة الملف
  Future<void> _login() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء تعبئة جميع الحقول')),
      );
      return;
    }

    try {
      // 1. الحصول على مسار المجلد
      final directory = await getApplicationDocumentsDirectory();
      // 2. تحديد الملف
      final file = File('${directory.path}/users_data.txt');

      // 3. التحقق هل الملف موجود أصلاً؟
      if (!await file.exists()) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('لا يوجد مستخدمين مسجلين بعد!')),
        );
        return;
      }

      // 4. قراءة الملف سطر بسطر
      List<String> lines = await file.readAsLines();
      bool isFound = false;

      // التنسيق الذي نبحث عنه
      // username: احمد, pass: 123456
      String searchPattern = "username: $username, pass: $password";

      for (String line in lines) {
        if (line.trim() == searchPattern) {
          isFound = true;
          break;
        }
      }

      if (isFound) {
        // الانتقال للصفحة الرئيسية
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('خطأ: اسم المستخدم أو كلمة المرور غير صحيحة')),
        );
      }

    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("تسجيل الدخول")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'اسم المستخدم',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _passwordController,
              obscureText: true, // إخفاء كلمة المرور
              decoration: const InputDecoration(
                labelText: 'كلمة المرور',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _login,
              child: const Text('دخول'),
            ),
            TextButton(
              onPressed: () {
                // الانتقال لصفحة التسجيل
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignupPage()),
                );
              },
              child: const Text('ليس لديك حساب؟ إنشاء حساب جديد'),
            )
          ],
        ),
      ),
    );
  }
}