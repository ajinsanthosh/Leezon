import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leezon/screen/chatbot/ChatScreen.dart';
import 'package:leezon/screen/home/homescreen.dart';
import 'package:leezon/screen/profile/profile.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller= Get.put(NavigationController());

    return Scaffold(
      bottomNavigationBar: Obx(
        ()=> NavigationBar(
          height: 80,
          backgroundColor: Colors.white,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index)=>controller.selectedIndex.value=index,
        
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
            NavigationDestination(icon: Icon(Icons.photo_library), label: 'Library'),
            NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),

      body: Obx(()=> controller.screens[controller.selectedIndex.value])
    );
  }
}


class  NavigationController extends GetxController{
  final Rx<int> selectedIndex=0.obs;

  final screens=[ 
    const Homescreen(),
    const ChatScreen(),
    (Container(color: const Color.fromARGB(255, 19, 218, 19),)),
    const ProfilePage()
    ];
  
}
