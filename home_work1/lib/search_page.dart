import 'package:flutter/material.dart';

class SearchPageE extends StatelessWidget {
  const SearchPageE({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
          children: [
            ListTile(
              leading: Text("1") ,
              title: Text("sohaib"),
              subtitle: Text("IT"),
              trailing: Text("2025"),
            ),
            ListTile(
              leading: Text("2") ,
              title: Text("Alzubair"),
              subtitle: Text("IT"),
              trailing: Text("2024"),
            ),
            ListTile(
              leading: Text("3") ,
              title: Text("Abdullah"),
              subtitle: Text("CS"),
              trailing: Text("2025"),
            ),
            ListTile(
              leading: Text("4") ,
              title: Text("Moath"),
              subtitle: Text("IT"),
              trailing: Text("2025"),
            ),
            ListTile(
              leading: Text("5") ,
              title: Text("Ali"),
              subtitle: Text("IS"),
              trailing: Text("2024"),
            ),
            ListTile(
              leading: Text("6") ,
              title: Text("Ahmed"),
              subtitle: Text("IT"),
              trailing: Text("2025"),
            ),
          ]
      ),
    );
  }
}
