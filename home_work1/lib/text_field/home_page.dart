import 'package:flutter/material.dart';
import 'package:home_work1/text_field/secondPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController firstTextFieldController = TextEditingController();
  TextEditingController secondTextFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الصفحة الرئيسية', textAlign: TextAlign.right),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // الحقل النصي الأول
            TextField(
              controller: firstTextFieldController,
              decoration: InputDecoration(
                labelText: 'Enter The Text Here',
                border: OutlineInputBorder(),
                hintText: 'Write Any Text',
              ),
            ),

            SizedBox(height: 20),

            // الحقل النصي الثاني
            TextField(
              controller: secondTextFieldController,
              decoration: InputDecoration(
                labelText: 'The Written Text',
                border: OutlineInputBorder(),
                enabled: false, // لجعله للعرض فقط
              ),
            ),

            SizedBox(height: 30),

            // زر طباعة النص
            ElevatedButton(
              onPressed: () {
                // نسخ النص من الحقل الأول إلى الثاني
                setState(() {
                  secondTextFieldController.text = firstTextFieldController.text;
                });
              },
              child: Text('طباعة النص'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 50), // حجم الزر
              ),
            ),

            SizedBox(height: 15),

            // زر الانتقال للصفحة الثانية
            ElevatedButton(
              onPressed: () {
                if (firstTextFieldController.text.isNotEmpty) {
                  // الانتقال للصفحة الثانية مع تمرير البيانات
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SecondPage(
                        passedData: firstTextFieldController.text,
                      ),
                    ),
                  );
                } else {
                  // عرض رسالة تنبيه إذا كان الحقل فارغاً
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('الرجاء إدخال نص أولاً'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: Text('انتقال للصفحة الثانية'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    firstTextFieldController.dispose();
    secondTextFieldController.dispose();
    super.dispose();
  }
}