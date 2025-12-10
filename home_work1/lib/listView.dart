import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "List View",
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5), // خلفية رمادية فاتحة
      ),
      home: const ModernListView(),
    );
  }
}

class ModernListView extends StatefulWidget {
  const ModernListView({super.key});

  @override
  State<ModernListView> createState() => _ModernListViewState();
}

class _ModernListViewState extends State<ModernListView> {
  // بيانات تجريبية
  List<Map<String, dynamic>> items = [
    {
      "title": "تطوير الويب",
      "subtitle": "HTML, CSS, JS & Flutter Web",
      "image": "https://picsum.photos/id/1/200/200",
      "favorite": false,
    },
    {
      "title": "الذكاء الاصطناعي",
      "subtitle": "Python, TensorFlow & PyTorch",
      "image": "https://picsum.photos/id/2/200/200",
      "favorite": true,
    },
    {
      "title": "التسويق الرقمي",
      "subtitle": "SEO, Ads & Social Media",
      "image": "https://picsum.photos/id/3/200/200",
      "favorite": false,
    },
    {
      "title": "إدارة المشاريع",
      "subtitle": "Agile, Scrum & Jira",
      "image": "https://picsum.photos/id/4/200/200",
      "favorite": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "القائمة الحديثة",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        elevation: 0,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        // فاصل شفاف بين كل عنصر والآخر
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          return _buildModernItem(items[index], index);
        },
      ),
    );
  }

  Widget _buildModernItem(Map<String, dynamic> item, int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            // حدث عند الضغط على الكارت بالكامل
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("اخترت: ${item['title']}"),
                backgroundColor: Colors.indigo,
                duration: const Duration(milliseconds: 500),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                // 1. الصورة بتصميم دائري أو مربع بحواف ناعمة
                Hero(
                  tag: 'img-$index', // تجهيز لأنيميشن انتقال لو أردت مستقبلاً
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: NetworkImage(item["image"]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                // 2. النصوص
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item["title"],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        item["subtitle"],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),

                // 3. زر المفضلة مع أنيميشن التبديل
                GestureDetector(
                  onTap: () {
                    setState(() {
                      items[index]["favorite"] = !items[index]["favorite"];
                    });
                  },
                  // AnimatedSwitcher يعمل حركة جميلة عند تغير الأيقونة
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, anim) => ScaleTransition(
                      scale: anim,
                      child: child,
                    ),
                    child: Icon(
                      items[index]["favorite"]
                          ? Icons.favorite
                          : Icons.favorite_border_rounded,
                      // المفتاح Key ضروري ليعرف فلاتر أن الأيقونة تغيرت
                      key: ValueKey<bool>(items[index]["favorite"]),
                      color: items[index]["favorite"] ? Colors.redAccent : Colors.grey,
                      size: 28,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}