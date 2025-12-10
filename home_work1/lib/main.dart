import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My CV',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.grey[200],
        fontFamily: 'Arial',
      ),
      home: const CvScreen(),
    );
  }
}

class CvScreen extends StatelessWidget {
  const CvScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CV", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Center(
          child: Column(
            children: [
              const CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('images/images/me.jpg'),
              ),
              const SizedBox(height: 15),
              const Text(
                'Sohaib Subih',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Mobile App Developer', textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.blueGrey),
              ),

              const SizedBox(height: 10),
              Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.email, color: Colors.teal),
                        const Text(' soheeb.2025@gmail.com'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.phone, color: Colors.teal,),
                        const Text(' +967-773-911-909'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // --- Skills Section ---
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),

                ),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Skills',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children:
                        [
                          'Flutter',
                          'Dart',
                          'Html',
                          'Css',
                          'Javascript',
                          'Git / GitHub',
                        ]
                            .map(
                              (skill) => Chip(
                            label: Text(skill),
                            backgroundColor: Colors.teal[50],
                          ),
                        )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // --- Experience Section ---
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Experience',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                      SizedBox(height: 12),
                      ListTile(
                        title: Text('Flutter Developer'),
                        subtitle: Text(
                          '2025 - Present\nDeveloped cv app using Flutter ',
                        ),
                      ),
                      Divider(),
                      ListTile(
                        title: Text('Frontend Developer'),
                        subtitle: Text(
                          '2023 - 2024\nBuilt responsive web apps using HTML, CSS, and JavaScript.',
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),
              const Text(
                '© 2025 Sohaib Subih',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
