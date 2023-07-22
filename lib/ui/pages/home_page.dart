import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school_project/ui/pages/Bar/profile_page.dart';
import 'package:school_project/ui/pages/Bar/tool_page.dart';

import '../textures/glassmorphism.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  final List<Widget> _pageList = [
    const ToolPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawerEdgeDragWidth: 100,
        drawer: _buildDrawer(),
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: _pageList,
        ));
  }

  Widget _buildDrawer() {
    return SizedBox(
        width: 200,
        child: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const SizedBox(
                height: 100,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text('hello there',style: TextStyle(fontSize: 20),),
                ),
              ),
              _buildTile("tool", 0),
              _buildTile("profile", 1),
            ],
          ),
        ));
  }

  Widget _buildTile(String name, int index) {
    return SizedBox(
      height: 50,
      child:ListTile(
        title: Text(name,style: const TextStyle(fontSize: 20),),
        selected: _currentIndex == index,
        onTap: () {
          setState(() {
            _currentIndex = index;
            _pageController.jumpToPage(_currentIndex);
          });
          Navigator.pop(context);
        },
      )
    );
  }
}
