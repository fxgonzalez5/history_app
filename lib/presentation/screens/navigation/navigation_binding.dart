part of 'navigation_page.dart';

class NavigationBinding implements Bindings {
@override
void dependencies() {
    Get.lazyPut<UserController>(() => UserController());
  }
}