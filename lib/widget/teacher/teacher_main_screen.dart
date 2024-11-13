import 'package:flutter/material.dart';
import 'package:slost_only1/widget/dolbom/teacher/manage_dolbom_screen.dart';
import 'package:slost_only1/widget/dolbom/teacher/matching_dolbom_screen.dart';
import 'package:slost_only1/widget/teacher/teacher_my_page_screen.dart';

class TeacherMainScreen extends StatefulWidget {
  const TeacherMainScreen({super.key});

  @override
  State<TeacherMainScreen> createState() => _TeacherMainScreenState();
}

class _TeacherMainScreenState extends State<TeacherMainScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    MatchingDolbomScreen(),
    ManageDolbomScreen(),
    TeacherMyPageScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '돌봄 공고',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: '내 방문',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: '마이페이지',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}