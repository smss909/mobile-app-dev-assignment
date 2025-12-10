import 'dart:io'; // مكتبة التعامل مع الملفات
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart'; // لتحديد مسار التخزين

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  // دالة حفظ البيانات في الملف
  Future<void> _register() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء تعبئة جميع الحقول')),
      );
      return;
    }

    try {
      // 1. الحصول على المسار
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/users_data.txt');

      // 2. تجهيز النص بالتنسيق المطلوب
      // username: اسم المستخدم, pass: كلمة المرور
      String newData = "username: $username, pass: $password\n";

      // 3. الكتابة في الملف (mode: append يعني إضافة للنهاية وليس مسح القديم)
      await file.writeAsString(newData, mode: FileMode.append);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم إنشاء الحساب بنجاح! قم بتسجيل الدخول')),
      );

      // العودة لصفحة الدخول
      Navigator.pop(context);

    } catch (e) {
      print("Error saving file: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("إنشاء حساب جديد")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'اختر اسم مستخدم',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'اختر كلمة مرور',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _register, // استدعاء دالة الحفظ
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
              child: const Text('حفظ الحساب'),
            ),
          ],
        ),
      ),
    );
  }
}