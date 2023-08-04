import 'package:flutter/material.dart';
import 'package:school_project/api/provider/auth_provider.dart';
import 'package:school_project/ui/pages/Bar/profile_page.dart';
import 'package:school_project/ui/pages/Bar/tool_page.dart';

import '../../api/user/user_api.dart';
import '../../storage/storage.dart';

class HomePage extends StatefulWidget {
  // final User user;
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
  void _signOut(BuildContext context) async {
    final userApi=AuthProvider.of(context).userApi;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return const Dialog(
            backgroundColor: Colors.transparent,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Loading...',
                    style: TextStyle(color: Colors.white,fontSize: 15),
                  )
                ],
              ),
            ),
          );
        });
    final response=await userApi.logout();
    print(response);

    if (context.mounted) {
      if(response.success){
        Navigator.pop(context);
        Navigator.popAndPushNamed(context,'/login');
        UserStorage().writeUser(UserApi().user);
      }
      else{
        Navigator.pop(context);
        setState(() {

        });
      }
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawerEdgeDragWidth: 100,
        drawer: _buildDrawer(),
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: _pageList,
        ),
    );
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
              _buildTile("GPT translator", 0),
              _buildTile("profile", 1),
              const Divider(
                height: 10,
                thickness: 2,
                color: Colors.grey,
              ),
              SizedBox(
                  height: 50,
                  child:ListTile(
                    title: Text('logout',style: const TextStyle(fontSize: 20),),
                    onTap: () {
                      setState(() {
                        _signOut(context);
                      });

                    },
                  )
              )

            ],
          ),
        ),
    );
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
      ),
    );
  }
}
