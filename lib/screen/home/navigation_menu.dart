import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:leezon/provider/NavigationProvider.dart';
import 'package:leezon/screen/home/homescreen.dart';
import 'package:leezon/screen/library/screen_library.dart';
import 'package:leezon/screen/profile/profile.dart';
import 'package:leezon/utility/pallete.dart';
import 'package:provider/provider.dart';

class NavigationMenu extends StatefulWidget {
  final int initialIndex;

  const NavigationMenu({super.key, this.initialIndex = 0});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // List of screens
  final List<Widget> _screens = [
    const Homescreen(),
    const ScreenLibrary(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationProvider>(
      builder: (context, navigationProvider, child) {
        return Scaffold(
          body: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(), 
            children: _screens,
            onPageChanged: (index) {
             
              navigationProvider.setCurrentIndex(index);
            },
          ),
          bottomNavigationBar: Container(
            color: Pallete.whiteColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10), 
              child: GNav(
                gap: 15,
                backgroundColor: Pallete.whiteColor,
                color:Pallete.blackColor,
                activeColor: Pallete.whiteColor,
                tabBackgroundColor:Pallete.blackColor,
              //  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10), // Adjusted padding for GNav
                onTabChange: (index) {
                  
                  _pageController.jumpToPage(index);
                  navigationProvider.setCurrentIndex(index);
                },
                tabs: _buildGButtons(navigationProvider.currentIndex),
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
      iconColor: isActive ? Colors.white :Pallete.blackColor,
      iconActiveColor: Pallete.whiteColor,
      textColor: Pallete.whiteColor,
      iconSize: 20, 
      padding: const EdgeInsets.all(16), 
      leading: isActive
          ? null
          : ClipOval(
              child: Container(
                color: Colors.grey.shade300,
                child: Padding(
                  padding: const EdgeInsets.all(15), 
                  child: Icon(
                    info['icon'],
                    size: 23, 
                    color:Pallete.blackColor,
                  ),
                ),
              ),
            ),
    );
  }).toList();
}
