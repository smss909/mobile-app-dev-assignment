import 'package:flutter/material.dart';

class HomePageE extends StatefulWidget {
  const HomePageE({super.key});

  @override
  State<HomePageE> createState() => _HomePageEState();
}

class _HomePageEState extends State<HomePageE> {
  TextEditingController firstText = TextEditingController();
  TextEditingController secondText= TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Text(" Main Page ", style: TextStyle(fontSize: 25)),
              SizedBox(height: 17),

              TextField(
                controller: firstText,
                decoration: InputDecoration(
                  label: Text("Enter Text Here"),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 17),

              TextField(
                controller: secondText,
                decoration: InputDecoration(
                  label: Text("Just View"),
                  border: OutlineInputBorder(),
                  enabled: false,
                ),
              ),

              SizedBox(height: 17),

              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      secondText.text= firstText.text;
                    });
                  },

                  child: Text("Print",
                    style: TextStyle(color: Colors.black ) ,
                    ),
                  style:ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple[300],

                  ),
              ),

            ],
          ),
        ),

    );
  }
}


