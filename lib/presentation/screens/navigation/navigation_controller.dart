part of 'navigation_screen.dart';

class NavigationController extends GetxController {
  final RxInt _selectMenuItem = 0.obs;
  final RxBool animate = true.obs;
  final PageController pageController = PageController();

  int get selectMenuItem => _selectMenuItem.value;

  set selectMenuItem(int index) {
    _selectMenuItem.value = index;
    if (animate.value) {
      pageController.animateToPage(index, duration: const Duration(milliseconds: 350), curve: Curves.easeOut);
    } else {
      pageController.jumpToPage(index);
      animate.value = true;
    }
  }
}