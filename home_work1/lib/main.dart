import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'المسبحة الإلكترونية',
        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,

        ),
        home: const  MyHomePage(title: "المسبحة الإلكترونية")


    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _subhanAllahCounter = 0;
  int _alhamdulillahCounter = 0;
  int _allahuAkbarCounter = 0;


  void _incrementSubhanAllah() {
    setState(() {
      if (_subhanAllahCounter >= 33) {
        _subhanAllahCounter = 0;
      } else {
        _subhanAllahCounter++;
      }
    });
  }
  void _incrementAlhamdulillah() {
    setState(() {
      if (_alhamdulillahCounter >= 33) {
        _alhamdulillahCounter = 0;
      } else {
        _alhamdulillahCounter++;
      }
    });
  }

  void _incrementAllahuAkbar() {
    setState(() {
      if (_allahuAkbarCounter >= 33) {
        _allahuAkbarCounter = 0;
      } else {
        _allahuAkbarCounter++;
      }
    });
  }

  void _resetAllCounters() {
    setState(() {
      _subhanAllahCounter = 0;
      _alhamdulillahCounter = 0;
      _allahuAkbarCounter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,

        title: const Text("المسبحة الإلكترونية"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(

        child:Padding(



          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 5), // إضافة مسافة علوية لتحسين التوسيط البصري عند التمرير
              _buildTasbihCard(
                title: "سبحان الله",
                counter: _subhanAllahCounter,
                onPressed: _incrementSubhanAllah,
              ),
              const SizedBox(height: 10),
              _buildTasbihCard(
                title: "الحمدلله",
                counter: _alhamdulillahCounter,
                onPressed: _incrementAlhamdulillah,
              ),
              const SizedBox(height: 10),ColoredBox(color: Colors.blue),
              _buildTasbihCard(

                title: "الله أكبر",
                counter: _allahuAkbarCounter,
                onPressed: _incrementAllahuAkbar,
              ),
              const SizedBox(height:10)// إضافة مسافة سفلية لتجنب تداخل المحتوى مع الزر العائم
            ],
          ),
        ),
      ),



      floatingActionButton: FloatingActionButton(
        onPressed: _resetAllCounters,
        tooltip: 'تصفير الكل',
        child: const Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildTasbihCard({required String title, required int counter, required VoidCallback onPressed}) {
    return Card(


      elevation: 4.0,
      child: Padding(


        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
        child: Column(

          children: [

            Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87 ),
            ),
            const SizedBox(height: 5),

            ElevatedButton(
              onPressed: onPressed,

              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 60 ),

                textStyle: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              child: Text('$counter'),
            ),
          ],
        ),
      ),
    );
  }

}
