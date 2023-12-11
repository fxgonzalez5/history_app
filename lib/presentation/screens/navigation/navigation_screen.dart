import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:history_app/config/theme/responsive.dart';
import 'package:history_app/presentation/screens/screens.dart';

part 'navigation_controller.dart';
part 'navigation_binding.dart';


class NavigationScreen extends GetView<NavigationController> {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller.pageController,
        children: const [
          HomeScreen(),
          GalleryScreen()
        ],
      ),

      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          backgroundColor: colors.primary,
          iconSize: responsive.ip(3),
          unselectedItemColor: Colors.black45,
          selectedItemColor: Colors.white,
          showUnselectedLabels: false,
          elevation: 0,
          currentIndex: controller.selectMenuItem,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Inicio'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.photo_library_outlined),
              label: 'Mi Galería'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info_outline),
              label: 'Información'
            ),
          ],
          onTap: (int index) => controller.selectMenuItem = index,
        ),
      ),
    );
  }
}