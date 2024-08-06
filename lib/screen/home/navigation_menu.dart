import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:leezon/provider/chat_provider.dart';
import 'package:leezon/screen/home/homescreen.dart';
import 'package:leezon/screen/library/screen_library.dart';
import 'package:leezon/screen/profile/profile.dart';
import 'package:provider/provider.dart';

class NavigationMenu extends StatefulWidget {
  NavigationMenu({Key? key}) : super(key: key);

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // list of screens
  final List<Widget> _screens = [
    const Homescreen(),
    const ScreenLibrary(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, chatProvider, child) {
        return Scaffold(
          body: PageView(
            controller: _pageController,
            children: _screens,
            onPageChanged: (index) {
              chatProvider.setCurrentIndex(newIndex: index);
            },
          ),
          bottomNavigationBar: Container(
            color: Colors.white,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
              child: GNav(
                gap: 20,
                backgroundColor: Colors.white,
                color: Colors.black,
                activeColor: Colors.white,
                tabBackgroundColor: Colors.black,
                padding: const EdgeInsets.all(16),
                onTabChange: (index) {
                  chatProvider.setCurrentIndex(newIndex: index);
                  _pageController.jumpToPage(index);
                },
                tabs: _buildGButtons(chatProvider.currentIndex),
                
              ),
            ),
          ),
        );
      },
    );
  }
}

List<GButton> _buildGButtons(int currentIndex) {
  List<Map<String, dynamic>> buttonInfo = [
    {'icon': Icons.home, 'text': 'Home'},
    {'icon': Icons.library_add, 'text': 'Library'},
    {'icon': Icons.person, 'text': 'Profile'},
  ];
  return buttonInfo.map((info) {
    bool isActive = buttonInfo.indexOf(info) == currentIndex;
    return GButton(
      icon: info['icon'],
      text: info['text'],
      iconColor: Colors.white,
      iconActiveColor: Colors.white,
      iconSize: 24,
      textColor: Colors.white,
      padding: const EdgeInsets.all(16),
      leading: isActive
          ? null
          : ClipOval(
              child: Container(
                color: Colors.grey.shade300,
                child: Padding(
                  padding: const EdgeInsets.all(10), // Adjust the padding to increase the size
                  child: Icon(
                    info['icon'],
                    size: 30,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
    );
  }).toList();
}
