import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:history_app/config/theme/responsive.dart';
import 'package:history_app/domain/repositories/cluod_database_repository.dart';
import 'package:history_app/infraestructure/repositories/cloud_database_repository_impl.dart';
import 'package:history_app/presentation/screens/screens.dart';

part 'navigation_controller.dart';
part 'navigation_binding.dart';


class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  final controller = Get.find<NavigationController>();

  @override
  void initState()  {
    super.initState();
    controller.loadNumberOfHitos();
    Get.put(GalleryController());
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final colors = Theme.of(context).colorScheme;

    return Obx(() => controller.totalHitos == 0
      ? const Scaffold(body: Center(child: CircularProgressIndicator()))
      : Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller.pageController,
          children: const [
            HomePage(),
            GalleryPage()
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
      )
    );
  }
}