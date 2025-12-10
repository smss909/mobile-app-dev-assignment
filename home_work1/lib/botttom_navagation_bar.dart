import 'package:flutter/material.dart';
import 'account.dart';
import 'home_page.dart';
import 'search_page.dart';
import 'setting.dart';

class Btnnavnar extends StatefulWidget {
  const Btnnavnar({super.key});

  @override
  State<Btnnavnar> createState() => _BtnnavnarState();
}

class _BtnnavnarState extends State<Btnnavnar> {
  int crrent_Index = 0;
  List pages = [HomePageE(), SearchPageE(), SettingE(), AccountE(),];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bottom Navigation Bar"),
      backgroundColor: Colors.purple,),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon:Icon(Icons.home),
            label:"  Main"
          ),
          BottomNavigationBarItem(
              icon:Icon(Icons.search),
              label:"Search"
          ),
          BottomNavigationBarItem(
              icon:Icon(Icons.settings),
              label:"  Settings "
          ),

          BottomNavigationBarItem(
              icon:Icon(Icons.account_circle),
              label:"  Account "
          ),
        ],
        currentIndex:crrent_Index,
        onTap: (index){
          setState(() {
            crrent_Index = index;
          });
        },
      ),
      body: pages[crrent_Index],

    );
  }
}
