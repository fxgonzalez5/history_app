part of 'navigation_page.dart';

class NavigationController extends GetxController {
  final RxInt _selectMenuItem = 0.obs;
  final RxBool animate = true.obs;
  final PageController pageController = PageController();
  final CloudDatabaseRepository cloudDatabaseRepository = Get.find<CloudDatabaseRepositoryImpl>();
  final RxInt _totalHitos = 0.obs;

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

  int get totalHitos => _totalHitos.value;
  set totalHitos(int value) => _totalHitos.value = value;

  Future<void> loadNumberOfHitos() async {
    totalHitos = await cloudDatabaseRepository.getNumberOfHitos();
  }
}