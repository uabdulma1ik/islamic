import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';
import 'page1.dart';
import 'page2.dart';
import 'page3.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyWidget(),
    ),
  );
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  List pages = [
    Page1(),
    Page2(),
    Page3(),
  ];
  int curIndex = 0;
  void func(index) {
    setState(() {
      curIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages.elementAt(curIndex),
      bottomNavigationBar: WaterDropNavBar(
        barItems: [
          BarItem(
            filledIcon: Icons.home,
            outlinedIcon: Icons.home_outlined,
          ),
          BarItem(
            filledIcon: CupertinoIcons.alarm_fill,
            outlinedIcon: CupertinoIcons.alarm,
          ),
          BarItem(
            filledIcon: Icons.calendar_month,
            outlinedIcon: Icons.calendar_month_outlined,
          ),
        ],
        iconSize: 31,
        selectedIndex: curIndex,
        onItemSelected: func,
        inactiveIconColor: Colors.blueGrey,
        waterDropColor: Colors.green,
      ),
    );
  }
}
