import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "SharedPreferences Demo",
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
        // تحسين شكل الحقول الافتراضي
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: Colors.grey.shade100,
        ),
      ),
      home: const UserFormPage(),
    );
  }
}

class UserFormPage extends StatefulWidget {
  const UserFormPage({super.key});

  @override
  State<UserFormPage> createState() => _UserFormPageState();
}

class _UserFormPageState extends State<UserFormPage> {
  // مفتاح النموذج للتحقق من البيانات
  final _formKey = GlobalKey<FormState>();

  // المتحكمات في النصوص
  final TextEditingController _usernameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();

  bool _autoValidate = false;

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  @override
  void dispose() {
    _usernameCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  // --- دوال التعامل مع البيانات (Logic) ---

  // 1. تحميل البيانات عند فتح التطبيق
  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _usernameCtrl.text = prefs.getString('username') ?? '';
      _emailCtrl.text = prefs.getString('email') ?? '';
    });
  }

  // 2. حفظ البيانات
  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', _usernameCtrl.text.trim());
    await prefs.setString('email', _emailCtrl.text.trim());
  }

  // 3. حذف البيانات
  Future<void> _clearData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // مسح كل شيء
    setState(() {
      _usernameCtrl.clear();
      _emailCtrl.clear();
    });
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم مسح البيانات المخزنة'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  // --- دوال التحقق (Validation) ---

  String? _validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) return 'هذا الحقل مطلوب';
    if (value.trim().length < 3) return 'الاسم قصير جداً (3 أحرف على الأقل)';
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'هذا الحقل مطلوب';
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'يرجى إدخال بريد Gmail صحيح';
    }
    return null;
  }

  // دالة الضغط على زر الحفظ
  void _submit() async {
    setState(() => _autoValidate = true); // تفعيل التحقق التلقائي عند أول محاولة

    if (_formKey.currentState?.validate() ?? false) {
      // إذا كانت البيانات صحيحة
      await _saveData(); // ننتظر الحفظ

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم حفظ البيانات بنجاح ✅'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ),
        );
        // إخفاء لوحة المفاتيح
        FocusScope.of(context).unfocus();
      }
    } else {
      // إذا كان هناك أخطاء
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('يرجى تصحيح الأخطاء أولاً'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("بيانات المستخدم"),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: "حذف البيانات",
            icon: const Icon(Icons.delete_forever, color: Colors.red),
            onPressed: _clearData,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          autovalidateMode: _autoValidate
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // حقل اسم المستخدم
              TextFormField(
                controller: _usernameCtrl,
                decoration: const InputDecoration(
                  labelText: 'اسم المستخدم',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: _validateUsername,
                textInputAction: TextInputAction.next,
                // تحديث الواجهة عند الكتابة لتظهر النتيجة في البطاقة بالأسفل فوراً
                onChanged: (val) => setState(() {}),
              ),

              const SizedBox(height: 16),

              // حقل البريد الإلكتروني
              TextFormField(
                controller: _emailCtrl,
                decoration: const InputDecoration(
                  labelText: 'البريد الإلكتروني (Gmail)',
                  prefixIcon: Icon(Icons.email_outlined),
                  hintText: 'example@gmail.com',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: _validateEmail,
                textInputAction: TextInputAction.done,
                onChanged: (val) => setState(() {}),
              ),

              const SizedBox(height: 24),

              // زر الحفظ
              ElevatedButton.icon(
                onPressed: _submit,
                icon: const Icon(Icons.save),
                label: const Text('حفظ البيانات', style: TextStyle(fontSize: 16)),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
              ),

              const SizedBox(height: 30),

              // بطاقة لعرض البيانات الحالية (للتوضيح فقط)
              Card(
                elevation: 4,
                shadowColor: Colors.blue.withOpacity(0.2),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text(
                        "معاينة البيانات (Live)",
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                      const Divider(),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text("الاسم:"),
                        subtitle: Text(
                          _usernameCtrl.text.isEmpty ? "---" : _usernameCtrl.text,
                          style: const TextStyle(fontSize: 16, color: Colors.black87),
                        ),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text("البريد:"),
                        subtitle: Text(
                          _emailCtrl.text.isEmpty ? "---" : _emailCtrl.text,
                          style: const TextStyle(fontSize: 16, color: Colors.black87),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}