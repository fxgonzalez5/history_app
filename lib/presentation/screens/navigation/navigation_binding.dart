part of 'navigation_screen.dart';

class NavigationBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<NavigationController>(() => NavigationController());
  Get.put(GalleryController());
  }
}