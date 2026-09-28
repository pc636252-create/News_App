import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/Routes/App_Routes.dart';
import '../../Screen_controllers/BottomNevigation.dart';
import '../HomeScreen/HomeScreen.dart';
import '../PopularTagsScreen/PopularTagsScreen.dart';
import '../ProfileScreen/ProfileScreen.dart';

class NavigationScreen extends GetView<NavigationController> {
  NavigationScreen({super.key});

  final List<Widget> screens = [
    HomeScreen(),
    PopularTags(),
    Center(child: Text('Add Screen (Center)')),
    Center(child: Text('Poll Screen')),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(
        index: controller.selectedIndex.value,
        children: screens,
      )),
      extendBody: true,
      floatingActionButton: Container(
        margin: const EdgeInsets.only(top: 10),
        child: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: const Color(0xFF38B6FF),
          elevation: 4.0,
          onPressed: () {
            Get.toNamed(AppRoutes.post);
          },
          child: const Icon(Icons.add, size: 34, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          BottomAppBar(
            padding: EdgeInsets.zero,
            notchMargin: 7.0,
            clipBehavior: Clip.antiAlias,
            shape: const CircularNotchedRectangle(),
            color: Colors.grey.shade50,
            elevation: 16.0,
            child: Container(
              height: 65,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildNavItem(controller, 0, Icons.home, 'Home'),
                        _buildNavItem(controller, 1, Icons.add_chart_sharp, 'Ads'),
                      ],
                    ),
                  ),
                  const SizedBox(width: 70),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildNavItem(controller, 3, Icons.ballot_outlined, 'Poll'),
                        _buildProfileItem(controller, 4, 'Profile'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 6,
            child: Text(
              'Add Post',
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey[500],
                fontWeight: FontWeight.w500,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(NavigationController controller, int index, IconData icon, String label) {
    return Obx(() {
      final isSelected = controller.selectedIndex.value == index;
      const activeColor = Color(0xFF38B6FF);
      final inactiveColor = Colors.grey[600]!;

      return GestureDetector(
        onTap: () => controller.changeIndex(index),
        behavior: HitTestBehavior.opaque,
        child: SizedBox(
          width: 55,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                margin: const EdgeInsets.only(bottom: 4),
                height: 2.5,
                width: isSelected ? 24 : 0,
                decoration: BoxDecoration(
                  color: activeColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Icon(
                icon,
                color: isSelected ? activeColor : inactiveColor,
                size: 24,
              ),
              const SizedBox(height: 3),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  color: isSelected ? activeColor : inactiveColor,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildProfileItem(NavigationController controller, int index, String label) {
    return Obx(() {
      final isSelected = controller.selectedIndex.value == index;
      const activeColor = Color(0xFF38B6FF);
      final inactiveColor = Colors.grey[600]!;

      return GestureDetector(
        onTap: () => controller.changeIndex(index),
        behavior: HitTestBehavior.opaque,
        child: SizedBox(
          width: 55,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                margin: const EdgeInsets.only(bottom: 4),
                height: 2.5,
                width: isSelected ? 24 : 0,
                decoration: BoxDecoration(
                  color: activeColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Container(
                width: 23,
                height: 23,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? activeColor : Colors.grey[300]!,
                    width: 1.5,
                  ),
                ),
                child: const ClipOval(
                  child: Image(
                    image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcReLot1KDBJ34JVuTjEa3QKyrif2TAtB4BfonVunN-5Kg&s=10'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 3),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  color: isSelected ? activeColor : inactiveColor,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
